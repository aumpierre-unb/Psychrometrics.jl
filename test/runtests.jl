using Psychrometrics
using Test
using Plots

@testset "Psychrometrics.jl" begin
    # data(x) = x .^ 1.11 .* (1 - x) .^ 1.09 + x
    # x = [0.1 0.5 0.9]
    # q = 0.54
    # R = refmin(data, x, q)
    # R = 1.7 * R
    # @test 9 > strays(data, x, q, R, true, false) > 8
end
