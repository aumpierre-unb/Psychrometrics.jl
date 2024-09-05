@doc raw"""

`humidity(pw::Number, p::Number=101325)`

`humidity` computes
the humidity W (in kg/kg of dry air) 
of humid air given
the water vapor pressure pw (in Pa) and
the total pressure p (in Pa).

By default, total pressure is assumed
to be the atmospheric pressure
at sea level, p = 101325.

`humidity` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `satPress`, `enthalpy`, `volume`, `adiabSat` and `doPlot`.

Examples
==========
Compute the humidity of humid air
at atmospheric pressure given
water vapor pressure is 1 kPa
at 1 atm total pressure.

```
pw = 1e3; # water vapor pressure in Pa
W = humidity(pw) # saturation pressure in kg/kg of dry air
```
"""
function humidity(
    pw::Number,
    p::Number=101325
)
    0.621945 * pw / (p - pw)
end
