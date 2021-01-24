"""
    benchmark_result_types(benchmark_result::BenchmarkResult)
"""
function benchmark_result_types(::BenchmarkResult{TA, TB, TC}) where {TA, TB, TC}
    return (TA, TB, TC)
end

"""
    benchmark_result_df(benchmark_result::BenchmarkResult)
"""
function benchmark_result_df(benchmark_result::BenchmarkResult)
    return deepcopy(benchmark_result.df)
end

function Base.show(io::IO, br::BenchmarkResult{TA, TB, TC}) where {TA, TB, TC}
    println(io, "Bennchmark Result of Matrix{$TC}=Matrix{$TA}×Matrix{$TB}")
    println(io, br.df)
    return nothing
end
