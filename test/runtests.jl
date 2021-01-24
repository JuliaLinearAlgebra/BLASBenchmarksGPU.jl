using BLASBenchmarksGPU
using Test

import CUDA
import InteractiveUtils
import LinearAlgebra

InteractiveUtils.versioninfo(stdout; verbose = true)
LinearAlgebra.versioninfo(stdout)
CUDA.versioninfo(stdout)
@info "" [CUDA.capability(dev) for dev in CUDA.devices()]

@testset "BLASBenchmarksGPU.jl" begin
end
