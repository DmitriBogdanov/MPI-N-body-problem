#include <iostream>
#include <iomanip>

#include "Nbody.hpp"
#include "static_timer.hpp"
#include "table.hpp"


// # Config #
const T TIME_INTERVAL = 20;
const size_t ITERATIONS = 2000;
const size_t TIME_LAYER_EXPORT_STEP = 10;
	// set 'TIME_LAYER_EXPORT_STEP > ITERATIONS'
	// to benhmark without accounting for writes

      std::string input_filename = "[input]/{4_body_test}[bodies].txt";
const std::string OUTPUT_FOLDER  = "[output]/[positions]";

// # Random config #
bool USE_RANDOM_BODIES = false;

const size_t RANDOM_N = 40;
const T RANDOM_M_MIN = 1, RANDOM_M_MAX = 10; // mass (range)
const T RANDOM_R_MIN = 30, RANDOM_R_MAX = 32; // position(spherical section)
const T RANDOM_V_MIN = 1, RANDOM_V_MAX = 2; // velocity (range)
const std::string RANDOM_FILENAME = "[input]/[generated_random_bodies].txt";


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
	ArrayOfBodies bodies;
	parse_bodies_from_file(input_filename, bodies);

	// Method
	nbody_serial(bodies, TIME_INTERVAL, ITERATIONS, TIME_LAYER_EXPORT_STEP, OUTPUT_FOLDER);
}

