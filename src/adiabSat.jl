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

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `enthalpy`, `volume` and `buildBasicChart`.

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
    tempInKelvin = unit == :°C ? 1 : 0

    foo = Tadiab -> h - enthalpy(Tadiab, humidity(satPress(Tadiab)))
    Tadiab = find_zero(foo, 273.15, rtol=1e-8)
    padiab = satPress(Tadiab)
    Wadiab = humidity(padiab)
    v = volume(Tadiab, Wadiab)

    fig && doShowPlot(
        HumidAir(
            Tadiab,
            Tadiab,
            Tadiab,
            Tadiab,
            Wadiab,
            Wadiab,
            Wadiab,
            Wadiab,
            1,
            h,
            v,
            padiab,
            padiab,
            padiab,
            padiab
        ),
        back,
        unit
    )

    Tadiab - tempInKelvin * 273.15, Wadiab
end
