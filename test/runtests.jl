using BLASBenchmarksGPU
using Test

import InteractiveUtils
import VectorizationBase

include("test-suite-preamble.jl")

@info("VectorizationBase.NUM_CORES is $(VectorizationBase.NUM_CORES)")

@testset "BLASBenchmarksGPU.jl" begin
    @test BLASBenchmarksGPU.foo(1) == 2
end
