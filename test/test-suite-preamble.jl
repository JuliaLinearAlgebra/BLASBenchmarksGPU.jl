import InteractiveUtils
import LinearAlgebra

InteractiveUtils.versioninfo(stdout; verbose = true)
LinearAlgebra.versioninfo(stdout)

@info("Threads.nthreads() is $(Threads.nthreads())")

function is_coverage()
    return !iszero(Base.JLOptions().code_coverage)
end

const coverage = is_coverage()

@info("Code coverage is $(coverage ? "enabled" : "disabled")")
