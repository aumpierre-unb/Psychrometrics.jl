@doc raw"""
```
volume( # specific enthalpy in J/kg of dry air
    Tdry::Number, # dry bulb temperature in K
    W::Number, # humidity in kg/kg of dry air
    p::Number=101325 # total pressure in Pa
    )
```

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

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `enthalpy`, `adiabSat` and `doPlot`.

Examples
==========
Compute the specific volume given
the dry bulb temperature is 25 °C and
the humidity is 7 g/kg of dry air
at 1 atm total pressure.

```
julia> volume( # specific volume in cu. m/kg of dry air
       25 + 273.15, # dry bulb temperature in K 
       7e-3 # humidity in kg/kg of dry air
       )
0.8541303593743654
```
"""
function volume(
    Tdry::Number,
    W::Number,
    p::Number=101325
)
    0.287042 * Tdry * (1 + 1.6078 * W) / (p / 1000)
end
