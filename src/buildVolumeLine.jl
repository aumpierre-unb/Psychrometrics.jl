@doc raw"""
```
buildVolumeLine(
    v::Number
    )
```

`buildVolumeLine` generates a two column matrix of
humidity and dry bulb temperature
with given constant specific volume v (in cu. m/kg).

By default, constant specific volume curves
are ploted with with green dash-doted thin lines.

`buildVolumeLine` is an internal function of
the `Psychrometrics` package for Julia.
"""
function buildVolumeLine(
    v::Number
)
    foo = T -> v - volume(T, humidity(satPress(T)))
    T1 = find_zero(foo, 50 + 273.15, rtol=1e-8)
    if humidity(satPress(T1)) > 0.04
        W = 0.04
        foo = T -> v - volume(T, W)
        T1 = find_zero(foo, 50 + 273.15, rtol=1e-8)
    end
    W = 0
    foo = T -> v - volume(T, W)
    T2 = find_zero(foo, T1, rtol=1e-8)
    if T2 > 60 + 273.15
        T2 = 60 + 273.15
    end
    N = 5
    T = []
    W = []
    for n = 1:N
        T = [T; T1 + (T2 - T1) / (N - 1) * (n - 1)]
        foo = W -> v - volume(T[end], W)
        W = [W; find_zero(foo, 1e-2, rtol=1e-8)]
    end
    T, W
end
