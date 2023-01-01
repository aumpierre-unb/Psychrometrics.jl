include("plotData.jl")

using Plots

@doc raw"""

`doPlot()`

`doPlot` plots
a schematic psychrometric chart with
previously computed curves with
constant dry bulb temperature,
constant specific volume,
constant specific enthalpy and
constant relative humidity.

Edition of this file is
highly not advised.

`doPlot` is an internal function of
the psychrometrics toolbox for Julia.
"""
function doPlot()
    plot(xlabel="Dry Bulb Temperature (K)",
        ylabel="Humidity (kg vapor / kg dry air)",
        xlims=(0 + 273.15, 60 + 273.15), ylims=(0, 0.03),
        legend=false,
        ymirror=:true,
        grid=:true,
        minorgrid=:true,
        size=(700, 600))
    for i = 1:Int32(size(uv, 2) / 2)
        plot!(uv[:, 2*(i-1)+1], uv[:, 2*(i-1)+2],
            seriestype=:line,
            linestyle=:dashdot,
            color=:green)
    end
    for i = 1:Int32(size(uT, 2) / 2)
        plot!(uT[:, 2*(i-1)+1], uT[:, 2*(i-1)+2],
            seriestype=:line,
            linestyle=:dashdot,
            color=:blue)
    end
    for i = 1:Int32(size(ue, 2) / 2)
        plot!(ue[:, 2*(i-1)+1], ue[:, 2*(i-1)+2],
            seriestype=:line,
            linestyle=:dashdot,
            color=:red)
    end
    for i = 1:Int32(size(uh, 2) / 2)
        plot!(uh[:, 2*(i-1)+1], uh[:, 2*(i-1)+2],
            seriestype=:line,
            color=:black)
    end
    for i = 1:Int32(size(uH, 2) / 2)
        plot!(uH[:, 2*(i-1)+1], uH[:, 2*(i-1)+2],
            seriestype=:line,
            color=:gray)
    end
end
