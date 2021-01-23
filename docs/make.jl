using BLASBenchmarksGPU
using Documenter

makedocs(;
    modules=[BLASBenchmarksGPU],
    authors="Dilum Aluthge, Chris Elrod, Thomas Faingnaert, Tim Besard, and contributors",
    repo="https://github.com/JuliaLinearAlgebra/BLASBenchmarksGPU.jl/blob/{commit}{path}#L{line}",
    sitename="BLASBenchmarksGPU.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaLinearAlgebra.github.io/BLASBenchmarksGPU.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Usage" => "usage.md",
        "Public API" => "public-api.md",
        "Internals (Private)" => "internals.md",
    ],
    strict=true,
)

deploydocs(;
    repo="github.com/JuliaLinearAlgebra/BLASBenchmarksGPU.jl",
)
