# Psychrometrics.jl

[![DOI](https://zenodo.org/badge/543161141.svg)](https://doi.org/10.5281/zenodo.7493474)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![version](https://juliahub.com/docs/Psychrometrics/version.svg)](https://juliahub.com/ui/Packages/Psychrometrics/WauTj)
[![pkgeval](https://juliahub.com/docs/General/Psychrometrics/stable/pkgeval.svg)](https://juliahub.com/ui/Packages/General/Psychrometrics)

## Installing and Loading Psychrometrics

Psychrometrics can be installed and loaded either
from the JuliaHub repository (last released version) or from the
[maintainer's repository](https://github.com/aumpierre-unb/Psychrometrics.jl).

### Last Released Version

The last version of Psychrometrics can be installed from JuliaHub repository:

```julia
using Pkg
Pkg.add("Psychrometrics")
using Psychrometrics
```

If Psychrometrics is already installed, it can be updated:

```julia
using Pkg
Pkg.update("Psychrometrics")
using Psychrometrics
```

### Pre-Release (Under Construction) Version

The pre-release (under construction) version of Psychrometrics
can be installed from the [maintainer's repository](https://github.com/aumpierre-unb/Psychrometrics.jl).

```julia
using Pkg
Pkg.add(path="https://github.com/aumpierre-unb/Psychrometrics.jl")
using Psychrometrics
```

## Citation of Psychrometrics

You can cite all versions (both released and pre-released), by using
[10.5281/zenodo.7493474](https://doi.org/10.5281/zenodo.7493474).

This DOI represents all versions, and will always resolve to the latest one.

For citation of the last released version of Psychrometrics, please check CITATION file at the [maintainer's repository](https://github.com/aumpierre-unb/Psychrometrics.jl).

## The Psychrometrics Module for Julia

`Psychrometrics` provides a set of functions to compute the various variables related to water vapor humid air, providing the following functions:

- **psychro**
- **humidity**
- **satPress**
- **enthalpy**
- **volume**
- **adiabSat**
- **dewTemp**
- **doPlot**

### **psychro**

`psychro` computes

- the dry bulb temperature,
- the wet bulb temperature,
- the dew point temperature,
- the adiabatic saturation temperature,
- the humidity,
- the saturation humidity,
- the saturation humidity at wet bulb temperature,
- the adiabatic saturation humidity,
- the relative humidity,
- the specific enthalpy,
- the specific volume,
- the density,
- the water vapor pressure,
- the saturation pressure and
- the saturation pressure at wet bulb temperature.

given any two of the following parameters:

- the dry bulb temperature,
- the wet bulb temperature,
- the dew point temperature,
- the humidity,
- the specific enthalpy,
- the specific volume and
- the relative humidity,

except for the combination of humidity and dew point temperature,
which are not mutually independent.

If a different number of parameters is given,
execution will be aborted.

If fig = true is given
a schematic psychrometric chart is plotted
as a graphical representation of the solution.

By default,
`psychro` plots a schematic psychrometric chart
with the solution (fig = true)
with white background (back = :white).
If fig = false is given, plot is omitted.

**Syntax:**

```julia
psychro(;
    Tdry::Number=NaN, # dry bulb temperature
    Twet::Number=NaN,  # wet bulb temperature
    Tdew::Number=NaN, # dew bulb temperature
    W::Number=NaN, # absolute humidity
    φ::Number=NaN, # relative humidity
    h::Number=NaN, # specific enthalpy
    v::Number=NaN, # specific volume
    fig::Bool=false, # show/ommit chart
    back::Symbol=:white # plot background color
    )::HumidAir
```

**Examples:**

Compute the dry bulb temperature,
the wet bulb temperature,
the dew point temperature,
the adiabatic saturation temperature,
the humidity,
the saturation humidity,
the saturation humidity at wet bulb temperature,
the adiabatic saturation humidity,
the relative humidity,
the specific enthalpy,
the specific volume,
the density,
the water vapor pressure,
the saturation pressure,
the saturation pressure at wet bulb temperature given
the dew point temperature is 22 °C and
the relative humidity is 29 %.

```julia
humidAir = psychro( # all results ordered in one tuple
    Tdew=22 + 273.15, # dew temperature in K
    φ=0.29, # relative humidity
    fig=true # show plot
    )
```

Compute the dry bulb temperature,
the wet bulb temperature,
the dew point temperature,
the adiabatic saturation temperature,
the humidity,
the saturation humidity,
the saturation humidity at wet bulb temperature,
the adiabatic saturation humidity,
the relative humidity,
the specific enthalpy,
the specific volume,
the density,
the water vapor pressure,
the saturation pressure,
the saturation pressure at wet bulb temperature given
the specific enthalpy is 79.5 kJ/kg and
the relative humidity is 29 # and
plot a graphical representation of the
answer in a schematic psychrometric chart.

```julia
psychro(
    h=79.5e3, # specific enthalpy in kJ/kg of dry air
    φ=0.29, # relative humidity
    fig=true # show plot
    )
```

8.5 cubic meters of humid air at
dry bulb temperature of 293 K and
wet bulb temperature of 288 K
is subjected to two cycles of
heating to 323 and adiabatic saturation.
Compute the energy and water vapor demands.
Assume the amount of dry air is constant.

```julia
# The volume of humid air is
V = 8.5;
# The initial condition is
Tdry1 = 293;
Twet1 = 288;
(
    Tdry1, Twet1, Tdew1, Tadiab1,
    W1, Wsat1, Wsatwet1, Wadiab1,
    φ1,
    h1, v1,
    pw1, psat1, psatwet1,
    ρ1
    ) = psychro(Tdry=Tdry1, Twet=Twet1, fig=true)
sleep(3)
# The thermodynamic state after the first heating is
Tdry2 = 323;
W2 = W1;
(
    Tdry2, Twet2, Tdew2, Tadiab2,
    W2, Wsat2, Wsatwet2, Wadiab2,
    φ2,
    h2, v2,
    pw2, psat2, psatwet2,
    ρ2
    ) = psychro(Tdry=Tdry2, W=W2, fig=true)
sleep(3)
# The thermodynamic state the after first adiabatic saturation is
h3 = h2;
Tdry3, W3 = adiabSat(h3, fig=true)
sleep(3)
# The thermodynamic state after the second heating is
Tdry4 = 323;
W4 = W3;
(
    Tdry4, Twet4, Tdew4, Tadiab4,
    W4, Wsat4, Wsatwet4, Wadiab4,
    φ4,
    h4, v4,
    pw4, psat4, psatwet4,
    ρ4
    ) = psychro(Tdry=Tdry4, W=W4, fig=true)
sleep(3)
# The thermodynamic state the after second adiabatic saturation is
h5 = h4;
Tdry5, W5 = adiabSat(h5, fig=true)
sleep(3)
# The energy demand is
(h5 - h1) * (V / v1)
# The water vapor demand is
(W5 - W1) * (V / v1)
```

### **humidity**

`humidity` computes
the humidity W (in kg/kg of dry air) 
of humid air given
the water vapor pressure pw (in Pa) and
the total pressure p (in Pa).

By default, total pressure is assumed
to be the atmospheric pressure
at sea level, p = 101325.

**Syntax:**

```julia
humidity( # humidity in kg/kg of dry air
    pw::Number, # water vapor pressure in Pa
    p::Number=101325 # total pressure in Pa
    )
```

**Examples:**

Compute the humidity of humid air
at atmospheric pressure given
water vapor pressure is 1 kPa
at 1 atm total pressure.

```julia
humidity( # humidity in kg/kg of dry air
    1e3 # water vapor pressure in Pa
    )
```

Compute the humidity of humid air
at atmospheric pressure given
water vapor pressure is 1 kPa
at 10 atm total pressure.

```julia
humidity( # humidity in kg/kg of dry air
    1e3, # water vapor pressure in Pa
    101325e1 # total pressure in Pa
    )
```

### **satPress**

`satPress` computes
the saturation pressure psat (in pa)
of humid air given the dry bulb temperature Tdry (in K).

**Syntax:**

```julia
satPress( # saturation pressure in Pa
    Tdry::Number # dry bulb temperature in K
    )
```

**Examples:**

Compute the saturation pressure given
the dry bulb temperature is 25 °C.

```julia
satPress( # saturation pressure in Pa
    25 + 273.15; # dry bulb temperature in K
    )
```

### **enthalpy**

`enthalpy` computes
the specific enthalpy h (in J/kg of dry air)
of humid air given
the dry bulb temperature Tdry (in K) and
the humidity W (in kg/kg of dry air).

**Syntax:**

```julia
enthalpy( # specific enthalpy in kJ/kg of dry air
    Tdry::Number, # dry bulb temperature in K
    W::Number # humidity in kg/kg of dry air
    )
```

**Examples:**

Compute the specific enthalpy given
the dry bulb temperature is 25 °C and
the humidity is 7 g/kg of dry air.

```julia
enthalpy( # specific enthalpy in J/kg of dry air
    25 + 273.15, # dry bulb temperature in K
    7e-3 # humidity in kg/kg of dry air
    )
```

### **volume**

`volume` computes
the specific volume v (in cu. m/kg of dry air)
of humid air given
the dry bulb temperature Tdry (in K),
the humidity W (in kg/kg of dry air) and
the total pressure p (in Pa).

By default, total pressure is assumed
to be the atmospheric pressure
at sea level, p = 101325.

**Syntax:**

```julia
volume( # specific enthalpy in J/kg of dry air
    Tdry::Number, # dry bulb temperature in K
    W::Number, # humidity in kg/kg of dry air
    p::Number=101325 # total pressure in Pa
    )
```

**Examples:**

Compute the specific volume given
the dry bulb temperature is 25 °C and
the humidity is 7 g/kg of dry air
at 1 atm total pressure.

```julia
volume( # specific volume in cu. m/kg of dry air
    25 + 273.15, # dry bulb temperature in K 
    7e-3 # humidity in kg/kg of dry air
    )
```

### **adiabSat**

`adiabSat` computes
the adiabatic saturation temperature Tadiab (in K) and
the adiabatic saturation humidity Wadiab (in Kg/kg of dry air) given
the specific enthalpy h (in J/kg of dry air).

If fig = true is given, a schematic psychrometric chart
is plotted as a graphical representation
of the solution.

**Syntax:**

```julia
adiabSat( # adiabatic saturation temperature in K
    h::Number; # specific enthalpy in J/kg of dry air
    fig::Bool=false # show plot
    )
```

**Examples:**

Compute the adiabatic saturation temperature given
the specific enthalpy is 82.4 kJ/kg of dry air and
plot a graphical representation of the
answer in a schematic psychrometric chart.

```julia
adiabSat(
    82.4e3, # specific enthalpy in J/kg of dry air
    fig=true # show plot
    )
```

### **dewTemp**

`dewTemp` computes
the dew point temperature Tdew (in K)
of humid air given
the water vapor pressure pw (in Pa).

**Syntax:**

```julia
dewTemp( # dew point temperature in K
    pw::Number # water vapor pressure in Pa
    )
```

**Examples:**

Compute the dew temperature
of humid air given
the water vapor pressure is 1 kPa.

```julia
dewTemp( # dew temperature in K
    1e3 # water vapor pressure in Pa
    )
```

### **doPlot**

`doPlot` plots
a schematic psychrometric chart.

**Syntax:**

```julia
doPlot(;
    back::Symbol=:white # plot background color
    )
```

**Examples:**

Build a schematic psychrometric chart and
save figure as psychrometricChart_transparent.svg.

```julia
doPlot(
    back=:transparent # plot background transparent
    )
using Plots
savefig("psychrometricChart_transparent.svg")
```

### Reference

The theory and the adjusted equations used in this package
were taken from the first chapter of the
*2017 ASHRAE Handbook Fundamentals Systems - International Metric System*,
published by the
American Society of Heating, Refrigerating and Air-Conditioning Engineers.

### Acknowledgements

The author of Psychrometrics package acknowledges
Professor Brent Stephens, Ph.D. from the Illinois Institute of Technology
for kindly suggesting the source reference for equations used in this package.

### See Also

[McCabeThiele.jl](https://github.com/aumpierre-unb/McCabeThiele.jl),
[PonchonSavarit.jl](https://github.com/aumpierre-unb/PonchonSavarit.jl),
[InternalFluidFlow.jl](https://github.com/aumpierre-unb/InternalFluidFlow.jl).

Copyright &copy; 2022 2023 2024 Alexandre Umpierre

email: <aumpierre@gmail.com>
