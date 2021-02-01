using BLASBenchmarksGPU
using Test

import CUDA
import InteractiveUtils
import LinearAlgebra
import Statistics

InteractiveUtils.versioninfo(stdout)
LinearAlgebra.versioninfo(stdout)
CUDA.versioninfo(stdout)
@info "" [CUDA.capability(dev) for dev in CUDA.devices()]

@testset "CUDA: Float32=Float16×Float16" begin
    backend = :CUDA
    TA = Float16
    TB = Float16
    TC = Float32
    sizes = [2^n for n in 7:9]
    @info "" backend TA TB TC sizes
    bench_result = BLASBenchmarksGPU.runbench(
        backend,
        TA,
        TB,
        TC;
        sizes = sizes,
    )
    @test bench_result isa BLASBenchmarksGPU.BenchmarkResult
    plot_directory = mktempdir()
    plot_filename = joinpath(plot_directory, "plot.png")
    BLASBenchmarksGPU.plotbench(
        bench_result,
        plot_filename,
    )
end
