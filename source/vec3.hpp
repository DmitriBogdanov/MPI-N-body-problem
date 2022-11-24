#pragma once

#include <string>

#include "utils.hpp"

struct Vec3 {
	T x;
	T y;
	T z;

	Vec3() : x(0), y(0), z(0) {}
	Vec3(T x, T y, T z) : x(x), y(y), z(z) {}
	Vec3(const Vec3 & other) : x(other.x), y(other.y), z(other.z) {};

	inline Vec3 operator=(const Vec3 & other) {
		this->x = other.x; this->y = other.y; this->z = other.z;
		return *this;
	}

	// Arithmetic
	inline Vec3 operator+(const Vec3 &other) const {
		return Vec3{ this->x + other.x, this->y + other.y , this->z + other.z };
	}
	inline Vec3 operator-(const Vec3 &other) const {
		return Vec3{ this->x - other.x, this->y - other.y , this->z - other.z };
	}
	inline Vec3 operator*(T val) const {
		return Vec3{ this->x * val, this->y * val, this->z * val };
	}
	inline Vec3 operator/(T val) const {
		return Vec3{ this->x / val, this->y / val, this->z / val };
	}

	// Increments
	inline Vec3& operator+=(const Vec3 &other) {
		this->x += other.x;
		this->y += other.y;
		this->z += other.z;
		return *this;
	}
	inline Vec3& operator-=(const Vec3 &other) {
		this->x -= other.x;
		this->y -= other.y;
		this->z -= other.z;
		return *this;
	}
	inline Vec3& operator*=(const Vec3 &other) {
		this->x *= other.x;
		this->y *= other.y;
		this->z *= other.z;
		return *this;
	}
	inline Vec3& operator/=(const Vec3 &other) {
		this->x /= other.x;
		this->y /= other.y;
		this->z /= other.z;
		return *this;
	}

	// Conversion
	inline std::string toString(const std::string &begin = "", const std::string &delimer = " ", const std::string &end = "") const {
		return begin +
			std::to_string(this->x) + delimer +
			std::to_string(this->y) + delimer +
			std::to_string(this->z) +
			end;
	}

	inline T norm() const {
		return sqrt(this->x * this->x + this->y * this->y + this->z * this->z);
	}
};