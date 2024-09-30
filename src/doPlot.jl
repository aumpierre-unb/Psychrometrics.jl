@doc raw"""
```
doPlot(;
    back::Symbol=:white, # plot background color
    unit::Symbol=:K # units for temperature (:K or :°C)
    )
```

`doPlot` plots
a schematic psychrometric chart.

`doPlot` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `enthalpy`, `volume` and `adiabSat`.

Examples
==========
Build a schematic psychrometric chart
with temperature in °C
with transparent background and
save figure as psychrometricChart_transparent.svg.
```
julia> doPlot(
       back=:transparent, # plot background transparent
       unit=:°C # temperature in °C
       )
julia> using Plots
julia> savefig("psychrometricChart_transparent.svg")
```
"""
function doPlot(;
    back::Symbol=:white,
    unit::Symbol=:K
)
    k = unit == :°C ? 1 : 0

    uv, uT, ue, uh, uH = plotData()

    plot(
        xlabel=string("Dry Bulb Temperature ", unit == :°C ? "(°C)" : "(K)"),
        ylabel="Humidity (kg vapor / kg dry air)",
        xlims=(0 + 273.15 - k * 273.15, 60 + 273.15 - k * 273.15,),
        ylims=(0, 0.04),
        legend=false,
        ymirror=true,
        grid=true,
        gridalpha=0.12,
        minorgrid=true,
        minorgridalpha=0.12,
        size=(700, 600)
    )
    for i = 1:Int32(size(uv, 2) / 2)
        plot!(
            uv[:, 2*(i-1)+1] .- k .* 273.15, uv[:, 2*(i-1)+2],
            seriestype=:line,
            linestyle=:dashdot,
            color=:green
        )
    end
    for i = 1:Int32(size(uT, 2) / 2)
        plot!(
            uT[:, 2*(i-1)+1] .- k .* 273.15, uT[:, 2*(i-1)+2],
            seriestype=:line,
            linestyle=:dashdot,
            color=:blue
        )
    end
    for i = 1:Int32(size(ue, 2) / 2)
        plot!(
            ue[:, 2*(i-1)+1] .- k .* 273.15, ue[:, 2*(i-1)+2],
            seriestype=:line,
            linestyle=:dashdot,
            color=:red
        )
    end
    for i = 1:Int32(size(uh, 2) / 2)
        plot!(
            uh[:, 2*(i-1)+1] .- k .* 273.15, uh[:, 2*(i-1)+2],
            seriestype=:line,
            color=:black
        )
    end
    for i = 1:Int32(size(uH, 2) / 2)
        plot!(
            uH[:, 2*(i-1)+1] .- k .* 273.15, uH[:, 2*(i-1)+2],
            seriestype=:line,
            color=:gray
        )
    end

    fontSize = 8
    annotate!(285 .- k .* 273.15, 0.004, text(
        "20 kJ/kg",
        fontSize,
        :center, :center,
        :red,
        rotation=-28
    ))
    annotate!(290 .- k .* 273.15, 0.006, text(
        "30 kJ/kg",
        fontSize,
        :center,
        :center,
        :red,
        rotation=-28
    ))
    annotate!(293.8 .- k .* 273.15, 0.008, text(
        "0.84 cu.m/kg",
        fontSize,
        :center,
        :center,
        :green,
        rotation=-69
    ))
    annotate!(299.8 .- k .* 273.15, 0.01, text(
        "0.86 cu.m/kg",
        fontSize,
        :center,
        :center,
        :green,
        rotation=-69
    ))
    annotate!(329.7 .- k .* 273.15, 0.0062, text(
        unit == :°C ? "25 °C" : "289.15 K",
        fontSize,
        :center,
        :center,
        :blue,
        rotation=-29
    ))
    annotate!(329.7 .- k .* 273.15, 0.0152, text(
        unit == :°C ? "30 °C" : "303.15 K",
        fontSize,
        :center,
        :center,
        :blue,
        rotation=-30
    ))
    annotate!(329.7 .- k .* 273.15, 0.0264, text(
        unit == :°C ? "35 °C" : "319.15 K",
        fontSize,
        :center,
        :center,
        :blue,
        rotation=-31
    ))
    annotate!(319.2 .- k .* 273.15, 0.0151, text(
        "25 %",
        fontSize,
        :center,
        :center,
        :darkgray,
        rotation=51
    ))
    annotate!(316.7 .- k .* 273.15, 0.016, text(
        "30 %",
        fontSize,
        :center,
        :center,
        :darkgray,
        rotation=54
    ))
    annotate!(312.9 .- k .* 273.15, 0.0174, text(
        "40 %",
        fontSize,
        :center,
        :center,
        :gray,
        rotation=57
    ))
    annotate!(307.7 .- k .* 273.15, 0.0197, text(
        "60 %",
        fontSize,
        :center,
        :center,
        :gray,
        rotation=59
    ))
    annotate!(275 - k * 273.15, 38.7e-3, text(
        "Psychrometric Chart",
        "TamilMN-Bold",
        fontSize + 8,
        :center,
        :left,
        :black
    ))
    annotate!(275 - k * 273.15, 37.3e-3, text(
        "Sea level air-water vapor psychrometrics",
        "TamilMN-Bold",
        fontSize - 2,
        :center,
        :left,
        :black))
    annotate!(275 - k * 273.15, 36.6e-3, text(
        "https://github.com/aumpierre-unb/Psychrometrics.jl",
        "TamilMN-Bold",
        fontSize - 2,
        :center,
        :left,
        :black
    ))

    path = pathof(Psychrometrics)
    path = path[1:length(path)-length("src/Psychrometrics.jl")]
    file = string(path, "julia-logo-color.png")
    plot!(inset=bbox(
        0.035,
        0.11,
        0.1,
        0.1
    ))
    plot!(
        load(file),
        subplot=2,
        axis=false,
        grid=false
    )

    display(plot!(
        background_color=back
    ))
end
