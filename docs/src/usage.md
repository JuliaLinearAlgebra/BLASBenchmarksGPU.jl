```@meta
CurrentModule = BLASBenchmarksGPU
```

# Usage

## Example 1

```julia
julia> using BLASBenchmarksGPU

julia> bench_result = BLASBenchmarksGPU.runbench(:CUDA, Float16, Float16, Float32)

julia> import PyPlot

julia> BLASBenchmarksGPU.plotbench(bench_result, "plot.png")
```
