include("satPress.jl")
include("newtonraphson.jl")
include("humidity.jl")

@doc raw"""
`buildHumidity(phi)`

`buildHumidity` generates a two column matrix of
#  humidity and dry bulb temperature
#  with given constant relative humidity.
# By default, constant relative humidity curves
#  are ploted with black solid thin lines

`buildHumidity` is an internal function of
the psychrometrics toolbox for Julia.
"""
function buildHumidity(phi::Number)
    foo(T) = 0.03 - humidity(satPress(T) * phi)
    T1 = 273.15
    tol = 0.03 / 1e3
    T2 = newtonraphson(foo, 100 + 273.15, tol)
    if T2 > 60 + 273.15
        T2 = 60 + 273.15
    end
    N = 20
    T = []
    W = []
    for n = 1:N
        T = [T; T1 + (T2 - T1) / (N - 1) * (n - 1)]
        psat = satPress(T[end])
        pw = psat * phi
        W = [W; humidity(pw)]
    end
    return [T, W]
end
