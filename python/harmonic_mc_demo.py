#!/usr/bin/env python3
"""Demo driver for the f2py harmonic Monte Carlo module.

Compile first:
    python -m numpy.f2py -c ../f2py_interfaces/harmonic_mc.f90 -m harmonic_mc
"""

import numpy as np
import matplotlib.pyplot as plt
import harmonic_mc


totstep = 200_000
eqstep = 20_000
nout = totstep - eqstep
k = 2.0
maxdx = 0.5
x0 = 10.0

x, e, acc = harmonic_mc.mc_harmonic(totstep, eqstep, nout, k, maxdx, x0)
print(f"Acceptance rate = {acc:.3f}")
print(f"<x> = {np.mean(x):.4f}")
print(f"<E> = {np.mean(e):.4f}; expected = 0.5")

step = np.arange(1, len(x) + 1)

plt.figure(figsize=(6, 4))
plt.plot(step, np.cumsum(x) / step, label=r"$\langle x \rangle$")
plt.plot(step, np.cumsum(e) / step, label=r"$\langle E \rangle$")
plt.axhline(0.5, linestyle="--", label="Expected energy")
plt.xlabel("Post-equilibration step")
plt.ylabel("Running average")
plt.title("Harmonic oscillator Monte Carlo")
plt.legend()
plt.tight_layout()
plt.show()

plt.figure(figsize=(6, 4))
plt.hist(x, bins=200, density=True, histtype="step", label="samples")
xx = np.linspace(x.min(), x.max(), 500)
px = np.sqrt(k/(2*np.pi)) * np.exp(-0.5*k*xx**2)
plt.plot(xx, px, label="exact Gaussian")
plt.xlabel("x")
plt.ylabel("P(x)")
plt.title("Equilibrium position distribution")
plt.legend()
plt.tight_layout()
plt.show()
