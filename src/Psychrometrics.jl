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

export psychro, dewTemp, humidity, satPress, enthalpy, volume, adiabSat, doPlot

struct HumidAir
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
