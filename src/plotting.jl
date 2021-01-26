import Plots
import PyPlot
import StatsPlots

"""
    plotbench(bench_result, plot_filename; kwargs...)
"""
function plotbench(bench_result::BenchmarkResult,
                   plot_filename::AbstractString;
                   plotting_backend = Plots.pyplot)
    df = benchmark_result_df(bench_result)
    df[!, :Size] = Float64.(df[!, :Size])
    df[!, :TFLOPS] = Float64.(df[!, :TFLOPS])
    if !(plotting_backend isa Nothing)
        plotting_backend()
    end
    p = StatsPlots.@df df StatsPlots.plot(
        :Size,
        :TFLOPS;
        group = :Library,
        legend = :outertopright,
        xscale = :log2,
        xlabel = "Size",
        ylabel = "TFLOPS",
    );
    Plots.savefig(p, plot_filename)
    return nothing
end
