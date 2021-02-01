matmul_sizes(s::Integer) = (s,s,s)
matmul_sizes(m_k_n::Tuple{Vararg{<:Integer, 3}}) = m_k_n

"""
    runbench(backend, TA, TB, TC; kwargs...)
"""
function runbench(backend::Symbol, ::Type{TA}, ::Type{TB}, ::Type{TC};
                  kwargs...) where {TA, TB, TC}
    return runbench(Val(backend), TA, TB, TC; kwargs...)
end

"""
    runbench(::Val{:CUDA}, TA, TB, TC; kwargs...)
"""
function runbench(::Val{:CUDA}, ::Type{TA}, ::Type{TB}, ::Type{TC};
                  estimator::F = Base.minimum,
                  libs = all_libs(),
                  sizes = [2^n for n in 7:14]) where {TA, TB, TC, F}
    sizes_vec = collect(sizes)
    _sizes_column = Vector{Int}(undef, 0)
    _libraries_column = Vector{Symbol}(undef, 0)
    _tflops_column = Vector{Float64}(undef, 0)
    _gflops_column = Vector{Float64}(undef, 0)
    _times_column = Vector{Float64}(undef, 0)
    p = ProgressMeter.Progress(length(sizes_vec))
    warmed_up = falses(length(sizes_vec))
    for (j, sz) ∈ enumerate(sizes_vec)
        showvalues = []
        push!(showvalues, (:Size, sz))
        GC.gc()
        CUDA.reclaim()
        M = sz
        K = sz
        N = sz
        for lib in libs
            benchfunc! = getbenchfunc(lib)

            if !(warmed_up[j])
                A_h = rand(TA, (M, K)) / sqrt(TA(K));
                B_h = rand(TB, (K, N)) / sqrt(TB(K));
                C_h = rand(TC, (M, N));
                A = CUDA.CuArray(A_h);
                B = CUDA.CuArray(B_h);
                C = CUDA.CuArray(C_h);
                benchfunc!(C, A, B) # warmup
                warmed_up[j] = true
            end

            A_h = rand(TA, (M, K)) / sqrt(TA(K));
            B_h = rand(TB, (K, N)) / sqrt(TB(K));
            C_h = rand(TC, (M, N));
            A = CUDA.CuArray(A_h);
            B = CUDA.CuArray(B_h);
            C = CUDA.CuArray(C_h);
            trial = benchfunc!(C, A, B)
            point_estimate = estimator(trial)
            t_ns = Base.time(point_estimate) # time in nanoseconds
            t_ps = 1_000 * t_ns # time in picoseconds
            flops_factor = 2
            gflops = flops_factor * M * K * N / t_ns # gigaflops
            tflops = flops_factor * M * K * N / t_ps # teraflops
            push!(showvalues, (lib, "$(round(tflops; digits = 2)) TFLOPS"))
            push!(_sizes_column, sz)
            push!(_libraries_column, lib)
            push!(_tflops_column, tflops)
            push!(_gflops_column, gflops)
            push!(_times_column, t_ns)
        end
        ProgressMeter.next!(p; showvalues = showvalues)
        GC.gc()
        CUDA.reclaim()
    end
    df = DataFrames.DataFrame(
        Size = _sizes_column,
        Library = _libraries_column,
        TFLOPS = _tflops_column, # teraflops
        GFLOPS = _gflops_column, # gigaflops
        Time = _times_column,    # time in nanoseconds
    )
    benchmark_result = BenchmarkResult{TA, TB, TC}(df)
    return benchmark_result
end
