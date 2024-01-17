using Documenter
using PyQDecoders

ENV["LINES"] = 80    # for forcing `displaysize(io)` to be big enough
ENV["COLUMNS"] = 80
@testset "Doctests" begin
    DocMeta.setdocmeta!(PyQDecoders, :DocTestSetup, :(using PyQDecoders); recursive=true)
    doctest(PyQDecoders)
end
