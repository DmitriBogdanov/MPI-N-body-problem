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

	inline Body operator=(const Body & other) {
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

void copy(const ArrayOfBodies& from, ArrayOfBodies& to) {
	for (size_t i = 0; i < from.size(); ++i){
		to[i] = from[i];
	}
}