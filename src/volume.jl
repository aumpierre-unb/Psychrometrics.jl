@doc raw"""
`h=enthalpy(Tdry,W)`

`volume` computes
the specific volume (in cu. m/kg of dry air)
of humid air given
the dry bulb temperature (in K),
the humidity in (kg/kg of dry air) and
the total pressure (in Pa).

By default, total pressure is assumed
to be the atmospheric pressure
at sea level (101325 Pa).

`volume` is a main function of
the psychrometrics toolbox for Julia.

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
function volume(Tdry,W,p=101325)
    return 0.287042*Tdry*(1+1.6078*W)/(p/1000)
end
