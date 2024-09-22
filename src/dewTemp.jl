@doc raw"""
```
dewTemp( # dew point temperature in K
    pw::Number # water vapor pressure in Pa
    )
```

`dewTemp` computes
the dew point temperature Tdew (in K)
of humid air given
the water vapor pressure pw (in Pa).

`dewTemp` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat` and `doPlot`.

Examples
==========
Compute the dew temperature
of humid air given
the water vapor pressure is 1 kPa.

```
julia> dewTemp( # dew temperature in K
       1e3 # water vapor pressure in Pa
       )
280.14689999999996
```
"""
function dewTemp(
    pw::Number
)
    coeff = loadCoeffs()
    alpha = log(pw / 1000)
    coeff[14] +
    coeff[15] * alpha +
    coeff[16] * alpha^2 +
    coeff[17] * alpha^3 +
    coeff[18] * (pw / 1000)^0.1984 + 273.15
end
