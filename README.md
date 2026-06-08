# Monte Carlo Methods

Small research/teaching codes for Monte Carlo simulations in Python, Numba, Fortran, and f2py.

## Structure

```text
monte-carlo-methods/
├── python/
│   ├── ising_model.py
│   └── harmonic_mc_demo.py
├── fortran/
│   └── harmonic_mc_code.f90
├── f2py_interfaces/
│   └── harmonic_mc.f90
├── notebooks/
├── figures/
├── data/
└── README.md
```

## 2D Ising model

Run:

```bash
python python/ising_model.py
```

The code uses Metropolis updates for the square-lattice Ising model with periodic boundary conditions.

## Harmonic oscillator Monte Carlo with f2py

Compile:

```bash
cd monte-carlo-methods-clean
python -m numpy.f2py -c f2py_interfaces/harmonic_mc.f90 -m harmonic_mc
```

Then run:

```bash
PYTHONPATH=. python python/harmonic_mc_demo.py
```

The expected equilibrium values for the dimensionless harmonic oscillator with

```text
P(x) ∝ exp[-k x² / 2]
```

are

```text
<x> ≈ 0
<E> = <k x²/2> ≈ 1/2
```

## Standalone Fortran harmonic Monte Carlo

Compile and run:

```bash
gfortran fortran/harmonic_mc_code.f90 -o harmonic_mc
printf "200000 20000 2.0 0.5 10.0\n" | ./harmonic_mc
```
