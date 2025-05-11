![C++](https://img.shields.io/badge/C++-std=17-blue.svg?style=flat&logo=cplusplus)
# MPI N-body problem

Contains serial and parallel implementations of the standard N-body problem, which is the problem of predicting the individual motions of a group of celestial objects interacting with each other gravitationally.

Let's consider $N$ material points (aka bodies) with masses $\lbrace m_i \rbrace$:

$$r_i(0) = r_{i0} = (x_{i0}, y_{i0}, z_{i0})^{T} \quad \text{- initial positions}$$

$$v_i(0) = v_{i0} = (v_{x,i0}, v_{y,i0}, v_{z,i0})^{T} \quad \text{- initial velocities}$$

The motion of bodies is described by a system of ordinary differential equations, which is obtained from Newton's equations:

$$\dfrac{dr_i}{dt} = v_i, \quad\dfrac{dv_i}{dt} = a_i$$

here $a_i$ corresponds to $i$-th body's acceleration, it's value is defined by the gravitational law:

$$a_i = -\sum\limits_{j = 1, i \ne j}^{N}{\dfrac{G m_j (r_i - r_j)}{\left|r_i - r_j\right|^3}}$$

The differential system is integrated numerically, which can be done in a highly parallel fashion, synchronization points depend on the method, here 2nd order Runge-Kutta is used.

> [!Note]
> Present implementation serves mainly as an **academic reference** for implementing efficient MPI parallelism using N-body problem as an example.

## Compilation

* Requires C++17 support 
* Requires MPI implementation

## Version history

* 01.00
  * Added MPI implementation
  * Tweaked README

* 00.01
  * Implemented rough structure of serial method

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
