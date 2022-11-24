#pragma once

#include <vector>
#include <filesystem>

#include "point_particle.hpp"

const T G = 6.67e-11;

inline Vec3 acceleration(const Vec3 & dr, T mass) {
	return(dr * G * mass / cube(dr.norm()));
}

inline Vec3 acceleration(const Vec3 & dr, T mass, T epsilon) {
	return( dr * G * mass / std::max(cube(dr.norm()), cube(epsilon)) );
}

// Initial data has certain format: 
// N - number of bodies
// m1 x10 y10 z10 Vx10 Vy10 Vz10 - mass, initial coordinates and velocities of the first body
// ...
// mN xN0 yN0 zN0 VxN0 VyN0 VzN0 - mass, initial coordinates and velocities of the last body
void import_initial_data(SpaceVec & bodies, 
						 size_t& N,		
						 const std::string & data_filename){
	std::ifstream inFile(data_filename);
	if (!inFile.is_open()) exit_with_error("Could not open input file");
	inFile >> N;
	outstream << "Number of bodies: " << N << "\n";
	bodies.reserve(N);

	std::vector<T> body(7, static_cast<T>(0));
	for(int i = 0; i < N; ++i){
		inFile >> body[0] >> body[1] >> body[2] >> body[3] >> body[4] >> body[5] >> body[6];
		bodies.push_back(body);
	}

	outstream << "Bodies: \n";
	for(auto &x: bodies)
		outstream << x.toString() << "\n";

}

void export_time_layer(const SpaceVec & bodies,
					   std::vector<std::string> & filenames,
					   size_t& N,
					   T step) {
	std::ofstream outFile;
	for (size_t i = 0; i < N; ++i) {
		outFile.open(filenames[i], std::ios::app);
		if (!outFile.is_open()) exit_with_error("Could not open output file " + filenames[i]);
		outFile << step << " " << bodies[i].x_.x << " " << bodies[i].x_.y << " " << bodies[i].x_.z << "\n";
		outFile.close();
	}
}

//void update_right_part(const SpaceVec& bodies, std::vector<Vec3> & right_part, const size_t N) {
//	// Fill velocities (1st half of right_part)
//	for (size_t i = 0; i < N; ++i) {
//		right_part[i] = bodies[i].V_;
//	}
//
//	// Compute gravity acceleration (2nd half of right_part)
//	for (size_t i = 0; i < N; ++i) {
//		right_part[N + i] = {0, 0, 0 };
//			for (size_t j = 0; j < N; ++j) {
//				//if (i != j) {
//				const auto dr = bodies[i].x_ - bodies[j].x_;
//				right_part[N + i] -= acceleration(dr, bodies[j].mass_, 1e-3);
//				//}
//			}
//	}
//}

void nbody(const std::string & init_data_filename, 
	       const std::string & res_data_foldername,
		   size_t iterations,  
		   T time_interval,
		   size_t divider
) {
	T tau = time_interval / iterations;
	SpaceVec bodies, temp_bodies;
	size_t N;
	import_initial_data(bodies, N, init_data_filename);
	import_initial_data(temp_bodies, N, init_data_filename);

	// Allocate space for Runge - Kutta method
	std::vector<std::string> filenames(N);

	// Fill filenames
	if (!std::filesystem::exists(res_data_foldername)) std::filesystem::create_directory(res_data_foldername);
	for (size_t i = 0; i < N; ++i) filenames[i]  = res_data_foldername + "/traj_" + std::to_string(i + 1) + ".txt";
	export_time_layer(bodies, filenames, N, 0);

	// ---------------------------
	// --- Iteration over time ---
	// ---------------------------
	for (size_t i = 0; i < iterations; i++) {
		// Explicit Euler iteration
		/*for (size_t i = 0; i < N; ++i) {
			Vec3 accel = { 0, 0, 0 };
			for (size_t j = 0; j < N; ++j) {
				const auto dr = bodies[i].x_ - bodies[j].x_;
				accel -= acceleration(dr, bodies[j].mass_, 1e-3);
			}
			bodies[i].x_ += bodies[i].V_ * tau;
			bodies[i].V_ += accel * tau;
		}*/
		// Explicit Runge - Kutta order 2
		std::vector<Vec3> accel(N);
		Vec3 accel_temp;
		for (size_t i = 0; i < N; ++i) {
			accel[i].x = 0;  accel[i].y = 0; accel[i].z = 0;
			for (size_t j = 0; j < N; ++j) {
				const auto dr = bodies[i].x_ - bodies[j].x_;
				accel[i] -= acceleration(dr, bodies[j].mass_, 1e-5);
			}
			temp_bodies[i].x_ += bodies[i].V_ * tau;
			temp_bodies[i].V_ += accel[i] * tau;
		}
		for (size_t i = 0; i < N; ++i) {
			accel_temp = { 0, 0, 0 };
			for (size_t j = 0; j < N; ++j) {
				const auto dr = temp_bodies[i].x_ - temp_bodies[j].x_;
				accel_temp -= acceleration(dr, temp_bodies[j].mass_, 1e-5);
			}
			bodies[i].x_ += (temp_bodies[i].V_ + bodies[i].V_) * tau / 2;
			bodies[i].V_ += (accel[i] + accel_temp) * tau / 2;
		}
		/// Write time layer to file if i % divider != 0 
		if(!((i + 1) % divider)) export_time_layer(bodies, filenames, N, tau * (i + 1));

		copy(bodies, temp_bodies);
	}
}