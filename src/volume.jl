@doc raw"""

`volume(Tdry::Number,W::Number,p::Number=101325)`

`volume` computes
the specific volume v (in cu. m/kg of dry air)
of humid air given
the dry bulb temperature Tdry (in K),
the humidity W (in kg/kg of dry air) and
the total pressure p (in Pa).

By default, total pressure is assumed
to be the atmospheric pressure
at sea level, p = 101325.

`volume` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `enthalpy`, adiabSat`.

Examples
==========
Compute the specific volume given
the dry bulb temperature is 25 °C and
the humidity is 7 g/kg of dry air
at 1 atm total pressure.

```
W=7e-3; # humidity in kg/kg of dry air
v=volume(Tdry,W) # specific volume in cu. m/kg of dry air
```
"""
function volume(Tdry::Number, W::Number, p::Number=101325)
    0.287042 * Tdry * (1 + 1.6078 * W) / (p / 1000)
end
