@testitem "Doc tests" tags=[:doctests] begin
    using Documenter
    using PyQDecoders

    ENV["LINES"] = 80    # for forcing `displaysize(io)` to be big enough
    ENV["COLUMNS"] = 80

    DocMeta.setdocmeta!(PyQDecoders, :DocTestSetup, :(using PyQDecoders); recursive=true)
    doctest(PyQDecoders; manual=false)
end
