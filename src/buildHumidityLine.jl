@doc raw"""
```
buildHumidityLine(
    φ::Number
    )
```

`buildHumidityLine` generates a two column matrix of
humidity and dry bulb temperature
with given constant relative humidity.

By default, constant relative humidity curves
are ploted with black solid thin lines.

`buildHumidityLine` is an internal function of
the `Psychrometrics` package for Julia.
"""
function buildHumidityLine(
    φ::Number
)
    foo(T) = 0.04 - humidity(satPress(T) * φ)
    T1 = 273.15
    T2 = find_zero(foo, 60 + 273.15, rtol=1e-8)
    if T2 > 60 + 273.15
        T2 = 60 + 273.15
    end
    N = 30
    T = []
    W = []
    for n = 1:N
        T = [T; T1 + (T2 - T1) / (N - 1) * (n - 1)]
        psat = satPress(T[end])
        pw = psat * φ
        W = [W; humidity(pw)]
    end
    T, W
end
