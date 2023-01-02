@doc raw"""

`Psychrometrics` provides a set of functions to compute 
the various variables related to water vapor humid air.

Author: Alexandre Umpierre aumpierre@gmail.com

Maintainer's repository: https://github.com/aumpierre-unb/Psychrometrics.jl

Citation (all versions): DOI 10.5281/zenodo.7493474

See also: `psychro`, `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat`.
"""
module Psychrometrics

using Plots
using Test

export psychro, humidity, satPress, enthalpy, volume, adiabSat, dewTemp

include("adiabSat.jl")
include("buildChart.jl")
include("buildEnthalpy.jl")
include("buildHumidity.jl")
include("buildVolume.jl")
include("buildWetBulbTemp.jl")
include("constants.jl")
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