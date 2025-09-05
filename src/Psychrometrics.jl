@doc raw"""
`Psychrometrics` provides a set of functions to compute
the various variables related to water vapor humid air.

Author: Alexandre Umpierre `aumpierre@gmail.com`

Maintainer's repository: `https://github.com/aumpierre-unb/Psychrometrics.jl`

Citation (all versions): `DOI 10.5281/zenodo.7493474`

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat` and `buildBasicChart`.
"""
module Psychrometrics

using Plots
using Images
using Test
using Roots

mutable struct HumidAir
    Tdry::Number
    Twet::Number
    Tdew::Number
    Tadiab::Number
    W::Number
    Wsat::Number
    Wsatwet::Number
    Wadiab::Number
    φ::Number
    h::Number
    v::Number
    ρ::Number
    pw::Number
    psat::Number
    psatwet::Number
end

coeffs = [
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

include("psychro.jl")
include("adiabSat.jl")
include("satPress.jl")
include("dewTemp.jl")
include("enthalpy.jl")
include("volume.jl")
include("humidity.jl")
include("humiditySatWet.jl")
include("buildEnthalpyLine.jl")
include("buildHumidityLine.jl")
include("buildVolumeLine.jl")
include("buildWetBulbTempLine.jl")
include("buildBasicData.jl")
include("buildBasicChart.jl")
include("doShowPlot.jl")
include("plotData.jl")

export psychro,
    dewTemp,
    humidity,
    satPress,
    enthalpy,
    volume,
    adiabSat,
    buildBasicChart
end
