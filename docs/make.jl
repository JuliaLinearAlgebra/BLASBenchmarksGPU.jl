using BLASBenchmarksGPU
using Documenter

makedocs(;
    modules=[BLASBenchmarksGPU],
    authors="JuliaLinearAlgebra, JuliaGPU, contributors",
    repo="https://github.com/JuliaLinearAlgebra/BLASBenchmarksGPU.jl/blob/{commit}{path}#L{line}",
    sitename="BLASBenchmarksGPU.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaLinearAlgebra.github.io/BLASBenchmarksGPU.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaLinearAlgebra/BLASBenchmarksGPU.jl",
)
