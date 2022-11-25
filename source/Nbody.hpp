#pragma once

#include <vector>
#include <filesystem>

#include "point_particle.hpp"

const T G = 6.67e-11;
const T EPSILON = 1e-5;

inline Vec3 acceleration(const Vec3 &dr, T mass) {
	return dr * G * mass / std::max(cube(dr.norm()), cube(EPSILON));
}

void clean_folder(const std::string &folder) {
	for (const auto &entry : std::filesystem::directory_iterator(folder))
		std::filesystem::remove_all(entry.path());
}

void create_empty_files(const std::vector<std::string> &filenames) {
	for (const auto &filename : filenames) {
		std::ofstream outFile(filename);
	}
}

void export_time_layer(
	T t,
	const ArrayOfBodies &bodies,
	const std::vector<std::string> &filenames
) {
	const size_t N = bodies.size();

	std::ofstream outFile;

	for (size_t i = 0; i < N; ++i) {

		outFile.open(filenames[i], std::ios::app); // open for append
		if (!outFile.is_open()) exit_with_error("Could not open output file " + filenames[i]);

		outFile
			<< t << ' '
			<< bodies[i].position.x << ' ' << bodies[i].position.y << ' ' << bodies[i].position.z << '\n';

		outFile.close();
	}
}


inline void nbody_serial(
	ArrayOfBodies bodies, // pas-by-copy since we're going to modify bodies localy 
	const T TIME_INTERVAL,
	const size_t iterations,  
	const size_t time_layer_export_step,
	const std::string &output_folder
) {
	const size_t N = bodies.size();
	const T tau = TIME_INTERVAL / iterations;

	// Each body stores it's positions in a separate file 'positions_<index>'
	// using 't  pos.x  pos.y  pos.z' format on each line

	// Setup filenames
	std::vector<std::string> filenames(N);
	for (size_t i = 0; i < N; ++i) filenames[i] = output_folder + "/positions_" + std::to_string(i + 1) + ".txt";

	// Ensure 'data' folder exists
	if (!std::filesystem::exists(output_folder)) std::filesystem::create_directory(output_folder);

	// Preallocate space for Runge-Kutta temp variables
	std::vector<Vec3> a(N);
	Vec3 temp_a;
	std::vector<Body> temp_bodies(N);

	// Reset files and export fiest time layer
	clean_folder(output_folder);
	create_empty_files(filenames);
	export_time_layer(T(0), bodies, filenames);

	// ---------------------------
	// --- Iteration over time ---
	// ---------------------------
	for (size_t i = 0; i < iterations; i++) {

		// ---------------------
		// --- Runge-Kutta 2 ---
		// ---------------------

		copy(bodies, temp_bodies);

		// k1 = f(t_n, y_n)
		for (size_t i = 0; i < N; ++i) {
			a[i] = { 0, 0, 0 };
			for (size_t j = 0; j < N; ++j)
				a[i] -= acceleration(bodies[i].position - bodies[j].position, bodies[j].mass);

			temp_bodies[i].position += bodies[i].velocity * tau;
			temp_bodies[i].velocity += a[i] * tau;
		}
		// y_n+1 = y_n + tau * f(t_n + 1/2 tau, y_n + 1/2 tau k1)
		for (size_t i = 0; i < N; ++i) {
			temp_a = { 0, 0, 0 };
			for (size_t j = 0; j < N; ++j)
				temp_a -= acceleration(temp_bodies[i].position - temp_bodies[j].position, temp_bodies[j].mass);

			bodies[i].position += (temp_bodies[i].velocity + bodies[i].velocity) * tau * T(0.5);
			bodies[i].velocity += (a[i] + temp_a) * tau * T(0.5);
		}

		// Export time layer with respect to 'TIME_LAYER_EXPORT_STEP'
		if(!((i + 1) % time_layer_export_step)) export_time_layer(tau * (i + 1), bodies, filenames);
	}
}



// Explicit Euler iteration
		/*for (size_t i = 0; i < N; ++i) {
			Vec3 accel = { 0, 0, 0 };
			for (size_t j = 0; j < N; ++j) {
				const auto dr = bodies[i].position - bodies[j].position;
				accel -= acceleration(dr, bodies[j].mass, 1e-3);
			}
			bodies[i].position += bodies[i].velocity * tau;
			bodies[i].velocity += accel * tau;
		}*/