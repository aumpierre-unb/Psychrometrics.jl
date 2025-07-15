@doc raw"""
`Psychrometrics` provides a set of functions to compute
the various variables related to water vapor humid air.

Author: Alexandre Umpierre `aumpierre@gmail.com`

Maintainer's repository: `https://github.com/aumpierre-unb/Psychrometrics.jl`

Citation (all versions): `DOI 10.5281/zenodo.7493474`

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat` and `doPlot`.
"""
module Psychrometrics

using Plots
using Images
using Test
using Roots

export psychro, dewTemp, humidity, satPress, enthalpy, volume, adiabSat, doPlot

const COEFF = [
        -5.6745359e3
        6.3925247
        -9.6778430e-3
        6.2215701e-7
        2.0747825e-9
        -9.4840240e-13
        4.1635019
        -5.8002206e3
        1.3914993
        -4.8640239e-2
        4.1764768e-5
        -1.4452093e-8
        6.5459673
        6.54
        14.526
        0.7389
        0.09486
        0.4569
    ]

mutable struct HumidAir
    Tdry::Float64
    Twet::Float64
    Tdew::Float64
    Tadiab::Float64
    W::Float64
    Wsat::Float64
    Wsatwet::Float64
    Wadiab::Float64
    φ::Float64
    h::Float64
    v::Float64
    ρ::Float64
    pw::Float64
    psat::Float64
    psatwet::Float64
end

function Base.show(io::IO, h::HumidAir)
    println(io)
    println(io, "========")
    println(io, "HumidAir")
    println(io, "========")
    println(io, "Tdry, dry-bulb temperature                               $(h.Tdry)")
    println(io, "Twet, wet-bulb temperature                               $(h.Twet)")
    println(io, "Tadiab, adiabatic saturation temperature                 $(h.Tadiab)")
    println(io, "W, absolute humidity (kg/kg dry air)                     $(h.W)")
    println(io, "Wsat, saturation humidity (kg/kg dry air)                $(h.Wsat)")
    println(io, "Wsatwet, wet-bulb saturation humidity (kg/kg dry air).   $(h.Wsatwet)")
    println(io, "Wadiab, adiabatic saturation humidity (kg/kg dry air).   $(h.Wadiab)")
    println(io, "φ, relative humidity [0, 1]                              $(h.φ)")
    println(io, "h, specific enthalpy (kJ/kg of dry air)                  $(h.h)")
    println(io, "v, specific volume (cu. m/kg of dry air)                 $(h.v)")
    println(io, "ρ, density                                               $(h.ρ)")
    println(io, "pw, water vapor pressure (Pa)                            $(h.pw)")
    println(io, "psat, saturation pressure (Pa)                           $(h.psat)")
    println(io, "psatwet, wet-bulb saturation pressure (Pa)               $(h.psatwet)")
    println(io, "========")
end

include("loadCoeffs.jl")
include("adiabSat.jl")
include("buildChart.jl")
include("buildEnthalpy.jl")
include("buildHumidity.jl")
include("buildVolume.jl")
include("buildWetBulbTemp.jl")
include("dewTemp.jl")
include("doPlot.jl")
include("enthalpy.jl")
include("humidity.jl")
include("humidity2.jl")
include("newtonraphson.jl")
include("plotData.jl")
include("psychro.jl")
include("satPress.jl")
include("volume.jl")

end
