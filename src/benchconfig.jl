"""
    all_libs()
"""
function all_libs()
    libs = Symbol[
        :CUBLAS,
        :GemmKernels,
    ]
    return libs
end

function getbenchfunc(lib::Symbol)
    if lib === :CUBLAS
        return benchmark_gemm_cublas!
    elseif lib === :GemmKernels
        return benchmark_gemm_gemmkernels!
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
