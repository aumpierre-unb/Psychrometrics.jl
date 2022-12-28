# PonchonSavarit.jl

[![DOI](https://zenodo.org/badge/543161141.svg)](https://doi.org/10.5281/zenodo.xxxxxxx)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![version](https://juliahub.com/docs/PonchonSavarit/version.svg)](https://juliahub.com/ui/Packages/PonchonSavarit/WauTj)

## Installing and Loading PonchonSavarit

PonchonSavarit can be installed and loaded either
from the JuliaHub repository (last released version) or from the
[maintainer's repository](https://github.com/aumpierre-unb/PonchonSavarit.jl).

### Last Released Version

The last version of PonchonSavarit can be installed from JuliaHub repository:

```julia
using Pkg
Pkg.add("PonchonSavarit")
using PonchonSavarit
```

If PonchonSavarit is already installed, it can be updated:

```julia
using Pkg
Pkg.update("PonchonSavarit")
using PonchonSavarit
```

### Pre-Release (Under Construction) Version

The pre-release (under construction) version of PonchonSavarit
can be installed from the [maintainer's repository](https://github.com/aumpierre-unb/PonchonSavarit.jl).

```julia
using Pkg
Pkg.add(path="https://github.com/aumpierre-unb/PonchonSavarit.jl")
using PonchonSavarit
```

<!--
## Citation of PonchonSavarit

You can cite all versions (both released and pre-released), by using
[10.5281/zenodo.xxxxxxxxxx](https://doi.org/10.5281/zenodo.xxxxxxxxxx).

This DOI represents all versions, and will always resolve to the latest one.

For citation of the last released version of PonchonSavarit, please check CITATION file at the [maintainer's repository](https://github.com/aumpierre-unb/PonchonSavarit.jl).
-->

## The PonchonSavarit Module for Julia

PonchonSavarit provides the following functions:

- stages
- refmin
- qR2S

### stages

stages omputes the number of theoretical stages
of a distillation column using the Ponchon-Savarit method given
a x-h-y-H matrix of the liquid and the vapor fractions
at equilibrium and their enthalpies,
the vector of the fractions of the products and the feed,
the feed quality, and the reflux ratio at the top of the column.
If feed is a saturated liquid, feed quality q = 1,
feed quality is reset to q = 1 - 1e-10.
By default, stages plots a schematic diagram of the solution, fig = true.
If fig = false is given, no plot is shown.

If feed is a saturated liquid, feed quality q = 1,
feed quality is reset to q = 1 - 1e-10.

By default, stages plots a schematic diagram of the solution, fig = true.

If fig = false is given, no plot is shown.

**Syntax:**

```dotnetcli
N=stages(y,X,q,R[,updown[,fig]])
```

**Examples:**

Compute the number of theoretical stages
of a distillation column for oxygen and nitrogen
from the bottom to the top of the column given
a matrix that relates the liquid and the vapor fractions
and their enthalpies at equilibrium,
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the composition of the column's bottom product is 11 %,
the feed quality is 54 %, and
the reflux ratio at the top of the column is
70 % higher that the minimum reflux ratio:

```julia
data=[0.    0.420 0.    1.840; # enthalpy in kcal/mmol
      0.075 0.418 0.193 1.755;
      0.17  0.415 0.359 1.685;
      0.275 0.410 0.50  1.625;
      0.39  0.398 0.63  1.570;
      0.525 0.378 0.75  1.515;
      0.685 0.349 0.86  1.465;
      0.88  0.300 0.955 1.425;
      0.1   0.263 1.    1.405];
x=[0.88 0.46 0.11];
q=0.54;
r=refmin(data,x,q);
R=1.70*r;
N=stages(data,x,q,R,false,false)
```

Compute the number of theoretical stages
of a distillation column for acetone and methanol
from the bottom to the top of the column given
a matrix that relates the liquid and the vapor fractions
and their enthalpies at equilibrium,
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the composition of the column's bottom product is 11 %,
the feed is a saturated liquid, and
the reflux ratio at the top of the column is
70 % higher that the minimum reflux ratio:

```julia
data=[2.5e-4 3.235 1.675e-3 20.720; # enthalpy in kcal/mol
      0.05   2.666 0.267    20.520;
      0.1    2.527 0.418    20.340;
      0.15   2.459 0.517    20.160;
      0.2    2.422 0.579    20.000;
      0.3    2.384 0.665    19.640;
      0.4    2.358 0.729    19.310;
      0.5    2.338 0.779    18.970;
      0.6    2.320 0.825    18.650;
      0.7    2.302 0.87     18.310;
      0.8    2.284 0.915    17.980;
      0.9    2.266 0.958    17.680;
      1.     2.250 1.       17.390];
x=[0.88 0.46 0.11];
q=1;
r=refmin(data,x,q);
R=1.70*r;
N=stages(data,x,q,R,false,false)
```

### refmin

refmin computes the minimum value of the reflux ratio
of a distillation column using the Ponchón-Savarit method given
a x-h-y-H matrix of the liquid and the vapor fractions
at equilibrium and their enthalpies,
the vector of the fractions of the products and the feed, and
the feed quality.

If feed is a saturated liquid, feed quality q = 1,
feed quality is reset to q = 1 - 1e-10.

**Syntax:**

```dotnetcli
r=refmin(y,X,q)
```

**Examples:**

Compute the minimum value of the reflux ratio
of a distillation column for oxygen and nitrogen given
a matrix that relates the liquid and the vapor fractions
and their enthalpies at equilibrium,
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the feed quality is 54 %:

```julia
data=[0.    0.420 0.    1.840; # enthalpy in kcal/mmol
      0.075 0.418 0.193 1.755;
      0.17  0.415 0.359 1.685;
      0.275 0.410 0.50  1.625;
      0.39  0.398 0.63  1.570;
      0.525 0.378 0.75  1.515;
      0.685 0.349 0.86  1.465;
      0.88  0.300 0.955 1.425;
      0.1   0.263 1.    1.405];
x=[0.88 0.46];
q=0.54;
r=refmin(data,x,q)
```

Compute the minimum value of the reflux ratio
of a distillation column for acetone and methanol given
a matrix that relates the liquid and the vapor fractions
and their enthalpies at equilibrium,
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the feed is a saturated liquid:

```julia
data=[2.5e-4 3.235 1.675e-3 20.720; # enthalpy in kcal/mol
      0.05   2.666 0.267    20.520;
      0.1    2.527 0.418    20.340;
      0.15   2.459 0.517    20.160;
      0.2    2.422 0.579    20.000;
      0.3    2.384 0.665    19.640;
      0.4    2.358 0.729    19.310;
      0.5    2.338 0.779    18.970;
      0.6    2.320 0.825    18.650;
      0.7    2.302 0.87     18.310;
      0.8    2.284 0.915    17.980;
      0.9    2.266 0.958    17.680;
      1.     2.250 1.       17.390];
x=[0.88 0.46 0.08];
q=1;
r=refmin(data,x,q)
```

### qR2S

qR2S computes the reflux ratio at the bottom
of a distillation column
using the Ponchon-Savarit method given
a x-h-y-H matrix of the liquid and the vapor fractions
at equilibrium and their enthalpies,
the vector of the fractions of the products and the feed,
the feed quality, and
the reflux ratio at the top of the column.

If feed is a saturated liquid, feed quality q = 1,
feed quality is reset to q = 1 - 1e-10.

**Syntax:**

```dotnetcli
S=qR2S(X,q,R)
```

**Examples:**

Compute the reflux ratio at the bottom
of a distillation column for oxygen and nitrogen given
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the composition of the column's bottom product is 11 %,
the feed quality is 54 %, and
the reflux ratio at the top of the column is 2.

```julia
data=[0.    0.420 0.    1.840; # enthalpy in kcal/mmol
      0.075 0.418 0.193 1.755;
      0.17  0.415 0.359 1.685;
      0.275 0.410 0.50  1.625;
      0.39  0.398 0.63  1.570;
      0.525 0.378 0.75  1.515;
      0.685 0.349 0.86  1.465;
      0.88  0.300 0.955 1.425;
      0.1   0.263 1.    1.405];
x=[0.88 0.46 0.11];
q=0.54;
R=2;
S=qR2S(x,q,R)
```

Compute the reflux ratio at the bottom
of a distillation column for acetone and methanol given
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the composition of the column's bottom product is 11 %,
the feed is saturated liquid, and
the reflux ratio at the top of the column is 2.

```julia
data=[2.5e-4 3.235 1.675e-3 20.720; # enthalpy in kcal/mol
      0.05   2.666 0.267    20.520;
      0.1    2.527 0.418    20.340;
      0.15   2.459 0.517    20.160;
      0.2    2.422 0.579    20.000;
      0.3    2.384 0.665    19.640;
      0.4    2.358 0.729    19.310;
      0.5    2.338 0.779    18.970;
      0.6    2.320 0.825    18.650;
      0.7    2.302 0.87     18.310;
      0.8    2.284 0.915    17.980;
      0.9    2.266 0.958    17.680;
      1.     2.250 1.       17.390];
x=[0.88 0.46 0.11];
q=1;
R=2;
S=qR2S(data,x,q,R)
```

### See Also

[McCabeThiele.jl](https://github.com/aumpierre-unb/McCabeThiele.jl),
[InternalFluidFlow.jl](https://github.com/aumpierre-unb/InternalFluidFlow.jl).

Copyright &copy; 2022 Alexandre Umpierre

email: <aumpierre@gmail.com>
