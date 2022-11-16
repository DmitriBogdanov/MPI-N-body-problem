#pragma once

#include <vector>

#include "utils.hpp"
#include "vec3.hpp"

const T G = 6.67e-11;



void nbody(
	size_t N,
	T* const masses,
	const std::vector<Vec3> &initial_positions,
	const std::vector<Vec3> &initial_velocities,
	T tau /* time step */, T time_interval
) {
	std::vector<Vec3> positions  = initial_positions;
	std::vector<Vec3> velocities = initial_velocities;

	const size_t ODE_size     = 2 * N; // actual size is 3 times larges since we operate on 3D vectors
	const size_t ODE_halfsize = N;

	// Allocate space for RK4
	std::vector<Vec3> right_part(ODE_size);

	std::vector<Vec3> sol;

	// ---------------------------
	// --- Iteration over time ---
	// ---------------------------
	for (T t = 0; t < time_interval; t += tau) {

		// Fill velocities (1st half of right_part)
		for (size_t i = 0; i < N; ++i) {
			right_part[i] = velocities[i];
		}

		// Compute gravity acceleration (2nd half of right_part)
		for (size_t i = 0; i < N; ++i) {
			for (size_t j = 0; j < N; ++j) {
				const auto dr = positions[j] - positions[i];

				if (i != j) right_part[ODE_halfsize + i] += dr * G * masses[i] * masses[j] / cube(dr.norm());
			}
		}

		// Explicit Euler iteration
		/// Replace with RK4
		/// Perhaps should implement in-place matrix operations so we don't have to suffer with so many loops
		for (size_t i = 0; i < ODE_size; ++i) {
			sol[i] += right_part[i] * tau;
		}
		
		/// Write time layer to file
	}
}