@doc raw"""
```
buildWetBulbTempLine(
    Twet::Number
    )
```

`buildWetBulbTempLine` generates two column matrix of
humidity and dry bulb temperature
with given constant wet bulb temperature Twet (in K).

By default, constant specific volume curves
are ploted with with blue solid thin lines.

`buildWetBulbTempLine` is an internal function of
the `Psychrometrics` package for Julia.
"""
function buildWetBulbTempLine(
    Twet::Number
)
    W = 0.04
    T1 = Twet
    foo = T -> W - humiditySatWet(humidity(satPress(Twet)), T, Twet)
    if humidity(satPress(T1)) > 0.04
        T1 = find_zero(foo, 50 + 273.15, rtol=1e-8)
    end
    W = 0
    T2 = find_zero(foo, 50 + 273.15, rtol=1e-8)
    if T2 > 60 + 273.15
        T2 = 60 + 273.15
    end
    N = 5
    T = []
    W = []
    for n = 1:N
        T = [T; T1 + (T2 - T1) / (N - 1) * (n - 1)]
        foo = W -> W - humiditySatWet(humidity(satPress(Twet)), T[end], Twet)
        W = [W; find_zero(foo, 1e-2, rtol=1e-8)]
    end
    T, W
end
