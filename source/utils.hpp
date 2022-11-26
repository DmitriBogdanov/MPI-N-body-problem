#pragma once

/// Fix for VS2019 bug displaying false warnings on integer multiplication
#pragma warning (disable: 26451)

/// Fix for VS2019 incorrectly assuming that args of some MPI function lie outside the proper range
#pragma warning (disable: 28020)

/// In given project class members don't have to be default-initialized (to save resources)
#pragma warning (disable: 26495)


#include <memory>
#include <cmath>
#include <iostream>
#include <fstream> // test
#include <functional>
#include <mpi.h>

#define MPI_T MPI_DOUBLE
#define MASTER_PROCESS 0


using T = long double;
inline static auto &outstream = std::cout;
inline static auto &instream = std::cin;

// Math
const T PI = 3.14159265358979323846;

template<typename Type>
constexpr Type sqr(Type value) { return value * value; } // screw you C++, I want my sqr()

template<typename Type>
constexpr Type cube(Type value) { return value * value * value; } // screw you C++, I want my cube()

inline static int bitselect(int condition, int truereturnvalue, int falsereturnvalue) {
	return (truereturnvalue & -condition) | (falsereturnvalue & ~(-condition)); //a when TRUE and b when FALSE
}

// 'Raw' array
using UniquePtrArray = std::unique_ptr<T[]>;

UniquePtrArray make_raw_array(size_t size) {
	return UniquePtrArray(new T[size]);
}

UniquePtrArray make_raw_array(size_t size, T defaultValue) {
	UniquePtrArray arr(new T[size]);
	for (size_t k = 0; k < size; ++k) arr[k] = defaultValue;
	return arr;
}

UniquePtrArray make_raw_array_from_data(size_t size, T* const data) {
	UniquePtrArray arr(new T[size]);
	memcpy(arr.get(), data, size * sizeof(T));
	return arr;
}

void print_array(T* const arr, size_t size) {
	outstream << "{ ";
	for (size_t k = 0; k < size - 1; ++k) outstream << arr[k] << ", ";
	outstream << arr[size - 1] << " }" << std::endl;
}


// Utility
inline void exit_with_error(const std::string &msg) {
	outstream << "ERROR: " << msg << "\n";
	///MPI_Finalize();
	exit(1);
}

std::string bool_to_int(bool arg) {
	return arg ? "TRUE" : "FALSE";
}

bool rand_bool() {
	return static_cast<bool>(rand() % 2);
}

int rand_int(int min, int max) {
	return min + rand() % (max - min + 1);
}

T rand_T() {
	return rand() / (RAND_MAX + 1.);
}

T rand_T(T min, T max) {
	return min + (max - min) * rand_T();
}