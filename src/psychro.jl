@doc raw"""

```
(
    Tdry, # dry bulb temperature
    Twet, # wet bulb temperature
    Tdew, # dew point temperature
    Tadiab, # adiabatic saturation temperature
    W, # humidity
    Wsat, # saturation humidity
    Wsatwet, # saturation humidity at wet bulb temperature
    Wadiab, # adiabatic saturation humidity
    φ, # relative humidity
    h, # specific enthalpy
    v, # specific volume
    pw, # water vapor pressure
    psat, # saturation pressure
    psatwet, # saturation pressure at wet bulb temperature
    ρ # density
    ) = psychro(;
        Tdry::Number=NaN, # dry bulb temperature
        Twet::Number=NaN,  # wet bulb temperature
        Tdew::Number=NaN, # dew bulb temperature
        W::Number=NaN, # absolute humidity
        φ::Number=NaN, # relative humidity
        h::Number=NaN, # specific enthalpy
        v::Number=NaN, # specific volume
        fig::Bool=false # show/ommit chart
        )
```

`psychro` computes
the dry bulb temperature Tdry (in K),
the wet bulb temperature Twet (in K),
the dew point temperature Tdew (in K),
the adiabatic saturation temperature Tadiab (in K),
the humidit W (in kg/kg of dry air),
the saturation humidity Wsat (in kg/kg of dry air),
the saturation humidity at the wet bulb temperature Wsatwet (in kg/kg of dry air),
the adiabatic saturation humidity Wadiab (in kg/kg of dry air),
the specific enthalpy h (in J/kg of dry air),
the specific volume v (in cu. m/kg of dry air),
the the relative humidity φ,
the water vapor pressure pw (in Pa),
the water saturation pressure psat (in Pa),
the saturation pressure at the wet bulb temperature psatwet (in Pa) and
the density ρ (in kg/cu. m) given
any two parameters,
except the combination of water vapor pressure pw and
dew point temperature Tdew, which are not independent.

If fig = true is given, a schematic psychrometric chart
is plotted as a graphical representation
of the solution.

`psychro` is a main function of
the `Psychrometrics` package for Julia.

See also: `dewTemp`, `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat` and `doPlot`.

Examples
==========
Compute the dry bulb temperature,
the wet bulb temperature,
the dew point temperature,
the adiabatic saturation temperature,
the humidity,
the saturation humidity,
the saturation humidity at wet bulb temperature,
the adiabatic saturation humidity,
the specific enthalpy,
the specific volume,
the relative humidity,
the water vapor pressure,
the saturation pressure,
the saturation pressure at wet bulb temperature and
the density given
the dew point temperature is 22 °C and
the relative humidity is 29 %.

```
julia> psychro( # all results ordered in one tuple
    Tdew=22 + 273.15, # dew temperature in K
    φ=0.29, # relative humidity
    fig=true # show plot
    )
(317.15279820081713, 300.8025826546708, 295.15, 300.630749639427, 0.016655314288630218, 0.061457273968514865, 0.023613488375643806, 0.023368577952998033, 0.29, 87284.91363240786, 0.922516435950326, 2642.6540709980095, 9111.99526553911, 3706.305087370888, 1.1095883482240327)
```

or, assigning values to variables:

```
julia> (
    Tdry, # dry bulb temperature
    Twet, # wet bulb temperature
    Tdew, # dew point temperature
    Tadiab, # adiabatic saturation temperature
    W, # humidity
    Wsat, # saturation humidity
    Wsatwet, # saturation humidity at wet bulb temperature
    Wadiab, # adiabatic saturation humidity
    φ, # relative humidity
    h, # specific enthalpy
    v, # specific volume
    pw, # water vapor pressure
    psat, # saturation pressure
    psatwet, # saturation pressure at wet bulb temperature
    ρ # density
    ) = psychro(
        Tdew=22 + 273.15, # dew temperature in K
        φ=0.29, # relative humidity
        fig=true # show plot
    )
(317.15279820081713, 300.8025826546708, 295.15, 300.630749639427, 0.016655314288630218, 0.061457273968514865, 0.023613488375643806, 0.023368577952998033, 0.29, 87284.91363240786, 0.922516435950326, 2642.6540709980095, 9111.99526553911, 3706.305087370888, 1.1095883482240327)
```

Compute the dry bulb temperature,
he wet bulb temperature,
the dew point temperature,
the adiabatic saturation temperature,
the humidity,
the saturation humidity,
the saturation humidity at wet bulb temperature,
the adiabatic saturation humidity,
the specific enthalpy,
the specific volume,
the relative humidity,
the water vapor pressure,
the saturation pressure,
the saturation pressure at wet bulb temperature and
the density given
the specific enthalpy is 79.5 kJ/kg and
the relative humidity is 29 # and
plot a graphical representation of the
answer in a schematic psychrometric chart.

```
julia> psychro(
    h=79.5e3, # specific enthalpy in kJ/kg of dry air
    φ=0.29, # relative humidity
    fig=true # show plot
    )
(314.6900899183988, 299.0647531581762, 293.0906074284516, 298.8996068362218, 0.014626377884402915, 0.05339873380700505, 0.02124089445906455, 0.021027116024617758, 0.29, 79500.0, 0.9124449266965944, 2328.125, 8011.663442102799, 3346.2077598495816, 1.1192356542069382)
```

8.5 cubic meters of humid air at
dry bulb temperature of 293 K and
wet bulb temperature of 288 K
is subjected to two cycles of
heating to 323 and adiabatic saturation.
Compute the energy and water vapor demands.
Assume the amount of dry air is constant.

```
julia> # The volume of humid air is

julia> V = 8.5;

julia> # The initial condition is

julia> Tdry1 = 293;

julia> Twet1 = 288;

julia> (Tdry1, Twet1, Tdew1, Tadiab1,
       W1, Wsat1, Wsatwet1, Wadiab1,
       φ1,
       h1, v1,
       pw1, psat1, psatwet1,
       ρ1) = psychro(Tdry=Tdry1, Twet=Twet1, fig=true)
(293, 288, 284.73340702292325, 287.95353928811767, 0.008471990193790406, 0.014555881964716163, 0.010543295541226867, 0.010511219217115368, 0.5876493911331336, 41470.34182461476, 0.8413412236714394, 1361.6779922241783, 2317.1605599701647, 1689.0421976910375, 1.2011099267565002)

julia> sleep(3)

julia> # The thermodynamic state after the first heating is

julia> Tdry2 = 323;

julia> W2 = W1;

julia> (Tdry2, Twet2, Tdew2, Tadiab2,
       W2, Wsat2, Wsatwet2, Wadiab2,
       φ2,
       h2, v2,
       pw2, psat2, psatwet2,
       ρ2) = psychro(Tdry=Tdry2, W=W2, fig=true)
(323, 297.4011154378235, 284.7479028128452, 297.12988496415, 0.008471990193790406, 0.08559799901829143, 0.01917477528758612, 0.018855776964890787, 0.11118949765710232, 72123.07887742827, 0.9274853762657848, 1362.9852468262975, 12258.21930619394, 3030.4541848567173, 1.0988580535802717)

julia> sleep(3)

julia> # The thermodynamic state the after first adiabatic saturation is

julia> h3 = h2;

julia> Tdry3, W3 = adiabSat(h3, fig=true)
(297.12988496415, 0.018855776964890787)

julia> sleep(3)

julia> # The thermodynamic state after the second heating is

julia> Tdry4 = 323;

julia> W4 = W3;

julia> (Tdry4, Twet4, Tdew4, Tadiab4,
       W4, Wsat4, Wsatwet4, Wadiab4,
       φ4,
       h4, v4,
       pw4, psat4, psatwet4,
       ρ4) = psychro(Tdry=Tdry4, W=W4, fig=true)
(323, 303.22460387674636, 297.1317471703389, 303.02025334356324, 0.018855776964890787, 0.08559799901829143, 0.02732441158889919, 0.026991850646677036, 0.2432276766240687, 99055.72468515352, 0.9427617101901388, 2981.538201393855, 12258.21930619394, 4264.248330242064, 1.0896967923969945)

julia> sleep(3)

julia> # The thermodynamic state the after second adiabatic saturation is

julia> h5 = h4;

julia> Tdry5, W5 = adiabSat(h5, fig=true)
(303.02025334356324, 0.026991850646677036)

julia> sleep(3)

julia> # The energy demand is

julia> (h5 - h1) * (V / v1)
581780.305710694

julia> # The water vapor demand is

julia> (W5 - W1) * (V / v1)
0.1871046008688284
```
"""
function psychro(;
    Tdry::Number=NaN,
    Twet::Number=NaN,
    Tdew::Number=NaN,
    W::Number=NaN,
    φ::Number=NaN,
    h::Number=NaN,
    v::Number=NaN,
    fig::Bool=false
)
    foo1(pw) = W - humidity(pw)
    foo2(Twet) = W - humidity2(
        humidity(satPress(Twet)), Tdry, Twet
    )
    foo3(Tdry) = W - humidity2(
        humidity(satPress(Twet)), Tdry, Twet
    )
    foo4(W) = h - enthalpy(Tdry, W)
    foo5(Tdry) = h - enthalpy(Tdry, W)
    foo6(W) = v - volume(Tdry, W)
    foo7(Tdry) = v - volume(Tdry, W)
    foo8(pw) = Tdew - dewTemp(pw)
    foo9(Tdry) = W - humidity2(Wsatwet, Tdry, Twet)
    foo10(Tdry) = φ - pw / satPress(Tdry)
    foo11(Tdry) = W - humidity(φ * satPress(Tdry))
    foo12(psat) = psat - satPress(Tdry)
    a = isnan.([Tdry, Twet, Tdew, W, h, v, φ]) .!= 0
    if sum(a) != 5
        error("psychro requires two and only two parameters.")
    end
    if a == [0, 0, 1, 1, 1, 1, 1]
        psat = satPress(Tdry)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Wsat = humidity(psat)
        W = humidity2(Wsatwet, Tdry, Twet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ξ = W / 1e3
        pw = newtonraphson(foo1, psat, ξ)
        Tdew = dewTemp(pw)
        φ = pw / psat
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 0, 1, 1, 1, 1]
        ξ = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, ξ)
        W = humidity(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 0, 1, 1, 1]
        ξ = W / 1e3
        pw = newtonraphson(foo1, 1e3, ξ)
        Tdew = dewTemp(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 1, 0, 1, 1]
        ξ = h / 1e3
        W = newtonraphson(foo4, 1e-2, ξ)
        v = volume(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        ξ = W / 1e3
        pw = newtonraphson(foo1, psat, ξ)
        W = humidity(pw)
        φ = pw / psat
        Tdew = dewTemp(pw)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 1, 1, 0, 1]
        ξ = v / 1e3
        W = newtonraphson(foo6, 1e-2, ξ)
        h = enthalpy(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        ξ = W / 1e3
        pw = newtonraphson(foo1, psat, ξ)
        W = humidity(pw)
        φ = pw / psat
        Tdew = dewTemp(pw)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 1, 1, 1, 0]
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        pw = φ * psat
        φ = pw / psat
        Tdew = dewTemp(pw)
        W = humidity(pw)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdry, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 0, 0, 1, 1, 1, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ξ = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, ξ)
        W = humidity(pw)
        ξ = W / 1e3
        Tdry = newtonraphson(foo9, Twet, ξ)
        psat = satPress(Tdry)
        φ = pw / psat
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 0, 1, 0, 1, 1, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ξ = W / 1e3
        pw = newtonraphson(foo1, psatwet, ξ)
        Tdew = dewTemp(pw)
        ξ = W / 1e3
        Tdry = newtonraphson(foo3, Twet, ξ)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 0, 1, 1, 0, 1, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        ξ = h / 1e3
        W = newtonraphson(foo4, Wsatwet, ξ)
        while W < humidity2(Wsatwet, Tdry, Twet)
            Tdry = Tdry + 5e-3
            ξ = h / 1e3
            W = newtonraphson(foo4, Wsatwet, ξ)
        end
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
        ξ = W / 1e3
        pw = newtonraphson(foo1, psat, ξ)
        Tdew = dewTemp(pw)
        φ = pw / psat
    elseif a == [1, 0, 1, 1, 1, 0, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        ξ = v / 1e3
        W = newtonraphson(foo6, Wsatwet, ξ)
        while W > humidity2(Wsatwet, Tdry, Twet)
            Tdry = Tdry + 5e-3
            ξ = v / 1e3
            W = newtonraphson(foo6, Wsatwet, ξ)
        end
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        ρ = (1 + Wsatwet) / v
        ξ = W / 1e3
        pw = newtonraphson(foo1, psat, ξ)
        Tdew = dewTemp(pw)
        φ = pw / psat
    elseif a == [1, 0, 1, 1, 1, 1, 0]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        W = humidity2(Wsatwet, Tdry, Twet)
        ξ = W / 1e3
        pw = newtonraphson(foo1, psat, ξ)
        while pw / psat > φ
            Tdry = Tdry + 5e-3
            psat = satPress(Tdry)
            Wsat = humidity(psat)
            W = humidity2(Wsatwet, Tdry, Twet)
            ξ = W / 1e3
            pw = newtonraphson(foo1, psat, ξ)
        end
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
        φ = pw / psat
    elseif a == [1, 1, 0, 0, 1, 1, 1]
        ξ = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, ξ)
        w = humidity(pw)
        ξ = W / 1e3
        pw = newtonraphson(foo1, 1e3, ξ)
        tdew = dewTemp(pw)
        error(string(
            "Dew point temperature and humidity are not independent variables. For ", W,
            " kg/kg humidity, one has ", tdew,
            " K dew point temperature, and for ", Tdew,
            " K dew point temperature, one has ", w, " kg/kg humidity."))
    elseif a == [1, 1, 0, 1, 0, 1, 1]
        ξ = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, ξ)
        W = humidity(pw)
        ξ = h / 1e3
        Tdry = newtonraphson(foo5, Tdew, ξ)
        psat = satPress(Tdry)
        φ = pw / psat
        v = volume(Tdry, W)
        Wsat = humidity(psat)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 0, 1, 1, 0, 1]
        ξ = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, ξ)
        W = humidity(pw)
        ξ = v / 1e3
        Tdry = newtonraphson(foo7, Tdew, ξ)
        psat = satPress(Tdry)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        Wsat = humidity(psat)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdry, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 0, 1, 1, 1, 0]
        ξ = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, ξ)
        ξ = φ / 1e3
        Tdry = newtonraphson(foo10, Tdew, ξ)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        W = humidity(pw)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 0, 1, 1]
        ξ = W / 1e3
        pw = newtonraphson(foo1, 1e3, ξ)
        Tdew = dewTemp(pw)
        ξ = h / 1e3
        Tdry = newtonraphson(foo5, Tdew, ξ)
        v = volume(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 1, 0, 1]
        ξ = W / 1e3
        pw = newtonraphson(foo1, 1e3, ξ)
        Tdew = dewTemp(pw)
        ξ = v / 1e3
        Tdry = newtonraphson(foo7, Tdew, ξ)
        h = enthalpy(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdry, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 1, 1, 0]
        ξ = W / 1e3
        Tdry = newtonraphson(foo11, 50 + 273.15, ξ)
        psat = satPress(Tdry)
        pw = φ * psat
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        Tdew = dewTemp(pw)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 0, 0, 1]
        W = 1e-2
        dW = W
        ξ = v / 1e3
        Tdry = newtonraphson(foo6, 50 + 273.15, ξ)
        while abs(h - enthalpy(Tdry, W)) > h / 1e3
            if h > enthalpy(Tdry, W)
                W = W + dW
            else
                W = W - dW
                dW = dW / 2
            end
            Tdry = newtonraphson(foo7, 50 + 273.15, ξ)
        end
        ξ = W / 1e3
        pw = newtonraphson(foo1, 1e3, ξ)
        Tdew = dewTemp(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdry, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 0, 1, 0]
        function foo(pw, h, φ)
            W = humidity(pw)
            ξ = h / 1e3
            Tdry = newtonraphson(foo5, 50 + 273.15, ξ)
            ξ = satPress(Tdry) / 1e3
            psat = newtonraphson(foo12, pw, ξ)
            y = pw / psat - φ
            y, Tdry, psat
        end
        pw = 0
        dp = 1e3
        y, Tdry, psat = foo(pw, h, φ)
        while abs(y) > 1e-3
            if y < 0
                pw = pw + dp
            else
                pw = pw - dp
                dp = dp / 2
            end
            y, Tdry, psat = foo(pw, h, φ)
        end
        W = humidity(pw)
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 1, 0, 0]
        function bar(pw, v, φ)
            W = humidity(pw)
            ξ = v / 1e3
            Tdry = newtonraphson(foo7, 50 + 273.15, ξ)
            ξ = satPress(Tdry) / 1e3
            psat = newtonraphson(foo12, pw, ξ)
            y = pw / psat - φ
            y, Tdry, psat
        end
        pw = 0
        dp = 1e3
        y, Tdry, psat = bar(pw, v, φ)
        while abs(y) > 1e-3
            if y < 0
                pw = pw + dp
            else
                pw = pw - dp
                dp = dp / 2
            end
            y, Tdry, psat = bar(pw, v, φ)
        end
        W = humidity(pw)
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        ξ = W / 1e3
        Twet = newtonraphson(foo2, Tdew, ξ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
        h = enthalpy(Tdry, W)
    end
    Tadiab, Wadiab = adiabSat(h)
    if fig
        tv, wv = buildVolume(v)
        tb, wb = buildWetBulbTemp(Twet)
        te, we = buildEnthalpy(h)
        th, wh = buildHumidity(φ)
        doPlot()
        plot!(
            tv, wv,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:green
        )
        plot!(
            tb, wb,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:blue
        )
        plot!(
            te, we,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:red
        )
        plot!(th, wh,
            seriestype=:line,
            linewidth=:2,
            color=:black)
        if φ != 1
            plot!(
                [Tdry], [W],
                seriestype=:scatter,
                markersize=:5,
                markerstrokecolor=:green,
                color=:green
            )
            plot!(
                [Twet], [Wsatwet],
                seriestype=:scatter,
                markersize=:5,
                markerstrokecolor=:blue,
                color=:blue
            )
            plot!(
                [Tdry], [Wsat],
                seriestype=:scatter,
                markersize=:5,
                markerstrokecolor=:black,
                color=:black
            )
            plot!(
                [Tdew], [W],
                seriestype=:scatter,
                markersize=:5,
                markerstrokecolor=:black,
                color=:black
            )
            plot!(
                [Tdew, Tdew, 60 + 273.15], [0, W, W],
                seriestype=:line,
                linestyle=:dash,
                color=:black
            )
            plot!(
                [Tdry, Tdry, 60 + 273.15], [0, Wsat, Wsat],
                seriestype=:line,
                linestyle=:dash,
                color=:black
            )
            plot!(
                [Twet, Twet, 60 + 273.15], [0, Wsatwet, Wsatwet],
                seriestype=:line,
                linestyle=:dash,
                color=:blue
            )
        end
        plot!(
            [Tadiab], [Wadiab],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:red,
            color=:red
        )
        plot!(
            [Tadiab, Tadiab, 60 + 273.15], [0, Wadiab, Wadiab],
            seriestype=:line,
            linestyle=:dash,
            color=:red
        )
        display(plot!())
    end
    Tdry, Twet, Tdew, Tadiab, W, Wsat, Wsatwet, Wadiab, φ, h, v, pw, psat, psatwet, ρ
end

