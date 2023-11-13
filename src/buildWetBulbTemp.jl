# include("satPress.jl")
# include("newtonraphson.jl")
# include("humidity.jl")
# include("humidity2.jl")

@doc raw"""

`buildWetBulbTemp(Twet)`

`buildWetBulbTemp` generates two column matrix of
humidity and dry bulb temperature
with given constant wet bulb temperature Twet (in K).

By default, constant specific volume curves
are ploted with with blue solid thin lines.

`buildWetBulbTemp` is an internal function of
the `Psychrometrics` package for Julia.
"""
function buildWetBulbTemp(Twet)
    foo1(T) = W - humidity2(humidity(satPress(Twet)), T, Twet)
    foo2(W) = W - humidity2(humidity(satPress(Twet)), T[end], Twet)
    W = 0.03
    tol = W / 1e3
    T1 = Twet
    if humidity(satPress(T1)) > 0.03
        T1 = newtonraphson(foo1, 50 + 273.15, tol)
    end
    W = 0
    T2 = newtonraphson(foo1, 50 + 273.15, tol)
    if T2 > 60 + 273.15
        T2 = 60 + 273.15
    end
    N = 5
    T = []
    W = []
    for n = 1:N
        T = [T; T1 + (T2 - T1) / (N - 1) * (n - 1)]
        W = [W; newtonraphson(foo2, 1e-2, tol)]
    end
    return T, W
end

