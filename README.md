![C++](https://img.shields.io/badge/C++-std=17-blue.svg?style=flat&logo=cplusplus) <br>
# MPI N-body problem

Contains serial and parallel (MPI) implementations of standard N-body problem:

Let $m_i$ - bodies' masses, that we will consider as material points,
$$r_i(0) = r_{i0} = (x_{i0}, y_{i0}, z_{i0})^{T} \quad \text{- initial bodies' positions,}$$
$$v_i(0) = v_{i0} = (v_{x,i0}, v_{y,i0}, v_{z,i0})^{T} \quad \text{- initial bodies' velocities.}$$

The motion of bodies is described by a system of ordinary differential equations, which
obtained from Newton's equations:
\begin{numcases}{}
&$\dfrac{dr_i}{dt} = v_i$,\\
&$\dfrac{dv_i}{dt} = a_i$.
\end{numcases}

## Compilation

* Recommended compiler: Intel C++ Compiler
* Requires C++17 support 
* Requires MPI implementation

## Usage


## Version history

* 00.01
    * Implemented rough structure of serial method

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
