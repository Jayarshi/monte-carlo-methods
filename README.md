# Monte Carlo Methods

A collection of Monte Carlo algorithms implemented in both Fortran and Python. The repository serves as a practical introduction to stochastic simulation techniques widely used in statistical physics, computational science, and quantitative modeling.

## Topics Covered

### Random Walks

Simulation of stochastic trajectories and diffusion processes.

Applications:

* Brownian motion
* Diffusion theory
* First-passage problems
* Transport phenomena

### Metropolis Sampling

Implementation of the Metropolis algorithm for sampling from arbitrary probability distributions.

Applications:

* Statistical inference
* Bayesian methods
* Thermodynamic systems
* Importance sampling

### Ising Model

Monte Carlo simulation of the two-dimensional Ising model.

Applications:

* Magnetism
* Critical phenomena
* Phase transitions
* Lattice statistical mechanics

---

## Repository Structure

```text
monte-carlo-methods/
├── fortran/
│   ├── random_walks_code.f90
│   ├── metropolis_sampling_code.f90
│   └── ising_model_code.f90
├── python/
│   ├── random_walks.ipynb
│   ├── metropolis_sampling.ipynb
│   └── ising_model.ipynb
├── f2py_interfaces/
│   ├── random_walks.f90
│   ├── metropolis_sampling.f90
│   ├── ising_model.f90
│   ├── random_walks_f2py.ipynb
│   ├── metropolis_sampling_f2py.ipynb
│   └── ising_model_f2py.ipynb
└── README.md
```

---

## Features

* Pure Python reference implementations
* High-performance Fortran versions
* F2PY integration examples
* Visualization through Jupyter notebooks
* Educational demonstrations of Monte Carlo techniques

---

## Requirements

### Python

```bash
numpy
matplotlib
scipy
jupyter
```

### Fortran

```bash
gfortran
```

---

## Building F2PY Modules

Example:

```bash
f2py -c -m random_walks random_walks.f90
```

Similarly,

```bash
f2py -c -m metropolis_sampling metropolis_sampling.f90
f2py -c -m ising_model ising_model.f90
```

---

## Typical Workflow

1. Study the algorithm using Python notebooks.
2. Run larger simulations using Fortran.
3. Create Python bindings through F2PY.
4. Perform analysis and visualization in Jupyter.

---

## Educational Goals

This repository demonstrates:

* Random number generation
* Markov chains
* Detailed balance
* Importance sampling
* Equilibrium distributions
* Finite-size effects
* Critical behavior

---

## References

1. D. P. Landau and K. Binder, *A Guide to Monte Carlo Simulations in Statistical Physics*.
2. N. Metropolis et al., *Equation of State Calculations by Fast Computing Machines* (1953).
3. K. Huang, *Statistical Mechanics*.

---

## License

For academic, educational, and research use. Users are encouraged to cite relevant references when employing these algorithms in publications.

