module BLASBenchmarksGPU

import BenchmarkTools
import CUDA
import DataFrames
import GemmKernels
import Plots
import PyPlot
import ProgressMeter
import Random
import Statistics
import StatsPlots

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
