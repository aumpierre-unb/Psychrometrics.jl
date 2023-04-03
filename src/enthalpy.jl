@doc raw"""

`h=enthalpy(Tdry,W)`

`enthalpy` computes
the specific enthalpy h (in J/kg of dry air)
of humid air given
the dry bulb temperature Tdry (in K) and
the humidity W (in kg/kg of dry air).

`enthalpy` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `volume`, `adiabSat`.

Examples
==========
Compute the specific enthalpy given
the dry bulb temperature is 25 °C and
the humidity is 7 g/kg of dry air.

```
Tdry=25+273.15; # dry bulb temperature in K
W=7e-3; # humidity in kg/kg of dry air
h=enthalpy(Tdry,W) # specific enthalpy in J/kg of dry air
```
"""
function enthalpy(Tdry::Number, W::Number)
    return (1.006 * (Tdry - 273.15) + W * (2501 + 1.86 * (Tdry - 273.15))) * 1e3
end
