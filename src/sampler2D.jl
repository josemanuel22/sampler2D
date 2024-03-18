module sampler2D

using Distributions
using Statistics
using LinearAlgebra

mutable struct RingSampler
    n_gaussian::Int
    radius::Float64
    sigma::Float64
    n_per_mode::Int
    centers::Matrix{Float32}
    n_mode::Int
    n_data::Int
    data::Matrix{Float32}

    function RingSampler(n_gaussian=8, radius=1.0, sigma=1e-3, n_per_mode=50)
        new(n_gaussian, radius, sigma, n_per_mode,
            zeros(Float64, 0, 2), 0, 0, zeros(Float64, 0, 2))
    end
end

function build!(sampler::RingSampler)
    sampler.centers = hcat([[sampler.radius * cos(2π * i / sampler.n_gaussian), sampler.radius * sin(2π * i / sampler.n_gaussian)] for i in 0:(sampler.n_gaussian-1)]...)
    sampler.n_mode = sampler.n_gaussian
    sampler.n_data = sampler.n_mode * sampler.n_per_mode
    sampler.data = Matrix{Float32}(undef, 2, 0)

    mode = MvNormal(zeros(Float32, 2), sampler.sigma * I(2))
    for i in (1:size(sampler.centers)[2])
        points = rand(mode, sampler.n_per_mode)
        points[1, :] .+= sampler.centers[1, i]
        points[2, :] .+= sampler.centers[2, i]
        sampler.data = hcat(sampler.data, points)
    end
end

mutable struct GridSampler
    n_row::Int
    n_col::Int
    edge::Float64
    sigma::Float64
    n_per_mode::Int
    centers::Matrix{Float64}
    n_mode::Int
    n_data::Int
    data::Matrix{Float64}

    function GridSampler(n_row=4, edge=1.0, sigma=0.02, n_per_mode=50)
        n_col = n_row
        new(n_row, n_col, edge, sigma, n_per_mode, zeros(Float64, 0, 2), 0, 0, zeros(Float64, 0, 2))
    end
end

function build!(sampler::GridSampler)

    function meshgrid(x, y)
        X = repeat(reshape(x, 1, :), length(y), 1)
        Y = repeat(reshape(y, :, 1), 1, length(x))
        return X, Y
    end

    mode = MvNormal(zeros(Float32, 2), sampler.sigma * I(2))
    x = LinRange(-4 * sampler.edge, 4 * sampler.edge, sampler.n_row)
    y = LinRange(-4 * sampler.edge, 4 * sampler.edge, sampler.n_col)
    X, Y = meshgrid(x, y)
    sampler.centers = hcat([[X[i], Y[i]] for i in 1:length(X)]...)

    sampler.data = Matrix{Float32}(undef, 2, 0)
    for i in (1:length(X))
        points = rand(mode, sampler.n_per_mode)
        points[1, :] .+= sampler.centers[1, i]
        points[2, :] .+= sampler.centers[2, i]
        sampler.data = hcat(sampler.data, points)
    end
end

# Example of using RingSampler
#=
ring_sampler = RingSampler()
build!(ring_sampler)
scatter(ring_sampler.data[1, :], ring_sampler.data[2, :])

# Example of using GridSampler
grid_sampler = GridSampler()
build!(grid_sampler)
scatter(grid_sampler.data[1, :], grid_sampler.data[2, :])
=#

export RingSampler, GridSampler, build!

end
