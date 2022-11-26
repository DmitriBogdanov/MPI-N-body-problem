#pragma once

#include <vector>
#include <filesystem>

#include "static_timer.hpp"
#include "point_particle.hpp"

const T G = 6.67e-11;
const T EPSILON = 1e-10;

template <typename T>
inline T pow32(T pow2)
{
	return pow2 * sqrt(pow2);
}

inline Vec3 acceleration(const Vec3 &dr, T mass) {
	return dr * (mass / std::max(/*cube(dr.norm())*/pow32(dr.norm2()), cube(EPSILON)));
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

	const std::streamsize PRECISION = 17;

	for (size_t i = 0; i < N; ++i) {

		outFile.open(filenames[i], std::ios::app); // open for append
		if (!outFile.is_open()) exit_with_error("Could not open output file " + filenames[i]);

		outFile
			<< std::setprecision(PRECISION) << t << ' '
			<< std::setprecision(PRECISION) << bodies[i].position.x << ' '
			<< std::setprecision(PRECISION) << bodies[i].position.y << ' '
			<< std::setprecision(PRECISION) << bodies[i].position.z << '\n';

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
	const T htau = tau / 2;

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
	for (size_t s = 0; s < iterations; s++) {
		StaticTimer::start();

		// ---------------------
		// --- Runge-Kutta 2 ---
		// ---------------------

		copy(bodies, temp_bodies);

		// k1 = f(t_n, y_n)
		// k2 = f(t_n + tau, y_n + tau * k1 )
		Vec3 tmp;
		for (size_t i = 0; i < N; ++i) {
			tmp = { 0, 0, 0 };
			const Vec3& posI = bodies[i].position;
			for (size_t j = 0; j < N; ++j) if (i != j)
				tmp -= acceleration(posI - bodies[j].position, bodies[j].mass);

			a[i] = tmp;

			temp_bodies[i].position += bodies[i].velocity * tau;
			temp_bodies[i].velocity += tmp * (tau * G);
		}

		// y_n+1 = y_n + tau * k2
		for (size_t i = 0; i < N; ++i) {
			temp_a = { 0, 0, 0 };
			const Vec3& tposI = temp_bodies[i].position;
			for (size_t j = 0; j < N; ++j) if (i != j)
				temp_a -= acceleration(tposI - temp_bodies[j].position, bodies[j].mass);

			bodies[i].position += (bodies[i].velocity + temp_bodies[i].velocity) * htau;
			bodies[i].velocity += (a[i] + temp_a) * (G * htau);
		}

		// Export time layer with respect to 'TIME_LAYER_EXPORT_STEP'
		if (!((s + 1) % time_layer_export_step)) export_time_layer(tau * (s + 1), bodies, filenames);

		std::cout << StaticTimer::end() << " sec\n";
	}


}


///
//for (size_t i = 0; i < N; ++i) {
//	temp_a = { 0, 0, 0 };
//	for (size_t j = 0; j < N; ++j) if (i != j)
//		temp_a -= acceleration(temp_bodies[i].position - temp_bodies[j].position, bodies[j].mass);
//
//	bodies[i].position += (bodies[i].velocity + temp_bodies[i].velocity) * tau * 0.5;
//	bodies[i].velocity += (a[i] + temp_a) * tau * 0.5;
//}

/// asda
//// k1 = f(t_n, y_n)
//for (size_t i = 0; i < N; ++i) {
//	a[i] = { 0, 0, 0 };
//	for (size_t j = 0; j < N; ++j) if (i != j)
//		a[i] -= acceleration(bodies[i].position - bodies[j].position, bodies[j].mass);
//
//	temp_bodies[i].position += bodies[i].velocity * tau;
//	temp_bodies[i].velocity += a[i] * tau;
//}
//// y_n+1 = y_n + tau * (f(t_n + tau / 2, y_n + tau / 2 * k1) 
//for (size_t i = 0; i < N; ++i) {
//	temp_a = { 0, 0, 0 };
//	for (size_t j = 0; j < N; ++j) if (i != j)
//		temp_a -= acceleration(temp_bodies[i].position - temp_bodies[j].position, temp_bodies[j].mass);
//
//	bodies[i].position += (bodies[i].velocity + temp_bodies[i].velocity * tau / 2) * tau;
//	bodies[i].velocity += (a[i] + temp_a * tau / 2) * tau;
//}

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