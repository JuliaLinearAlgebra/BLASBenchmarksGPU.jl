using BLASBenchmarksGPU
using Test

import InteractiveUtils

include("test-suite-preamble.jl")

@testset "BLASBenchmarksGPU.jl" begin
    @test BLASBenchmarksGPU.foo(1) == 2
end
