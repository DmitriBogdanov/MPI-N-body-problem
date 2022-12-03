#include <iostream>
#include <iomanip>

#include "nbody_serial.hpp"
#include "nbody_mpi.hpp"
#include "body_parsing.hpp"
#include "static_timer.hpp"
#include "table.hpp"


// # Config #
const T TIME_INTERVAL = 20; //2.419e+6; // 28 days
const size_t ITERATIONS = 2000;
const size_t TIME_LAYER_EXPORT_STEP = ITERATIONS / 200;
	// set 'TIME_LAYER_EXPORT_STEP > ITERATIONS'
	// to benhmark without accounting for writes

const std::string input_filename    = "[input]/{4_body_test}[bodies].txt";
const std::string OUTPUT_FOLDER     = "[output]/[positions]";
const std::string OUTPUT_FOLDER_MPI = "[output]/{mpi}[positions]";

bool BENCHMARK_MODE = false;
bool TEST_CONVERGENCE_ORDER = true;
bool USE_RANDOM_BODIES = false;

// # Random config #
const size_t RANDOM_N = 3200;
const T RANDOM_M_MIN = 5e4, RANDOM_M_MAX = 50e4; // mass (range)
const T RANDOM_R_MIN = 10, RANDOM_R_MAX = 100; // position(spherical section)
const T RANDOM_V_MIN = 1, RANDOM_V_MAX = 5; // velocity (range)
const std::string RANDOM_FILENAME = "[input]/[generated_random_bodies].txt";

// # Convergence test config #
const std::string OUTPUT_FOLDER_ORDER_TEST_1 = "[output]/{order_test_1}[positions]";
const std::string OUTPUT_FOLDER_ORDER_TEST_2 = "[output]/{order_test_2}[positions]";
const std::string OUTPUT_FOLDER_ORDER_TEST_3 = "[output]/{order_test_3}[positions]";
const T q = 2;


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

		// Get bodies
		bodies = USE_RANDOM_BODIES
			// Generate random bodies if 'USE_RANDOM_BODIES' is selected
			? generate_random_input(
				RANDOM_N,
				RANDOM_M_MIN, RANDOM_M_MAX,
				RANDOM_R_MIN, RANDOM_R_MAX,
				RANDOM_V_MIN, RANDOM_V_MAX
			)
			// Parse bodies otherwise
			: parse_bodies_from_file(input_filename);

		// Display config
		std::cout
			<< "\n"
			<< "Parsed in " << StaticTimer::end() << "sec\n"
			<< "--------------------------------------------------\n"
			<< "Input file    -> " << (USE_RANDOM_BODIES ? "<random bodies are generated>" : input_filename) << "\n"
			<< "Output folder -> " << OUTPUT_FOLDER << "\n"
			<< "Order test    -> " << bool_to_str(TEST_CONVERGENCE_ORDER) << "\n"
			<< "Mode          -> " << (BENCHMARK_MODE ? "BENCHMARK" : "DEFAULT") << "\n"
			<< "Type          -> " << typeid(T).name() << "\n"
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

	// -----------------------------------
	// --- Part type for Body.position ---
	// -----------------------------------
	MPI_Datatype MPI_BODY_PART_TMP;
	MPI_Datatype MPI_BODY_PART;
	{
		int membercount = 3;
		int blocklengths[] = {
			1, 1, 1
		};
		MPI_Datatype types[] = {
			MPI_T, MPI_T, MPI_T
		};
		MPI_Aint offsets[] = {
			offsetof(Body, position.x), offsetof(Body, position.y), offsetof(Body, position.z)
		};

		MPI_Type_create_struct(membercount, blocklengths, offsets, types, &MPI_BODY_PART_TMP);

		MPI_Aint lb, extent;
		MPI_Type_get_extent(MPI_BODY, &lb, &extent);

		MPI_Type_create_resized(MPI_BODY_PART_TMP, lb, extent, &MPI_BODY_PART);
		MPI_Type_commit(&MPI_BODY_PART);
	}

	// ----------------------------------------
	// --- Broadcast parsed bodies from {0} ---
	// ----------------------------------------
	int N = bodies.size();
	MPI_Barrier(MPI_COMM_WORLD);
	MPI_Bcast(&N, 1, MPI_INT, 0, MPI_COMM_WORLD);

	if (MPI_rank != 0) bodies.resize(N);
	MPI_Bcast(bodies.data(), bodies.size(), MPI_BODY, 0, MPI_COMM_WORLD);

	// ---------------
	// --- Methods ---
	// ---------------
	double timeSerial = -1;
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
	if (bodies.size() % MPI_size != 0) exit_with_error("N is not divisible by MPI_size");

	// 1. Method
	if (MPI_rank == 0) table_add_1("Parallel");

	// 2. Time
	MPI_Barrier(MPI_COMM_WORLD);

	if (MPI_rank == 0) StaticTimer::start();
	nbody_mpi(
		MPI_rank, MPI_size, MPI_VEC3, MPI_BODY_PART,
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
	MPI_Type_free(&MPI_BODY_PART_TMP);
	MPI_Type_free(&MPI_BODY_PART);
	MPI_Finalize();

	return 0;
}