@doc raw"""
```
newtonraphson(
    f::Function,
    x::Number,
    ξ::Number
)
```

`newtonraphson` computes the root of
a function f(x) from a guess value x
within a given tolerance ξ for f(x)
using the method of Newton-Raphson.

`newtonraphson` is an internal function of
the `Psychrometrics` package for Julia.

"""
function newtonraphson(
    f::Function,
    x::Number,
    ξ::Number
)
    find_zero(f, x; atol=ξ)
end
