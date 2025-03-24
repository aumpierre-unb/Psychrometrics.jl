@doc raw"""
```
humidity( # humidity in kg/kg of dry air
    pw::Number, # water vapor pressure in Pa
    p::Number=101325 # total pressure in Pa
    )
```

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
julia> humidity( # humidity in kg/kg of dry air
       1e3 # water vapor pressure in Pa
       )
0.006199302267630201
```

Compute the humidity of humid air
at atmospheric pressure given
dry bulb temperature is 305 K and
relative humidiy is 50 %
at 101325 Pa total pressure.

```
julia> state = psychro(
       Tdry=305., # dry bulb temperature
       φ=0.50 # relative humidity
       );
julia> state.W # absolute humidity calculated by psychro
0.014825989559787502
julia> pw = state.φ * state.psat # water vapor pressure, by definition
2359.158028201002
julia> W = humidity(pw)
0.014825989559787502
julia> W = 0.621945 * pw / (101325 - pw) # absolute humidity, by definition
0.014825989559787502
```

Compute the humidity of humid air
at atmospheric pressure given
water vapor pressure is 1 kPa
at 10 atm total pressure.

```
julia> humidity( # humidity in kg/kg of dry air
       1e3, # water vapor pressure in Pa
       101325e1 # total pressure in Pa
       )
0.0006144183749073845
```
"""
function humidity(
    pw::Number,
    p::Number=101325
)
    0.621945 * pw / (p - pw)
end
