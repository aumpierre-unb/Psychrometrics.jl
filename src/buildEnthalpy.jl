@doc raw"""
```
buildEnthalpy(
    h::Number
    )
```

`buildEnthalpy` generates a two column matrix of
humidity and dry bulb temperature
with given constant specific enthalpy h (in J/kg).

By default, constant specific enthalpy curves
are ploted with red dash-doted thin lines.

`buildEnthalpy` is an internal function of
the `Psychrometrics` package for Julia.
"""
function buildEnthalpy(
    h::Number
)
    foo1(T) = h - enthalpy(T, humidity(satPress(T)))
    foo2(T) = h - enthalpy(T, W)
    foo3(W) = h - enthalpy(T[end], W)
    ξ = h / 1e3
    T1 = newtonraphson(foo1, 50 + 273.15, ξ)
    if humidity(satPress(T1)) > 0.04
        W = 0.04
        T1 = newtonraphson(foo2, 50 + 273.15, ξ)
    end
    W = 0
    T2 = newtonraphson(foo2, T1, ξ)
    if T2 > 60 + 273.15
        T2 = 60 + 273.15
    end
    N = 5
    T = []
    W = []
    for n = 1:N
        T = [T; T1 + (T2 - T1) / (N - 1) * (n - 1)]
        W = [W; newtonraphson(foo3, 1e-2, ξ)]
    end
    T, W
end
