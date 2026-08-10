const JET_PROJECT = normpath(joinpath(@__DIR__, "projects", "jet"))
const test_args = isempty(ARGS) ? ["general"] : ARGS
const JET_flag = length(test_args) == 1 && startswith(only(test_args), "jet")

if JET_flag
  @info "Activating the dedicated JET test environment." project=JET_PROJECT
  using Pkg
  Pkg.activate(JET_PROJECT)
  Pkg.instantiate()
end

using PyQDecoders
using TestItemRunner

# filter for the test
testfilter = ti -> begin
  exclude = Symbol[]
  if JET_flag
    return :jet in ti.tags
  else
    push!(exclude, :jet)
  end
  if !(VERSION >= v"1.10") || get(ENV, "QUANTUMSAVORY_DOWNGRADE_TEST", "") == "true"
    push!(exclude, :doctests)
    push!(exclude, :aqua)
  end

  return all(!in(exclude), ti.tags)
end

println("Starting tests with $(Threads.nthreads()) threads out of `Sys.CPU_THREADS = $(Sys.CPU_THREADS)`...")

@run_package_tests filter=testfilter
