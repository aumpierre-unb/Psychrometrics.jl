@doc raw"""
```
satPress( # saturation pressure in Pa
    Tdry::Number # dry bulb temperature in K
    )
```

`satPress` computes
the saturation pressure psat (in pa)
of humid air given the dry bulb temperature Tdry (in K).

`satPress` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `humidity`, `enthalpy`, `volume`, `adiabSat` and `buildBasicChart`.

Examples
==========
Compute the saturation pressure given
the dry bulb temperature is 25 °C.

```
julia> satPress( # saturation pressure in Pa
       25 + 273.15; # dry bulb temperature in K
       )
3169.2164701436277
```
"""
function satPress(
    Tdry::Number
)
    if (-100 <= Tdry - 273.15) && (Tdry - 273.15 < 0)
        k = coeffs[1] / Tdry +
            coeffs[2] +
            coeffs[3] * Tdry +
            coeffs[4] * Tdry^2 +
            coeffs[5] * Tdry^3 +
            coeffs[6] * Tdry^4 +
            coeffs[7] * log(Tdry)
        return exp(k)
    elseif (0 <= Tdry - 273.15) && (Tdry - 273.15 <= 200)
        k = coeffs[8] / Tdry +
            coeffs[9] +
            coeffs[10] * Tdry +
            coeffs[11] * Tdry^2 +
            coeffs[12] * Tdry^3 +
            coeffs[13] * log(Tdry)
        return exp(k)
    else
        printstyled(
            "Temperature must be in the range from 173.15 K to 473.15 K.\n",
            color=:red
        )
    end
end
