@doc raw"""
```
humiditySatWet(
    Wsatwet::Number,
    Tdry::Number,
    Twet::Number
    )
```

`humiditySatWet` computes
the humidity W (in kg/kg of dry air)
of humid air given
the saturation humidity Wsatwet (in kg/kg of dry air) at wet bulb temperature,
the dry bulb temperature (in K) and
the wet bulb temperature (in K).

`humiditySatWet` is an internal function of
the `Psychrometrics` package for Julia.
"""
function humiditySatWet(
    Wsatwet::Number,
    Tdry::Number,
    Twet::Number
)
    (
        (2501 - 2.326 * (Twet - 273.15)) * Wsatwet - 1.006 * (Tdry - Twet)
    ) / (
        2501 + 1.86 * (Tdry - 273.15) - 4.186 * (Twet - 273.15)
    )
end
