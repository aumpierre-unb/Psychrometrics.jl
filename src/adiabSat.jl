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
the dry bulb temperature and
the humidity given
the specific enthalpy (in J/kg of dry air).

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
       82.4e3 # specific enthalpy in J/kg of dry air
       )
(299.55987637598975, 0.021893719698029654)
```
"""
function adiabSat(
    h::Number
)
    foo = Tadiab -> h - enthalpy(Tadiab, humidity(satPress(Tadiab)))
    Tadiab = find_zero(foo, 273.15, rtol=1e-8)
    padiab = satPress(Tadiab)
    Wadiab = humidity(padiab)

    Tadiab, Wadiab

end
