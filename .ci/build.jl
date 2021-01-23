using Pkg

deps = [
    Pkg.PackageSpec(url = "https://github.com/JuliaGPU/GemmKernels.jl", rev = "master"),
]
Pkg.add(deps)
Pkg.build()
Pkg.precompile()
