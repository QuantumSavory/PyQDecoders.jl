using Documenter
using PyQDecoders

makedocs(
    sitename = "PyQDecoders.jl",
    modules = [PyQDecoders],
    doctest = false,
    warnonly = :missing_docs,
    pages = [
        "Home" => "index.md",
    ],
)

deploydocs(
    repo = "github.com/QuantumSavory/PyQDecoders.jl.git",
    devbranch = "master",
    push_preview = true,
)
