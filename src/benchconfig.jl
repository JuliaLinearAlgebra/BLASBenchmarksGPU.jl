"""
    all_libs()
"""
function all_libs()
    libs = Symbol[
        :CUBLAS,
        :GemmKernels,
        :Tullio,
    ]
    return libs
end

function getbenchfunc(lib::Symbol)
    if lib === :CUBLAS
        return benchmark_gemm_cublas!
    elseif lib === :GemmKernels
        return benchmark_gemm_gemmkernels!
    elseif lib === :Tullio
        return benchmark_gemm_tullio!
    end
    throw(ArgumentError("Unknown library \"$(lib)\""))
end

function benchmark_gemm_cublas!(C, A, B)
    CUDA.CUBLAS.cublasSetMathMode(CUDA.CUBLAS.handle(), CUDA.CUBLAS.CUBLAS_TENSOR_OP_MATH)
    return BenchmarkTools.@benchmark CUDA.@sync begin
        CUDA.CUBLAS.gemmEx!('N', 'N', 1, $A, $B, 0, $C)
    end
end

function benchmark_gemm_gemmkernels!(C, A, B)
    return BenchmarkTools.@benchmark CUDA.@sync begin
        GemmKernels.BLAS.gemmEx!('N', 'N', 1, $A, $B, 0, $C)
    end
end

gemm_tullio!(C, A, B) = @tullio C[i, j] = A[i, k] * B[k, j]

function benchmark_gemm_tullio!(C, A, B)
    return BenchmarkTools.@benchmark CUDA.@sync begin
        gemm_tullio!($C, $A, $B)
    end
end
