@doc raw"""

```
satPress( # saturation pressure in Pa
    Tdry::Number # dry bulb temperature in K
    )
```

`satPress` computes
the saturation pressure psat (in pa)
of humid air given
the dry bulb temperature Tdry (in K).

`satPress` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `humidity`, `enthalpy`, `volume`, `adiabSat` and `doPlot`.

Examples
==========
Compute the saturation pressure given
the dry bulb temperature is 25 °C.

```
satPress( # saturation pressure in Pa
    25 + 273.15; # dry bulb temperature in K
    )
```
"""
function satPress(
    Tdry::Number
)
    c = loadConstants()
    if -100 <= Tdry - 273.15 && Tdry - 273.15 < 0
        k = c[1] / Tdry +
            c[2] +
            c[3] * Tdry +
            c[4] * Tdry^2 +
            c[5] * Tdry^3 +
            c[6] * Tdry^4 +
            c[7] * log(Tdry)
    elseif 0 <= Tdry - 273.15 && Tdry - 273.15 <= 200
        k = c[8] / Tdry +
            c[9] +
            c[10] * Tdry +
            c[11] * Tdry^2 +
            c[12] * Tdry^3 +
            c[13] * log(Tdry)
    else
        error(
            "Temperature must be in the range from 173.15 K to 473.15 K"
        )
    end
    exp(k)
end
