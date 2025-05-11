#pragma once

/// Fix for VS2019 bug displaying false warnings on integer multiplication
#pragma warning (disable: 26451)

/// Fix for VS2019 incorrectly assuming that args of some MPI function lie outside the proper range
#pragma warning (disable: 28020)

/// In given project class members don't have to be default-initialized (to save resources)
#pragma warning (disable: 26495)


#include <memory>
#include <cstring>
#include <cmath>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <functional>
#include <typeinfo>
#include <vector>
#include <filesystem>

#include <mpi.h>


// --------------------
// --- Numeric type ---
// --------------------
#define DATATYPE_FLOAT

#ifdef DATATYPE_FLOAT
using T = float;
#define MPI_T MPI_FLOAT
#endif

#ifdef DATATYPE_DOUBLE
using T = double;
#define MPI_T MPI_DOUBLE
#endif




// ------------
// --- Math ---
// ------------
const T PI = 3.14159265358979323846;

const T G = 6.67e-11;
const T DR_EPSILON = 1e-10; // used in Newton's law of universal gravitation to avoid division by 0

template<typename T>
constexpr T sqr(T value) { return value * value; }

template<typename T>
constexpr T cube(T value) { return value * value * value; }

// -----------------
// --- Raw array ---
// -----------------
using UniquePtrArray = std::unique_ptr<T[]>;

inline UniquePtrArray make_raw_array(size_t size) {
	return UniquePtrArray(new T[size]);
}

inline UniquePtrArray make_raw_array(size_t size, T defaultValue) {
	UniquePtrArray arr(new T[size]);
	for (size_t k = 0; k < size; ++k) arr[k] = defaultValue;
	return arr;
}

inline UniquePtrArray make_raw_array_from_data(size_t size, T* const data) {
	UniquePtrArray arr(new T[size]);
	memcpy(arr.get(), data, size * sizeof(T));
	return arr;
}

inline void print_array(T* const arr, size_t size) {
	std::cout << "{ ";
	for (size_t k = 0; k < size - 1; ++k) std::cout << arr[k] << ", ";
	std::cout << arr[size - 1] << " }" << std::endl;
}

// --------------
// --- Random ---
// --------------
inline bool rand_bool() {
	return static_cast<bool>(rand() % 2);
}

inline int rand_int(int min, int max) {
	return min + rand() % (max - min + 1);
}

inline T rand_T() {
	return rand() / (RAND_MAX + 1.);
}

inline T rand_T(T min, T max) {
	return min + (max - min) * rand_T();
}

// -----------------------
// --- File operations ---
// -----------------------
inline void clean_folder(const std::string &folder) {
	for (const auto &entry : std::filesystem::directory_iterator(folder))
		std::filesystem::remove_all(entry.path());
}

inline void create_empty_files(const std::vector<std::string> &filenames) {
	for (const auto &filename : filenames) {
		std::ofstream outFile(filename);
	}
}

// ------------
// --- MISC ---
// ------------
inline void exit_with_error(const std::string &msg) {
	std::cout << "ERROR: " << msg << "\n";
	MPI_Finalize();
	exit(1);
}

inline std::string bool_to_str(bool arg) {
	return arg ? "TRUE" : "FALSE";
}