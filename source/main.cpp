#include <iostream>
#include <iomanip>

#include "Nbody.hpp"
#include "static_timer.hpp"
#include "table.hpp"


// # Config #



int main(int argc, char** argv) {
	std::string init_data_filename, res_data_foldername;
	T interval = 20;
	size_t time_layers = 2000;
	//outstream << "Input initial data_filename, number of time steps and time interval: ";
	//instream >> data_filename >> time_layers >> interval;
	init_data_filename = "../../MPI-N-body-problem/source/data/test/4body_test.txt";
	res_data_foldername = "../../MPI-N-body-problem/source/data/test/4body_calc";
	nbody(init_data_filename, res_data_foldername, time_layers, interval, 10);
}

