# include("plotData.jl")

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
the `Psychrometrics` package for Julia.
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
    fontSize = 8
    annotate!(276.5, 0.007, text(
        "20 kJ/kg",
        fontSize,
        :center, :center,
        :red,
        rotation=-38))
    annotate!(281, 0.009, text(
        "30 kJ/kg",
        fontSize,
        :center, :center,
        :red,
        rotation=-38))
    annotate!(289.5, 0.015, text(
        "0.84 cu.m/kg",
        fontSize,
        :center, :center,
        :green,
        rotation=-74))
    annotate!(294.2, 0.0195, text(
        "0.86 cu.m/kg",
        fontSize,
        :center, :center,
        :green,
        rotation=-74))
    annotate!(330, 0.006, text(
        "25 °C",
        fontSize,
        :center, :center,
        :blue,
        rotation=-31))
    annotate!(330, 0.015, text(
        "30 °C",
        fontSize,
        :center, :center,
        :blue,
        rotation=-31))
end
