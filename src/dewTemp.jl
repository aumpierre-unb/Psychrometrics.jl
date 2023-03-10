include("constants.jl")

@doc raw"""

`Tdew=dewTemp(pw)`

`dewTemp` computes
the dew point temperature Tdew (in K)
of humid air given
the water vapor pressure pw (in Pa).

`dewTemp` is a main function of
the `Psychrometrics` package for Julia.

Examples
==========
Compute the dew temperature
of humid air given
the water vapor pressure is 1 kPa.

```
pw=1e3; # water vapor pressure in Pa
Tdew=dewTemp(pw) # dew temperature at K
```
"""
function dewTemp(pw::Number)
    alpha = log(pw / 1000)
    return c[14] +
           c[15] * alpha +
           c[16] * alpha^2 +
           c[17] * alpha^3 +
           c[18] * (pw / 1000)^0.1984 + 273.15
end
