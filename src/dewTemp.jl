@doc raw"""
```
dewTemp( # dew point temperature in K
    pw::Number # water vapor pressure in Pa
    )
```

`dewTemp` computes
the dew point temperature (in K)
of humid air given
the water vapor pressure (in Pa).

`dewTemp` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat` and `buildBasicChart`.

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
    alpha = log(pw / 1000)
    coeffs[14] +
    coeffs[15] * alpha +
    coeffs[16] * alpha^2 +
    coeffs[17] * alpha^3 +
    coeffs[18] * (pw / 1000)^0.1984 + 273.15
end
