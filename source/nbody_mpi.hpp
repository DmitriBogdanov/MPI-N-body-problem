#pragma once

#include <vector>
#include <filesystem>

#include "static_timer.hpp"
#include "point_particle.hpp"

#define RPRINT std::cout << "[" << MPI_rank << "]>" <<
#define RFLUSH << std::flush;


inline void nbody_mpi(
	int MPI_rank, int MPI_size, MPI_Datatype MPI_VEC3, MPI_Datatype MPI_BODY,
	ArrayOfBodies bodies, // pas-by-copy since we're going to modify bodies localy 
	const T TIME_INTERVAL,
	const size_t iterations,
	const size_t time_layer_export_step,
	const std::string &output_folder,
	const bool benchmark_mode = false
) {
	const size_t N = bodies.size();
	const T tau = TIME_INTERVAL / iterations;
	const T halftau = tau / 2;

	// Set up MPI alignments
	// Each process processes a 'block' of bodies
	const int   block_size        = N / MPI_size;
	const int   block_start_index = MPI_rank * block_size;

	std::vector<std::string> filenames;
	if (!benchmark_mode) {
		// Each body stores it's positions in a separate file 'positions_<index>'
		// using 't  pos.x  pos.y  pos.z' format on each line

		// Setup filenames
		filenames.resize(block_size);
		for (size_t i = 0; i < block_size; ++i)
			filenames[i] =
			output_folder + "/positions_" + std::to_string(block_start_index + i + 1) + ".txt";

		if (MPI_rank == 0) {
			// Ensure 'data' folder exists and is clean
			if (!std::filesystem::exists(output_folder)) std::filesystem::create_directory(output_folder);
			clean_folder(output_folder);
		}

		MPI_Barrier(MPI_COMM_WORLD); // Can't mess with the files until the folder is clean

		// Reset files and export first time layer
		create_empty_files(filenames);

		export_time_layer(T(0), bodies, filenames, block_start_index);
	}

	// Preallocate space for Runge-Kutta temp variables
	std::vector<Vec3> a(N);
	Vec3 temp_a;
	std::vector<Body> temp_bodies(N);

	// ---------------------------
	// --- Iteration over time ---
	// ---------------------------
	for (size_t step = 0; step < iterations; step++) {
		// ---------------------
		// --- Runge-Kutta 2 ---
		// ---------------------

		std::copy(bodies.begin(), bodies.end(), temp_bodies.begin());

		// k1 = f(t_n, y_n)
		// k2 = f(t_n + tau, y_n + tau * k1 )
		for (size_t i = block_start_index; i < block_start_index + block_size; ++i) {
			temp_a.set_zero();
			const Vec3& posI = bodies[i].position;
			for (size_t j = 0; j < N; ++j) if (i != j)
				temp_a -= acceleration(posI - bodies[j].position, bodies[j].mass);

			a[i] = temp_a;

			temp_bodies[i].position += bodies[i].velocity * tau;
			temp_bodies[i].velocity += temp_a * (tau * G);
		}

		MPI_Allgather(
			MPI_IN_PLACE, 0, MPI_DATATYPE_NULL,
			a.data(), block_size, MPI_VEC3,
			MPI_COMM_WORLD
		);
		MPI_Allgather(
			MPI_IN_PLACE, 0, MPI_DATATYPE_NULL,
			temp_bodies.data(), block_size, MPI_BODY,
			MPI_COMM_WORLD
		);

		// y_n+1 = y_n + tau * k2
		for (size_t i = block_start_index; i < block_start_index + block_size; ++i) {
			temp_a.set_zero();
			const Vec3& tposI = temp_bodies[i].position;
			for (size_t j = 0; j < N; ++j) if (i != j)
				temp_a -= acceleration(tposI - temp_bodies[j].position, bodies[j].mass);

			bodies[i].position += (bodies[i].velocity + temp_bodies[i].velocity) * halftau;
			bodies[i].velocity += (a[i] + temp_a) * (G * halftau);
		}

		MPI_Allgather(
			MPI_IN_PLACE, 0, MPI_DATATYPE_NULL,
			bodies.data(), block_size, MPI_BODY,
			MPI_COMM_WORLD
		);

		// Export time layer with respect to 'TIME_LAYER_EXPORT_STEP'
		if (!benchmark_mode && !((step + 1) % time_layer_export_step))
			export_time_layer(tau * (step + 1), bodies, filenames, block_start_index);
	}
}