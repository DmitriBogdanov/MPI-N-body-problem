#include <iostream>
#include <iomanip>

#include "Nbody.hpp"
#include "Nbody_mpi.hpp"
#include "static_timer.hpp"
#include "table.hpp"


// # Config #
const T TIME_INTERVAL = 20;
const size_t ITERATIONS = 2000;
const size_t TIME_LAYER_EXPORT_STEP = ITERATIONS / 20;
	// set 'TIME_LAYER_EXPORT_STEP > ITERATIONS'
	// to benhmark without accounting for writes

      std::string input_filename    = "[input]/{4_body_test}[bodies].txt";
const std::string OUTPUT_FOLDER     = "[output]/[positions]";
const std::string OUTPUT_FOLDER_MPI = "[output]/{mpi}[positions]";

bool BENCHMARK_MODE = false;
bool TEST_CONVERGENCE_ORDER = false;
bool USE_RANDOM_BODIES = true;

// # Random config #
const size_t RANDOM_N = 320;
const T RANDOM_M_MIN = 1, RANDOM_M_MAX = 10; // mass (range)
const T RANDOM_R_MIN = 30, RANDOM_R_MAX = 32; // position(spherical section)
const T RANDOM_V_MIN = 1, RANDOM_V_MAX = 2; // velocity (range)
const std::string RANDOM_FILENAME = "[input]/[generated_random_bodies].txt";

// # Convergence test config #
const std::string OUTPUT_FOLDER_ORDER_TEST_1 = "[output]/{order_test_1}[positions]";
const std::string OUTPUT_FOLDER_ORDER_TEST_2 = "[output]/{order_test_2}[positions]";
const std::string OUTPUT_FOLDER_ORDER_TEST_3 = "[output]/{order_test_3}[positions]";
const T q = 2;


// Input format: 
// N - number of bodies
// m1 x10 y10 z10 Vx10 Vy10 Vz10 - mass, position, velocity (1-st body)
// ...
// mN xN0 yN0 zN0 VxN0 VyN0 VzN0 - mass, position, velocity (N-th body)
//
void parse_bodies_from_file(
	const std::string &input_filename,
	ArrayOfBodies &bodies
) {
	std::ifstream inFile(input_filename);
	if (!inFile.is_open()) exit_with_error("Could not open input file");

	size_t N;
	inFile >> N;
	bodies.reserve(N);

	Body body;
	for (size_t i = 0; i < N; ++i) {
		inFile
			>> body.mass
			>> body.position.x >> body.position.y >> body.position.z
			>> body.velocity.x >> body.velocity.y >> body.velocity.z;

		bodies.push_back(std::move(body));
	}
}

// Generates N bodies uniformly distributed inside a sphere (or spherical layer)
void generate_random_input(
	size_t N,
	T m_min, T m_max, // mass (range)
	T r_min, T r_max, // position (spherical layer)
	T v_min, T v_max, // velocity (range) (velocities have random directions)
	const std::string &filename
) {
	srand(1);

	std::ofstream outFile(filename);
	if (!outFile.is_open()) exit_with_error("Could not open file " + filename);

	outFile
		<< N << '\n';
	
	for (size_t i = 0; i < N; ++i) {
		const T mass  = rand_T(m_min, m_max);
		const Vec3 position = make_random_vector(r_min, r_max);
		const Vec3 velocity = make_random_vector(v_min, v_max);

		outFile
			<< mass << ' '
			<< position.x << ' ' << position.y << ' ' << position.z << ' '
			<< velocity.x << ' ' << velocity.y << ' ' << velocity.z << '\n';
	}
}


int main(int argc, char* argv[]) {
	// ------------------
	// --- Set up MPI ---
	// ------------------

	MPI_Init(&argc, &argv);

	// Get rank and size
	int MPI_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &MPI_rank);

	int MPI_size;
	MPI_Comm_size(MPI_COMM_WORLD, &MPI_size);

	std::cout << "Rank " << MPI_rank << "/" << MPI_size << " initialized" << std::endl;
	MPI_Barrier(MPI_COMM_WORLD);

	// ----------------------------
	// --- Parsing input on {0} ---
	// ----------------------------
	ArrayOfBodies bodies; // each process has to store ALL bodies

	if (MPI_rank == 0) {
		StaticTimer::start();
		std::cout << ">>> Parsing input...\n";

		// Generate random bodies if 'USE_RANDOM_BODIES' is selected
		if (USE_RANDOM_BODIES) {
			generate_random_input(
				RANDOM_N,
				RANDOM_M_MIN, RANDOM_M_MAX,
				RANDOM_R_MIN, RANDOM_R_MAX,
				RANDOM_V_MIN, RANDOM_V_MAX,
				RANDOM_FILENAME
			);

			input_filename = RANDOM_FILENAME;
		}

		// Parse bodies
		parse_bodies_from_file(input_filename, bodies);

		// Display config
		std::cout
			<< "\n"
			<< "Parsed in " << StaticTimer::end() << "sec\n"
			<< "--------------------------------------------------\n"
			<< "Input file    -> " << input_filename << "\n"
			<< "Output folder -> " << OUTPUT_FOLDER << "\n"
			<< "Order test    -> " << bool_to_str(TEST_CONVERGENCE_ORDER) << "\n"
			<< "Mode          -> " << (BENCHMARK_MODE ? "BENCHMARK" : "DEFAULT") << "\n"
			<< "N             =  " << bodies.size() << "\n"
			<< "Time interval =  " << TIME_INTERVAL << "\n"
			<< "Iterations    =  " << ITERATIONS << "\n"
			<< "Step          =  " << TIME_INTERVAL / ITERATIONS << "\n"
			<< "Export step   =  " << TIME_LAYER_EXPORT_STEP << "\n"
			<< "--------------------------------------------------\n" << std::endl;
	}

	// -----------------------------
	// --- Set datatype for Vec3 ---
	// -----------------------------
	MPI_Datatype MPI_VEC3;
	{
		int membercount = 3;
		int blocklengths[] = {
			1, 1, 1
		};
		MPI_Datatype types[] = {
			MPI_T, MPI_T, MPI_T
		};
		MPI_Aint offsets[] = {
			offsetof(Vec3, x), offsetof(Vec3, y), offsetof(Vec3, z)
		};

		MPI_Type_create_struct(membercount, blocklengths, offsets, types, &MPI_VEC3);
		MPI_Type_commit(&MPI_VEC3);
	}

	// -----------------------------
	// --- Set datatype for Body ---
	// -----------------------------
	MPI_Datatype MPI_BODY;
	{
		int membercount = 7;
		int blocklengths[] = {
			1,
			1, 1, 1,
			1, 1, 1
		};
		MPI_Datatype types[] = {
			MPI_T,
			MPI_T, MPI_T, MPI_T,
			MPI_T, MPI_T, MPI_T
		};
		MPI_Aint offsets[] = {
			offsetof(Body, mass),
			offsetof(Body, position.x), offsetof(Body, position.y), offsetof(Body, position.z),
			offsetof(Body, velocity.x), offsetof(Body, velocity.y), offsetof(Body, velocity.z)
		};

		MPI_Type_create_struct(membercount, blocklengths, offsets, types, &MPI_BODY);
		MPI_Type_commit(&MPI_BODY);
	}

	// ----------------------------------------
	// --- Broadcast parsed bodies from {0} ---
	// ----------------------------------------
	int N = bodies.size();
	MPI_Bcast(&N, 1, MPI_INT, 0, MPI_COMM_WORLD);

	if (MPI_rank != 0) bodies.resize(N);
	MPI_Bcast(bodies.data(), bodies.size(), MPI_BODY, 0, MPI_COMM_WORLD);
	
	// ---------------
	// --- Methods ---
	// ---------------
	if (bodies.size() % MPI_size != 0) exit_with_error("N is not divisible by MPI_size");

	double timeSerial   = -1;
	double timeParallel = -1;

	// Draw a table
	if (MPI_rank == 0) {
		table_add_1("Method");
		table_add_2("Time (sec)");
		table_add_3("Speedup");
		table_hline();
	}

	// ------------------------
	// --- 1) Serial method ---
	// ------------------------

	if (MPI_rank == 0) {
		// 1. Method
		table_add_1("Serial");

		// 2. Time
		StaticTimer::start();
		nbody_serial(
			bodies, TIME_INTERVAL, ITERATIONS, TIME_LAYER_EXPORT_STEP, OUTPUT_FOLDER, BENCHMARK_MODE
		);
		timeSerial = StaticTimer::end();

		table_add_2(timeSerial);

		// 3. Speedup
		table_add_3(timeSerial / timeSerial);
	}

	// --------------------------
	// --- 2) Parallel method ---
	// --------------------------

	// 1. Method
	if (MPI_rank == 0) table_add_1("Parallel");

	// 2. Time
	MPI_Barrier(MPI_COMM_WORLD);

	if (MPI_rank == 0) StaticTimer::start();
	nbody_mpi(
		MPI_rank, MPI_size, MPI_VEC3, MPI_BODY,
		bodies, TIME_INTERVAL, ITERATIONS, TIME_LAYER_EXPORT_STEP, OUTPUT_FOLDER_MPI, BENCHMARK_MODE
	);
	MPI_Barrier(MPI_COMM_WORLD);

	if (MPI_rank == 0) {
		timeParallel = StaticTimer::end();

		table_add_2(timeParallel);

		// 3. Speedup
		table_add_3(timeSerial / timeParallel);
	}
	 
	// ---------------------------------
	// --- *) Convergence order test ---
	// ---------------------------------
	if (MPI_rank == 0 && !BENCHMARK_MODE && TEST_CONVERGENCE_ORDER) {
		nbody_serial(bodies, TIME_INTERVAL, ITERATIONS, TIME_LAYER_EXPORT_STEP, OUTPUT_FOLDER_ORDER_TEST_1);
		nbody_serial(bodies, TIME_INTERVAL, q * ITERATIONS, q * TIME_LAYER_EXPORT_STEP, OUTPUT_FOLDER_ORDER_TEST_2);
		nbody_serial(bodies, TIME_INTERVAL, q * q * ITERATIONS, q * q * TIME_LAYER_EXPORT_STEP, OUTPUT_FOLDER_ORDER_TEST_3);
	}

	if (MPI_rank == 0) std::cout << std::endl;
	MPI_Barrier(MPI_COMM_WORLD);

	std::cout << "Rank " << MPI_rank << " finalized" << std::endl;

	MPI_Type_free(&MPI_VEC3);
	MPI_Type_free(&MPI_BODY);
	MPI_Finalize();

	return 0;
}