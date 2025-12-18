@testitem "JET analysis" tags=[:jet] begin

using JET
using Test
using PyQDecoders

# imported to be declared as modules filtered out from analysis result
using CondaPkg, PythonCall

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
