#pragma once
#include "utils.hpp"
#include "vec3.hpp"

struct point_particle
{
	Vec3 x_; //coordinates 
	Vec3 V_; //velocities  
	T mass_; //mass

	point_particle(T mass, Vec3 x, Vec3 V) : mass_(mass), x_(x), V_(V) {};
	point_particle(std::vector<T> all) : mass_(all[0]), x_(Vec3(all[1], all[2], all[3])), V_(Vec3(all[4], all[5], all[6])) {};

	inline point_particle operator=(const point_particle & other) {
		this->x_ = other.x_; this->V_ = other.V_; this->mass_ = other.mass_;
		return *this;
	}

	// Conversion
	inline std::string toString(const std::string &begin = "", const std::string &delimer = " ", const std::string &end = "") const {
		return begin +
			std::to_string(this->mass_) + delimer +
			x_.toString() + delimer +
			V_.toString() + 
			end;
	}
};

using SpaceVec = std::vector<point_particle>;

void copy(const SpaceVec& from, SpaceVec& to)
{
	for (size_t i = 0; i < from.size(); ++i){
		to[i] = from[i];
	}
}