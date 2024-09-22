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

See also: `psychro`, `dewTemp`, `humidity`, `enthalpy`, `volume`, `adiabSat` and `doPlot`.

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
    coeff = loadCoeffs()
    if -100 <= Tdry - 273.15 && Tdry - 273.15 < 0
        k = coeff[1] / Tdry +
            coeff[2] +
            coeff[3] * Tdry +
            coeff[4] * Tdry^2 +
            coeff[5] * Tdry^3 +
            coeff[6] * Tdry^4 +
            coeff[7] * log(Tdry)
    elseif 0 <= Tdry - 273.15 && Tdry - 273.15 <= 200
        k = coeff[8] / Tdry +
            coeff[9] +
            coeff[10] * Tdry +
            coeff[11] * Tdry^2 +
            coeff[12] * Tdry^3 +
            coeff[13] * log(Tdry)
    else
        printstyled(
            "Temperature must be in the range from 173.15 K to 473.15 K.\n",
            color=:red
        )
    end
    exp(k)
end
