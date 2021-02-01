module BLASBenchmarksGPU

import BenchmarkTools
import CUDA
import DataFrames
import GemmKernels
import KernelAbstractions
import Plots
import PyPlot
import ProgressMeter
import Random
import Statistics
import StatsPlots
import Tullio

using CUDA               # this `using` statement is required to use Tullio on the GPU
using KernelAbstractions # this `using` statement is required to use Tullio on the GPU

export benchmark_result_df
export benchmark_result_types
export plotbench
export runbench

include("types.jl")

include("benchconfig.jl")
include("benchmarkresult.jl")
include("plotting.jl")
include("runbenchmark.jl")

end # end module BLASBenchmarksGPU
