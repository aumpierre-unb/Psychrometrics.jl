@doc raw"""

`doPlot()`

`doPlot` plots
a schematic psychrometric chart.

`doPlot` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `enthalpy`, `volume` and `adiabSat`.

Examples
==========
Build the psychrometric chart.

```
doPlot()
```
"""
function doPlot()
    plot(xlabel="Dry Bulb Temperature (K)",
        ylabel="Humidity (kg vapor / kg dry air)",
        xlims=(0 + 273.15, 60 + 273.15),
        ylims=(0, 0.04),
        legend=false,
        ymirror=:true,
        grid=:true,
        gridalpha=0.12,
        minorgrid=:true,
        minorgridalpha=0.12,
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
    annotate!(285, 0.004, text(
        "20 kJ/kg",
        fontSize,
        :center, :center,
        :red,
        rotation=-28))
    annotate!(290, 0.006, text(
        "30 kJ/kg",
        fontSize,
        :center, :center,
        :red,
        rotation=-28))
    annotate!(293.8, 0.008, text(
        "0.84 cu.m/kg",
        fontSize,
        :center, :center,
        :green,
        rotation=-69))
    annotate!(299.8, 0.01, text(
        "0.86 cu.m/kg",
        fontSize,
        :center, :center,
        :green,
        rotation=-69))
    annotate!(329.7, 0.0062, text(
        "298.15 K", # "25 °C",
        fontSize,
        :center, :center,
        :blue,
        rotation=-31))
    annotate!(329.7, 0.0152, text(
        "303.15 K", # "298.15 K" # "30 °C",
        fontSize,
        :center, :center,
        :blue,
        rotation=-31))
    annotate!(329.7, 0.0264, text(
        "308.15 K", # "35 °C",
        fontSize,
        :center, :center,
        :blue,
        rotation=-31))
    annotate!(319.2, 0.0151, text(
        "25 %",
        fontSize,
        :center, :center,
        :darkgray,
        rotation=53))
    annotate!(316.7, 0.016, text(
        "30 %",
        fontSize,
        :center, :center,
        :darkgray,
        rotation=55))
    annotate!(312.9, 0.0174, text(
        "40 %",
        fontSize,
        :center, :center,
        :gray,
        rotation=57))
    annotate!(307.7, 0.0197, text(
        "60 %",
        fontSize,
        :center, :center,
        :gray,
        rotation=59))
    annotate!(275, 38.7e-3, text(
        "Psychrometric Chart", "TamilMN-Bold",
        fontSize + 8,
        :center, :left,
        :black))
    annotate!(275, 37.3e-3, text(
        "Sea level air-water vapor psychrometrics", "TamilMN-Bold",
        fontSize - 2,
        :center, :left,
        :black))
    annotate!(275, 36.6e-3, text(
        "https://github.com/aumpierre-unb/Psychrometrics.jl", "TamilMN-Bold",
        fontSize - 2,
        :center, :left,
        :black))
    path = Base.find_package("Psychrometrics")
    file = string(path[1:length(path)-length("src/Psychrometrics.jl")], "\\julia-logo-color.png")
    # img = load(file)
    # plot!([274.5, 283.5], [33.2e-3, 36.2e-3],
    #     reverse(img, dims=1),
    #     yflip=false,
    #     aspect_ratio=:none)
    plot!(inset=bbox(0.034, 0.11, 0.1, 0.1))
    plot!(load(file), subplot=2, axis=false, grid=false)
end
