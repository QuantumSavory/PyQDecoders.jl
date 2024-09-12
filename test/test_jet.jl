using Test
using PyQDecoders
using JET

# imported to be declared as modules filtered out from analysis result
using CondaPkg, PythonCall

@testset "JET checks" begin
    rep = report_package("PyQDecoders";
        ignored_modules=(
            AnyFrameModule(CondaPkg),
            AnyFrameModule(PythonCall),
        )
    )
    @show rep
    #@test_broken length(JET.get_reports(rep)) == 0
    @test length(JET.get_reports(rep)) <= 0
end
