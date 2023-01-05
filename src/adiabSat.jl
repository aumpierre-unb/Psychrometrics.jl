@doc raw"""

`Tadiab,Wadiab=adiabSat(h[,fig=false])`

`adiabSat` computes
the adiabatic saturation temperature Tadiab (in K) and
the adiabatic saturation humidity Wadiab (in Kg/kg of dry air) given
the specific enthalpy h (in J/kg of dry air).

If fig = true is given, a schematic psychrometric chart
is plotted as a graphical representation
of the solution.

`adiabSat` is a main function of
the `Psychrometrics` package for Julia.

Examples
==========
Compute the adiabatic saturation temperature given
the specific enthalpy is 82.4 kJ/kg of dry air and
plot a graphical representation of the
answer in a schematic psychrometric chart.

```
h=82.4e3; # specific enthalpy in J/kg
Tadiab,Wadiab=adiabSat(h,true) # inputs and outputs in SI units
```
"""
function adiabSat(h::Number, fig::Bool=false)
    foo(Tadiab) = h - enthalpy(Tadiab, humidity(satPress(Tadiab)))
    Tadiab = newtonraphson(foo, 273.15, 1e-5)
    padiab = satPress(Tadiab)
    Wadiab = humidity(padiab)
    if fig
        tv, wv = buildVolume(v)
        tb, wb = buildWetBulbTemp(Twet)
        te, we = buildEnthalpy(h)
        th, wh = buildHumidity(phi)
        doPlot()
        plot!(tv, wv,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:green)
        plot!(tb, wb,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:blue)
        plot!(te, we,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:red)
        plot!(th, wh,
            seriestype=:line,
            linewidth=:2,
            color=:black)
        plot!([Tadiab], [Wadiab],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:red,
            color=:red)
        display(plot!([Tadiab, Tadiab, 60 + 273.15], [0, Wadiab, Wadiab],
            seriestype=:line,
            linestyle=:dash,
            color=:red))
    end
    return [Tadiab; Wadiab]
end
