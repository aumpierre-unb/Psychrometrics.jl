@doc raw"""
`Tadiab,Wadiab=adiabSat(h[,fig=false])`

`adiabSat` computes
the adiabatic saturation temperature (in K) and
the adiabatic saturation humidity (in Kg/kg of dry air) given
the specific enthalpy h (in J/kg of dry air).

If fig = true is given, a schematic psychrometric chart
is plotted as a graphical representation
of the solution.

`adiabSat` is a main function of
the psychrometrics toolbox for Julia.

Examples
==========
Compute the adiabatic saturation temperature given
the specific enthalpy is 82.4 kJ/kG of dry air and
plot a graphical representation of the
answer in a schematic psychrometric chart.

```
h=82.4e3; # specific enthalpy in J/kG
Tadiab,Wadiab=adiabSat(h,true) # inputs and outputs in SI units
```
"""
function adiabSat(h,fig=false)
    foo(Tadiab) h-enthalpy(Tadiab,humidity(satPress(Tadiab),:))
    Tadiab=newtonraphson(foo,273.15,1e-5)
    padiab=satPress(Tadiab)
    Wadiab=humidity(padiab,:)
    if fig
        doPlot
        plotHumidity(1,'k',2)
        plotEnthalpy(h,'-.r',2)
        plot(Tadiab,Wadiab,'or','markersize',8)
    end
    return Tadiab,Wadiab
end
