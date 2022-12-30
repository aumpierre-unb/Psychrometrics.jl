@doc raw"""

`Psychrometrics` provides a set of functions to compute 
the various variables related to water vapor humid air.

See also: `psychro`, `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat`.
"""
module Psychrometrics

using Plots
using Test

export psychro, humidity, satPress, enthalpy, volume, adiabSat, dewTemp

include("psychro.jl")
include("satPress.jl")
include("dewTemp.jl")
include("enthalpy.jl")
include("volume.jl")
include("newtonraphson.jl")
include("humidity.jl")
include("humidity2.jl")
include("adiabSat.jl")
include("dewTemp.jl")
include("constants.jl")
include("newtonraphson.jl")
include("doPlot.jl")
include("buildEnthalpy.jl")
include("buildHumidity.jl")
include("buildVolume.jl")
include("buildWetBulbTemp.jl")
include("plotdata.jl")

end