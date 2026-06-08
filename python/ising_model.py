#!/usr/bin/env python3
"""2D Ising model using Metropolis Monte Carlo.

Hamiltonian: H = -J sum_<ij> s_i s_j with J = 1 and periodic boundary conditions.
Temperature is represented by kT.
"""

import numpy as np
import matplotlib.pyplot as plt
from numba import njit


@njit
def delta_energy(config, x, y):
    """Energy change from flipping spin at (x, y)."""
    L = config.shape[0]
    s = config[x, y]
    nb = (
        config[x, (y - 1) % L]
        + config[x, (y + 1) % L]
        + config[(x - 1) % L, y]
        + config[(x + 1) % L, y]
    )
    return 2.0 * s * nb


@njit
def total_energy(config):
    """Total Ising energy with each bond counted once."""
    L = config.shape[0]
    E = 0.0
    for x in range(L):
        for y in range(L):
            s = config[x, y]
            E -= s * config[(x + 1) % L, y]
            E -= s * config[x, (y + 1) % L]
    return E


@njit
def metropolis_run(L, kT, steps, equilibration, random_initial=False):
    """Run Metropolis simulation and return average |m| and m(t)."""
    if random_initial:
        config = np.empty((L, L), dtype=np.int8)
        for i in range(L):
            for j in range(L):
                config[i, j] = 1 if np.random.random() < 0.5 else -1
    else:
        config = np.ones((L, L), dtype=np.int8)

    nspins = L * L
    mfull = np.empty(steps, dtype=np.float64)
    sum_abs_m = 0.0
    count = 0

    for step in range(steps):
        for _ in range(nspins):
            x = np.random.randint(L)
            y = np.random.randint(L)
            dE = delta_energy(config, x, y)

            if dE <= 0.0 or np.random.random() < np.exp(-dE / kT):
                config[x, y] = -config[x, y]

        m = np.mean(config)
        mfull[step] = m
        if step >= equilibration:
            sum_abs_m += abs(m)
            count += 1

    return sum_abs_m / count, mfull, config


def magnetization_curve(L=50, temperatures=None, steps=10000, equilibration=1000):
    if temperatures is None:
        temperatures = np.arange(1.8, 2.6, 0.05)

    mags = []
    for kT in temperatures:
        avmag, _, _ = metropolis_run(L, kT, steps, equilibration)
        print(f"kT = {kT:0.2f}\t<|m|> = {avmag:0.4f}")
        mags.append(avmag)

    return np.asarray(temperatures), np.asarray(mags)


if __name__ == "__main__":
    T, M = magnetization_curve()

    plt.figure(figsize=(6, 4))
    plt.scatter(T, M)
    plt.axvline(2.269, linestyle="--", label=r"$T_c \approx 2.269$")
    plt.xlabel(r"$k_B T / J$")
    plt.ylabel(r"$\langle |m| \rangle$")
    plt.title("2D Ising model: magnetization curve")
    plt.legend()
    plt.tight_layout()
    plt.show()
