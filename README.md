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

Psychrometrics provides a set of functions to compute the various variables related to water vapor humid air, providing the following functions:

- **psychro**
- **humidity**
- **satPress**
- **enthalpy**
- **volume**
- **adiabSat**
- **dewTemp**

### **psychro**

psychro computes

- the dry bulb temperature,
- the wet bulb temperature,
- the dew point temperature,
- the adiabatic saturation temperature,
- the humidity,
- the saturation humidity,
- the saturation humidity at wet bulb temperature,
- the adiabatic saturation humidity,
- the specific enthalpy,
- the specific volume,
- the relative humidity,
- the water vapor pressure,
- the saturation pressure, the saturation
- pressure at wet bulb temperature and
- the density

given any two of the following parameters:

- the dry bulb temperature,
- the wet bulb temperature,
- the dew point temperature,
- the humidity,
- the specific enthalpy,
- the specific volume or
- the relative humidity,

except for the combination of humidity and dew point temperature, which are not mutually independent. If a different number of parameters is given, execution will be aborted. If fig = true is given, a schematic psychrometric chart is plotted as a graphical representation of the solution.

By default, stages plots a schematic diagram of the solution, fig = true.

If fig = false is given, no plot is shown.

**Syntax:**

```julia
psychro(; Tdry::Number=NaN, Twet::Number=NaN, Tdew::Number=NaN,
    W::Number=NaN, h::Number=NaN, v::Number=NaN, φ::Number=NaN,
    fig::Bool=false)
```

**Examples:**

Compute the dry bulb temperature, the wet bulb temperature, the adiabatic saturation temperature, the humidity, the saturation humidity, the saturation humidity at wet bulb temperature, the adiabatic saturation humidity, the specific enthalpy, the specific volume, the relative humidity, the water vapor pressure, the saturation pressure, the saturation pressure at wet bulb temperature and the density given the dew point temperature is 22 °C and the relative humidity is 29 %.

```julia
Tdry, Twet, Tdew, Tadiab, W, Wsat, Wsatwet, Wadiab, h, v, φ, pw, psat, psatwet, ρ =
    psychro(Tdew=22 + 273.15, φ=0.29, fig=true)
```

Compute the dry bulb temperature, the wet bulb temperature,
the dew point temperature, adiabatic saturation temperature, the dew point temperature the humidity, the saturation humidity, the saturation humidity at wet bulb temperature, the adiabatic saturation humidity, the specific enthalpy, the specific volume, the relative humidity, the water vapor pressure, the saturation pressure, the saturation pressure at wet bulb temperature and the density given the specific enthalpy is 79.5 kJ/kg of dry air and the relative humidity is 29 % and plot a graphical representation of the answer in a schematic psychrometric chart.

```julia
Tdry, Twet, Tdew, Tadiab, W, Wsat, Wsatwet, Wadiab, h, v, φ, pw, psat, psatwet, ρ =
    psychro(h=79.5e3, φ=0.29, fig=true)
```

8.5 cubic meters of humid air at dry bulb temperature of 293 K and wet bulb temperature of 288 K is subjected to two cycles of heating to 323 K followed by adiabatic saturation. Compute the energy and water vapor demands. Assume the amount of dry air is constant.

```julia
# The volume of humid air is
V = 8.5;
# The initial condition is
Tdry1 = 293;
Twet1 = 288;
Tdry1, Twet1, Tdew1, Tadiab1, W1, Wsat1, Wsatwet1, Wadiab1, h1, v1, phi1, pw1, psat1, psatwet1, rho1 =
    psychro(Tdry=Tdry1, Twet=Twet1, fig=true)
sleep(3)
# The thermodynamic state after the first heating is
Tdry2 = 323;
W2 = W1;
Tdry2, Twet2, Tdew2, Tadiab2, W2, Wsat2, Wsatwet2, Wadiab2, h2, v2, phi2, pw2, psat2, psatwet2, rho2 =
    psychro(Tdry=Tdry2, W=W2, fig=true)
sleep(3)
# The thermodynamic state the after first adiabatic saturation is
h3 = h2;
Tdry3, W3 = adiabSat(h3, true)
sleep(3)
# The thermodynamic state after the second heating is
Tdry4 = 323;
W4 = W3;
Tdry4, Twet4, Tdew4, Tadiab4, W4, Wsat4, Wsatwet4, Wadiab4, h4, v4, phi4, pw4, psat4, psatwet4, rho4 =
    psychro(Tdry=Tdry4, W=W4, fig=true)
sleep(3)
# The thermodynamic state the after second adiabatic saturation is
h5 = h4;
Tdry5, W5 = adiabSat(h5, true)
sleep(3)
# The energy demand is
(h5 - h1) * (V / v1)
# The water vapor demand is
(W5 - W1) * (V / v1)
```

### **humidity**

humidity computes
the humidity of humid air in given the water vapor pressure and the total pressure. By default, total pressure is assumed to be the atmospheric pressure at sea level.

**Syntax:**

```julia
humidity(pw::Number, p::Number=101325)
```

**Examples:**

Compute the humidity of humid air at atmospheric pressure given water vapor pressure is 1 kPa at 1 atm total pressure.

```julia
pw = 1e3; # water vapor pressure in Pa
W = humidity(pw) # saturation pressure in kg/kg of dry air
```

### **satPress**

satPress computes the saturation pressure of humid air given the dry bulb temperature.

**Syntax:**

```julia
satPress(Tdry::Number)
```

**Examples:**

Compute the saturation pressure given the dry bulb temperature is 25 °C.

```julia
Tdry = 25 + 273.15; # dry bulb temperature in K
psat = satPress(Tdry) # saturation pressure in Pa
```

### **enthalpy**

enthalpy computes the specific enthalpy of humid air given the dry bulb temperature and the humidity in.

**Syntax:**

```julia
enthalpy(Tdry::Number, W::Number)
```

**Examples:**

Compute the specific enthalpy given the dry bulb temperature is 25 °C and the humidity is 7 g/kg of dry air.

```julia
Tdry = 25 + 273.15; # dry bulb temperature in K
W = 7e-3; # humidity in kg/kg of dry air
h = enthalpy(Tdry, W) # specific enthalpy in J/kg of dry air
```

### **volume**

volume computes computes the specific volume of humid air given  the dry bulb temperature, the humidity in and the total pressure. By default, total pressure is assumed to be the atmospheric pressure at sea level.

**Syntax:**

```julia
volume(Tdry::Number, W::Number, p::Number=101325)
```

**Examples:**

Compute the specific volume given the dry bulb temperature is 25 °C and the humidity is 7 g/kg of dry air at 1 atm total pressure.

```julia
Tdry = 25 + 273.15; # dry bulb temperature in K
W = 7e-3; # humidity in kg/kg of dry air
v = volume(Tdry, W) # specific volume in cu. m/kg of dry air
```

### **adiabSat**

adiabSat computes the the adiabatic saturation temperature and the adiabatic saturation humidity given the specific enthalpy. If fig = true is given, a schematic psychrometric chart is plotted as a graphical representation of the solution.

**Syntax:**

```julia
adiabSat(h::Number, fig::Bool=false)
```

**Examples:**

Compute the the adiabatic saturation temperature and the adiabatic saturation humidity given the specific enthalpy is 82.4 kJ/kg of dry air and plot a graphical representation of the answer in a schematic psychrometric chart.

```julia
h = 82.4e3; # specific enthalpy in J/kg
Tadiab, Wadiab = adiabSat(h, true) # parameters and returns in SI units
```

### **dewTemp**

dewTemp computes the dew point temperature of humid air given the water vapor pressure.

**Syntax:**

```julia
dewTemp(pw::Number)
```

**Examples:**

Compute the dew temperature of humid air given the water vapor pressure is 1 kPa.

```julia
pw = 1e3; # water vapor pressure in Pa
Tdew = dewTemp(pw) # dew temperature in K
```

### Reference

The theory and the adjusted equations used in this package were taken from the first chapter of the *2017 ASHRAE Handbook Fundamentals Systems - International Metric System*, published by the American Society of Heating, Refrigerating and Air-Conditioning Engineers.

### Acknowledgements

The author of Psychrometrics package acknowledges Professor Brent Stephens, Ph.D. from the Illinois Institute of Technology for kindly suggesting the source reference for equations used in this package.

### See Also

[McCabeThiele.jl](https://github.com/aumpierre-unb/McCabeThiele.jl),
[PonchonSavarit.jl](https://github.com/aumpierre-unb/PonchonSavarit.jl),
[InternalFluidFlow.jl](https://github.com/aumpierre-unb/InternalFluidFlow.jl).

Copyright &copy; 2022 2023 Alexandre Umpierre

email: <aumpierre@gmail.com>
