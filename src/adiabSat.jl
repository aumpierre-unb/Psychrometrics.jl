@doc raw"""
```
adiabSat( # adiabatic saturation temperature in K
    h::Number; # specific enthalpy in J/kg of dry air
    fig::Bool=false, # show/omit chart
    back::Symbol=:white, # plot background color
    unit::Symbol=:K # units for temperature (:K or :°C)
    )
```

`adiabSat` computes
the adiabatic saturation temperature Tadiab (in K) and
the adiabatic saturation humidity Wadiab (in Kg/kg of dry air) given
the specific enthalpy h (in J/kg of dry air).

If fig = true is given, a schematic psychrometric chart
is plotted as a graphical representation
of the solution.

`adiabSat` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `enthalpy`, `volume` and `doPlot`.

Examples
==========
Compute the adiabatic saturation temperature given
the specific enthalpy is 82.4 kJ/kg of dry air and
plot a graphical representation of the
answer in a schematic psychrometric chart
with temperature in °C
with transparent background.

```
julia> Tadiab, Wadiab = adiabSat(
       82.4e3, # specific enthalpy in J/kg of dry air
       fig=true, # show plot
       back=:transparent, # plot background transparent
       unit=:°C # temperature in °C
       )
(299.55987637598975, 0.021893719698029654)
```
"""
function adiabSat(
    h::Number;
    fig::Bool=false,
    back::Symbol=:white,
    unit::Symbol=:K
)
    k = unit == :°C ? 1 : 0
    foo(Tadiab) = h - enthalpy(Tadiab, humidity(satPress(Tadiab)))
    Tadiab = newtonraphson(foo, 273.15, 1e-5)
    padiab = satPress(Tadiab)
    Wadiab = humidity(padiab)
    v = volume(Tadiab, Wadiab)
    if fig
        tv, wv = buildVolume(v)
        tb, wb = buildWetBulbTemp(Tadiab)
        te, we = buildEnthalpy(h)
        th, wh = buildHumidity(1)
        doPlot(
            back=back,
            unit=unit
        )
        plot!(
            tv .- k .* 273.15, wv,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:green
        )
        plot!(
            tb .- k .* 273.15, wb,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:blue
        )
        plot!(
            te .- k .* 273.15, we,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:red
        )
        plot!(
            th .- k .* 273.15, wh,
            seriestype=:line,
            linewidth=:2,
            color=:black
        )
        plot!(
            [Tadiab] .- k .* 273.15, [Wadiab],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:red,
            color=:red
        )
        display(plot!(
            [Tadiab, Tadiab, 60 + 273.15] .- k .* 273.15, [0, Wadiab, Wadiab],
            seriestype=:line,
            linestyle=:dash,
            color=:red
        ))
    end
    Tadiab - k * 273.15, Wadiab
end
