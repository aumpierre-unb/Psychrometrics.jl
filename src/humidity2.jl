@doc raw"""
`W=humidity2(Wsatwet,Tdry,Twet)`

`humidity2` computes
the humidity
of humid air given
the saturation humidity at wet bulb temperature,
the dry bulb temperature (in K) and
the wet bulb temperature (in K).

`humidity2` is an internal function of
the psychrometrics toolbox for Julia.
"""
function humidity2(Wsatwet::Number, Tdry::Number, Twet::Number)
    return ((2501 - 2.326 * (Twet - 273.15)) * Wsatwet - 1.006 * (Tdry - Twet)) / (2501 + 1.86 * (Tdry - 273.15) - 4.186 * (Twet - 273.15))
end
