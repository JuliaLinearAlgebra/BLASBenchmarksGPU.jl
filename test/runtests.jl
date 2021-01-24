using BLASBenchmarksGPU
using Test

import CUDA
import InteractiveUtils
import LinearAlgebra

include("test-suite-preamble.jl")

CUDA.versioninfo(stdout)
@info "" [CUDA.capability(dev) for dev in CUDA.devices()]

@testset "BLASBenchmarksGPU.jl" begin
end
