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

export k_minusC, k_plusC

function k_minusC(T::Number)
    k = COEFF[1] / T +
        COEFF[2] +
        COEFF[3] * T +
        COEFF[4] * T^2 +
        COEFF[5] * T^3 +
        COEFF[6] * T^4 +
        COEFF[7] * log(T)
    return k    
end

function k_plusC(T::Number)
    k = COEFF[8] / T +
        COEFF[9] +
        COEFF[10] * T +
        COEFF[11] * T^2 +
        COEFF[12] * T^3 +
        COEFF[13] * log(T)
    return k
end

function k_func(T::Number)
    if T <= 0
        return NaN # NaN gives an error when iteration runs off.
    elseif T <= 273.15
        return k_minusC(T)
    else
        return k_plusC(T)
    end
end

function satPress(T::Number)
    k = k_func(T)
    exp(k)
end
