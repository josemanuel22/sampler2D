# sampler2D

[![Build Status](https://github.com/josemanuel22/sampler2D.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/josemanuel22/sampler2D.jl/actions/workflows/CI.yml?query=branch%3Amain)


The `sampler2D` module provides tools for generating two-dimensional data samples distributed around multiple modes in specific geometric configurations. It includes two sampler types: `RingSampler` and `GridSampler`. `RingSampler` arranges the modes in a circular pattern, whereas `GridSampler` arranges them in a grid pattern. These samplers are useful for testing and visualizing clustering, multi-modal distribution analysis, and pattern recognition algorithms.

## Features

- **RingSampler:** Samples points around a specified number of Gaussian modes arranged in a ring.
- **GridSampler:** Samples points around modes arranged in a grid layout.
- Both samplers allow for customization of the number of modes, the dispersion of the samples through a Gaussian distribution, and the number of samples per mode.

## Installation

To use `sampler2D`, clone this repository and include it in your Julia project. Ensure you have Julia installed on your system, and the following dependencies are also installed:

- `Distributions`
- `Statistics`
- `LinearAlgebra`

You can install these dependencies using Julia's package manager:

```julia
using Pkg
Pkg.add("Distributions")
Pkg.add("Statistics")
Pkg.add("LinearAlgebra")
```

## Usage

### RingSampler

```julia
using sampler2D

# Initialize the sampler
ring_sampler = RingSampler()

# Build the sample data
build!(ring_sampler)

# Visualize the data (using Plots.jl or any suitable plotting package)
scatter(ring_sampler.data[1, :], ring_sampler.data[2, :])
```

### GridSampler

```julia
using sampler2D

# Initialize the sampler
grid_sampler = GridSampler()

# Build the sample data
build!(grid_sampler)

# Visualize the data
scatter(grid_sampler.data[1, :], grid_sampler.data[2, :])
```

## Contributing

We welcome contributions to improve `sampler2D`! If you have suggestions, bug reports, or would like to contribute code, please open an issue or a pull request.

## License
