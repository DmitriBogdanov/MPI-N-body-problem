#pragma once

#include "utils.hpp"
#include "vec3.hpp"

// Bodies are assumed to be material points
struct Body {
	T mass;
	Vec3 position;
	Vec3 velocity; 

	Body() = default;
	Body(T mass, Vec3 x, Vec3 V) : mass(mass), position(x), velocity(V) {};

	inline Body operator=(const Body &other) {
		this->position = other.position; this->velocity = other.velocity; this->mass = other.mass;
		return *this;
	}

	// Conversion
	inline std::string toString(const std::string &begin = "", const std::string &delimer = " ", const std::string &end = "") const {
		return begin +
			std::to_string(this->mass) + delimer +
			position.toString() + delimer +
			velocity.toString() + 
			end;
	}
};

using ArrayOfBodies = std::vector<Body>;

// ----------------------------------
// --- Utility for N-body problem ---
// ----------------------------------
inline Vec3 acceleration(const Vec3 &dr, T mass) { // does not multiply by G so we can multiply by it extarnally
	return dr * (mass / std::max(dr.norm3(), cube(DR_EPSILON)));
}

void export_time_layer(
	T t,
	const ArrayOfBodies &bodies,
	const std::vector<std::string> &filenames,
	int starting_from_body = 0 // allows us to export time layer partially starting at some body
) {
	const size_t N = filenames.size();

	std::ofstream outFile;

	const std::streamsize PRECISION = 17;

	/// Saving to a single memory-mapped file would be orders of magnitude faster, however we trade speed
	/// for debugging convenience and save positions to separate files for each body
	for (size_t i = 0; i < N; ++i) {

		outFile.open(filenames[i], std::ios::app); // open for append
		if (!outFile.is_open()) exit_with_error("Could not open output file " + filenames[i]);
			// we have to reopen and close files due to limitation on simultanious file handles 
			// (~a few hundred), otherwise keeping them open would be faster

		outFile
			<< std::setprecision(PRECISION) << t << ' '
			<< std::setprecision(PRECISION) << bodies[starting_from_body + i].position.x << ' '
			<< std::setprecision(PRECISION) << bodies[starting_from_body + i].position.y << ' '
			<< std::setprecision(PRECISION) << bodies[starting_from_body + i].position.z << '\n';

		outFile.close();
	}
}

/// TEMP
void print_array_of_bodies(int rank, const ArrayOfBodies &bodies) {

	std::string str;

	str.append("-> Rank {");
	str.append(std::to_string(rank));
	str.append("}: ");

	for (int i = 0; i < bodies.size(); ++i) {
		const auto &body = bodies[i];

		str.append("(");
		str.append(std::to_string(body.position.x));
		str.append(")");
	}

	std::cout << str << std::endl;
}

void print_array_of_string(int rank, const std::vector<std::string> &vec) {

	std::string str;

	str.append("-> Rank {");
	str.append(std::to_string(rank));
	str.append("}: ");

	for (int i = 0; i < vec.size(); ++i) {

		str.append("(");
		str.append(vec[i]);
		str.append(")");
	}

	std::cout << str << std::endl;
}