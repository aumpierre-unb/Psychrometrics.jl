@doc raw"""
```
buildVolume(
    v::Number
    )
```

`buildVolume` generates a two column matrix of
humidity and dry bulb temperature
with given constant specific volume v (in cu. m/kg).

By default, constant specific volume curves
are ploted with with green dash-doted thin lines.

`buildVolume` is an internal function of
the `Psychrometrics` package for Julia.
"""
function buildVolume(
    v::Number
)
    foo1(T) = v - volume(T, humidity(satPress(T)))
    foo2(T) = v - volume(T, W)
    foo3(W) = v - volume(T[end], W)
    ξ = v / 1e3
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
