@doc raw"""
`W=humidity(pw[,p])`

`humidity` computes
the humidity
of humid air in (kg/kg of dry air) given
the water vapor pressure (in Pa) and
the total pressure (in Pa).

By default, total pressure is assumed
to be the atmospheric pressure
at sea level (101325 Pa).

`humidity` is a main function of
the psychrometrics toolbox for Julia.

Examples
==========
Compute the humidity of humid air
at atmospheric pressure given
water vapor pressure is 1 kPa
at 1 atm total pressure.

```
pw=1e3; # water vapor pressure in Pa
W=humidity(pw) # saturation pressure in kg/kg of dry air
```
"""
function humidity(pw::Number,p::Number=101325)
    return 0.621945*pw/(p-pw)
end
