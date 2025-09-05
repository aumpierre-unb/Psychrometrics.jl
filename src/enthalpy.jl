@doc raw"""
```
enthalpy( # specific enthalpy in kJ/kg of dry air
    Tdry::Number, # dry bulb temperature in K
    W::Number # humidity in kg/kg of dry air
    )
```

`enthalpy` computes
the specific enthalpy h (in J/kg of dry air)
of humid air given
the dry bulb temperature Tdry (in K) and
the humidity W (in kg/kg of dry air).

`enthalpy` is a main function of
the `Psychrometrics` package for Julia.

See also: `psychro`, `dewTemp`, `humidity`, `satPress`, `volume`, `adiabSat` and `buildBasicChart`.

Examples
==========
Compute the specific enthalpy given
the dry bulb temperature is 25 °C and
the humidity is 7 g/kg of dry air.

```
julia> enthalpy( # specific enthalpy in J/kg of dry air
       25 + 273.15, # dry bulb temperature in K
       7e-3 # humidity in kg/kg of dry air
       )
42982.5
```
"""
function enthalpy(
    Tdry::Number,
    W::Number
)
    (1.006 * (Tdry - 273.15) + W * (2501 + 1.86 * (Tdry - 273.15))) * 1e3
end
