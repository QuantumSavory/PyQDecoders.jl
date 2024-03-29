using Test
using PyQDecoders
using JET

using JET: ReportPass, BasicPass, InferenceErrorReport, UncaughtExceptionReport

# Custom report pass that ignores `UncaughtExceptionReport`
# Too coarse currently, but it serves to ignore the various
# "may throw" messages for runtime errors we raise on purpose
# (mostly on malformed user input)
struct MayThrowIsOk <: ReportPass end

# ignores `UncaughtExceptionReport` analyzed by `JETAnalyzer`
(::MayThrowIsOk)(::Type{UncaughtExceptionReport}, @nospecialize(_...)) = return

# forward to `BasicPass` for everything else
function (::MayThrowIsOk)(report_type::Type{<:InferenceErrorReport}, @nospecialize(args...))
    BasicPass()(report_type, args...)
end

# imported to be declared as modules filtered out from analysis result
using CondaPkg, PythonCall

@testset "JET checks" begin
    rep = report_package("PyQDecoders";
        report_pass=MayThrowIsOk(),
        ignored_modules=(
            AnyFrameModule(CondaPkg),
            AnyFrameModule(PythonCall),
        )
    )
    @show rep
    #@test_broken length(JET.get_reports(rep)) == 0
    @test length(JET.get_reports(rep)) <= 0
end
