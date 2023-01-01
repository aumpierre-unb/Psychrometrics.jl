@doc raw"""

`Psychrometrics` provides a set of functions to compute 
the various variables related to water vapor humid air.

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
include("plotdata.jl")
include("psychro.jl")
include("satPress.jl")
include("volume.jl")

end