@doc raw"""
```
doShowPlot(
    air::HumidAir,
    back::Symbol,
    unit::Symbol
    )
```

`doShowPlot` plots
a schematic psychrometric chart with
highlighted guidelines for 
the wet bulb temperature, 
the specific enthalpy, 
the specific volume and
the relative humidity of 
the given psychrometric parameters.

`doShowPlot` is an internal function of
the `Psychrometrics` package for Julia.
"""
function doShowPlot(
    air::HumidAir,
    back::Symbol,
    unit::Symbol
)

    buildBasicChart(
        back=back,
        unit=unit
    )

    tb, wb = buildWetBulbTempLine(air.Twet)
    te, we = buildEnthalpyLine(air.h)
    tv, wv = buildVolumeLine(air.v)
    th, wh = buildHumidityLine(air.φ)

    tempInKelvin = unit == :°C ? 1 : 0

    plot!(
        tv .- tempInKelvin .* 273.15, wv,
        seriestype=:line,
        linestyle=:dash,
        linewidth=:2,
        color=:green
    )
    plot!(
        tb .- tempInKelvin .* 273.15, wb,
        seriestype=:line,
        linestyle=:dash,
        linewidth=:2,
        color=:blue
    )
    plot!(
        te .- tempInKelvin .* 273.15, we,
        seriestype=:line,
        linestyle=:dash,
        linewidth=:2,
        color=:red
    )
    plot!(th .- tempInKelvin .* 273.15, wh,
        seriestype=:line,
        linewidth=:2,
        color=:black)

    plot!(
        [air.Tadiab] .- tempInKelvin .* 273.15, [air.Wadiab],
        seriestype=:scatter,
        markersize=:5,
        markerstrokecolor=:red,
        color=:red
    )
    plot!(
        [air.Tadiab, air.Tadiab, 60 + 273.15] .- tempInKelvin .* 273.15, [0, air.Wadiab, air.Wadiab],
        seriestype=:line,
        linestyle=:dash,
        color=:red
    )

    if air.φ == 1
        display(plot!())
        return
    end

    plot!(
        [air.Tdry] .- tempInKelvin .* 273.15, [air.W],
        seriestype=:scatter,
        markersize=:5,
        markerstrokecolor=:green,
        color=:green
    )
    plot!(
        [air.Twet] .- tempInKelvin .* 273.15, [air.Wsatwet],
        seriestype=:scatter,
        markersize=:5,
        markerstrokecolor=:blue,
        color=:blue
    )
    plot!(
        [air.Tdry] .- tempInKelvin .* 273.15, [air.Wsat],
        seriestype=:scatter,
        markersize=:5,
        markerstrokecolor=:black,
        color=:black
    )
    plot!(
        [air.Tdew] .- tempInKelvin .* 273.15, [air.W],
        seriestype=:scatter,
        markersize=:5,
        markerstrokecolor=:black,
        color=:black
    )
    plot!(
        [air.Tdew, air.Tdew, 60 + 273.15] .- tempInKelvin .* 273.15, [0, air.W, air.W],
        seriestype=:line,
        linestyle=:dash,
        color=:black
    )
    plot!(
        [air.Tdry, air.Tdry, 60 + 273.15] .- tempInKelvin .* 273.15, [0, air.Wsat, air.Wsat],
        seriestype=:line,
        linestyle=:dash,
        color=:black
    )
    plot!(
        [air.Twet, air.Twet, 60 + 273.15] .- tempInKelvin .* 273.15, [0, air.Wsatwet, air.Wsatwet],
        seriestype=:line,
        linestyle=:dash,
        color=:blue
    )

    display(plot!())
end