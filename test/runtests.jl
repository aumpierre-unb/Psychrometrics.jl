using Psychrometrics
using Test

@testset "Psychrometrics.jl" begin
    @test abs(
        Psychrometrics.satPress(
            25 + 273.15;
        ) - 3169
    ) < 1
    @test abs(
        Psychrometrics.volume(
            25 + 273.15,
            7e-3
        ) - 0.8541
    ) < 1e-4
    @test abs(
        Psychrometrics.enthalpy(
            25 + 273.15,
            7e-3
        ) - 42982
    ) < 1
    @test abs(
        Psychrometrics.dewTemp(
            1e3
        ) - 280.14689999999996
    ) < 1
    @test all(
        abs.(
            Psychrometrics.adiabSat(
                82.4e3
            ) .- (299, 0.0218)
        ) .< (1, 1e-4)
    )
end
