using PkgBenchmark

using SolverBenchmark

using Plots
pyplot()  # recommended!
using PlotThemes
theme(:juno)

common_plot_args = Dict{Symbol,Any}(
  :linewidth => 2,
  :alpha => .75,
  :titlefontsize => 8,
  :legendfontsize => 8,
  :xtickfontsize => 6,
  :ytickfontsize => 6,
  :guidefontsize => 8,
)
Plots.default(; common_plot_args...)

# perform benchmarks
results = PkgBenchmark.benchmarkpkg("Krylov", script="benchmark/cg_bmark.jl")

println("type : ", typeof(results), "eltype: ", eltype(results))
println("results: ", results)
die()
# process benchmark results and post gist
p = profile_solvers(results)
posted_gist = to_gist(results, p)
println(posted_gist.html_url)

# open("gist.json", "w") do f
#   JSON.print(f, posted_gist)
# end