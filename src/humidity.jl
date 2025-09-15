@doc raw"""
```
humidity( # humidity in kg/kg of dry air
    pw::Number, # water vapor pressure in Pa
    p::Number=101325 # total pressure in Pa
    )
```

`humidity` computes
the humidity (in kg/kg of dry air) 
of humid air given
the water vapor pressure (in Pa) and
the total pressure (in Pa).

By default, total pressure is assumed
to be the atmospheric pressure
at sea level (101325 Pa).

`humidity` computes
the humidity W (in kg/kg of dry air)
of humid air given
the saturation humidity Wsatwet (in kg/kg of dry air) at wet bulb temperature,
the dry bulb temperature (in K) and
the wet bulb temperature (in K).

`humidity` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `satPress`, `enthalpy`, `volume`, `adiabSat` and `buildBasicChart`.

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
the water vapor pressure 1 kPa and
the total pressure 101325 Pa.

```
julia> humidity( # humidity in kg/kg of dry air
       1e3, # water vapor pressure in Pa
       101325 # total pressure in Pa
       )
0.0006144183749073845
```

Compute the humidity of humid air
at atmospheric pressure given
the dry bulb temperature 300 K and
the wet bulb temperature 290 K.

```
julia> humidity( # humidity in kg/kg of dry air
       300, # dry bulb temperature in K
       290 # wet bulb temperature in K
       )
0.007864386844075
```
"""
function humidity(
    pw::Number;
    p::Number=101325
)
    W = 0.621945 * pw / (p - pw)
end

function humidity(
    Tdry::Number,
    Twet::Number
)
    psatwet = satPress(Twet)
    Wsatwet = humidity(psatwet)
    return (
        (2501 - 2.326 * (Twet - 273.15)) * Wsatwet - 1.006 * (Tdry - Twet)
    ) / (
        2501 + 1.86 * (Tdry - 273.15) - 4.186 * (Twet - 273.15)
    )
end

