@doc raw"""
```
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
the relative humidity,
the specific enthalpy,
the specific volume,
the density,
the water vapor pressure,
the saturation pressure,
the saturation pressure at wet bulb temperature given
the dew point temperature is 22 °C and
the relative humidity is 29 %.

```
julia> humidAir = psychro( # all results ordered in one tuple
       Tdew=22 + 273.15, # dew temperature in K
       φ=0.29, # relative humidity
       fig=true # show plot
       )
(317.15279820081713, 300.8025826546708, 295.15, 300.630749639427, 0.016655314288630218, 0.061457273968514865, 0.023613488375643806, 0.023368577952998033, 0.29, 87284.91363240786, 0.922516435950326, 2642.6540709980095, 9111.99526553911, 3706.305087370888, 1.1095883482240327)

julia> humidAir.φ # relative humidity
0.29

julia> humidAir.Tdry # dry bulb temperature
317.15279820081713

julia> humidAir.Twet # wet bulb temperature
300.8025826546708
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
answer in a schematic psychrometric chart
with temperature in °C
with transparent background.

```
julia> psychro(
       h=79.5e3, # specific enthalpy in kJ/kg of dry air
       φ=0.29, # relative humidity
       fig=true, # show plot
       back=:transparent, # plot background transparent
       unit=:°C # temperature in °C
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
julia> state1 = psychro( # initial condition
       Tdry=293,
       Twet=288,
       fig=true
       )
Psychrometrics.HumidAir(293.0, 288.0, 284.73340702292325, 287.95353928811767, 0.008471990193790406, 0.014555881964716163, 0.010543295541226867, 0.010511219217115368, 0.5876493911331336, 41470.34182461476, 0.8413412236714394, 1.2011099267565002, 1361.6779922241783, 2317.1605599701647, 1689.0421976910375)

julia> sleep(3)

julia> state2 = psychro( # thermodynamic state after the first heating
       Tdry=323,
       W=state1.W,
       fig=true
       )
Psychrometrics.HumidAir(323.0, 297.4011154378235, 284.7479028128452, 297.12988496415, 0.008471990193790406, 0.08559799901829143, 0.01917477528758612, 0.018855776964890787, 0.11118949765710232, 72123.07887742827, 0.9274853762657848, 1.0988580535802717, 1362.9852468262975, 12258.21930619394, 3030.4541848567173)

julia> sleep(3)

julia> begin # thermodynamic state the after first adiabatic saturation
       local Tdry, W = adiabSat(
       state2.h,
       fig=true
       )
       state3 = psychro(
       Tdry=Tdry,
       W=W,
       fig=true
       )
       end
Psychrometrics.HumidAir(297.12988496415, 297.1317471703389, 297.1317471703389, 297.12988496415, 0.018855776964890787, 0.018855776964890787, 0.018857950636541637, 0.018855776964890787, 1.0000054408275143, 72123.07887742839, 0.8672528746049574, 1.1748106930180449, 2981.538201393855, 2981.521979447035, 2981.855570966872)

julia> sleep(3)

julia> state4 = psychro( # thermodynamic state after the second heating
       Tdry=323,
       W=state3.W,
       fig=true
       )
Psychrometrics.HumidAir(323.0, 303.22460387674636, 297.1317471703389, 303.02025334356324, 0.018855776964890787, 0.08559799901829143, 0.02732441158889919, 0.026991850646677036, 0.2432276766240687, 99055.72468515352, 0.9427617101901388, 1.0896967923969945, 2981.538201393855, 12258.21930619394, 4264.248330242064)

julia> sleep(3)

julia> begin # thermodynamic state the after second adiabatic saturation
       local Tdry, W = adiabSat(
       state4.h,
       fig=true
       )    
       state5 = psychro(
       Tdry=Tdry,
       W=W,
       fig=true
       )    
       end
Psychrometrics.HumidAir(303.02025334356324, 303.0202580354416, 303.00586796833204, 303.02025334380045, 0.026991850646677036, 0.026991850646677036, 0.02699185823948025, 0.02699185064706085, 1.0000275933540679, 99055.72468663573, 0.8956746499701631, 1.1466126213058407, 4214.623858195949, 4214.507565796464, 4214.508702025436)

julia> sleep(3)

julia> begin # energy demand
       local V = 8.5 # initial volume of humid air is
       (state5.h - state1.h) * (V / state1.v)
       end
581780.3057256688

julia> begin # water vapor demands
       local V = 8.5 # initial volume of humid air is
       (state5.W - state1.W) * (V / state1.v)
       end
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
    fig::Bool=false,
    back::Symbol=:white,
    unit::Symbol=:K
)
    k = unit == :°C ? 1 : 0

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
        printstyled(
            "psychro requires two and only two parameters.\n",
            color=:red
        )
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
        printstyled(string(
                "Dew point temperature and humidity are not independent variables. ", W,
                " kg/kg humidity corresponds to ", tdew,
                " K dew point temperature, and ", Tdew,
                " K dew point temperature corresponds to ", w, " kg/kg humidity.\n"
            ), color=:red)
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
        doPlot(
            back=back,
            unit=unit
        )
        plot!(
            tv .- k .* 273.15, wv,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:green
        )
        plot!(
            tb .- k .* 273.15, wb,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:blue
        )
        plot!(
            te .- k .* 273.15, we,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:red
        )
        plot!(th .- k .* 273.15, wh,
            seriestype=:line,
            linewidth=:2,
            color=:black)
        if φ != 1
            plot!(
                [Tdry] .- k .* 273.15, [W],
                seriestype=:scatter,
                markersize=:5,
                markerstrokecolor=:green,
                color=:green
            )
            plot!(
                [Twet] .- k .* 273.15, [Wsatwet],
                seriestype=:scatter,
                markersize=:5,
                markerstrokecolor=:blue,
                color=:blue
            )
            plot!(
                [Tdry] .- k .* 273.15, [Wsat],
                seriestype=:scatter,
                markersize=:5,
                markerstrokecolor=:black,
                color=:black
            )
            plot!(
                [Tdew] .- k .* 273.15, [W],
                seriestype=:scatter,
                markersize=:5,
                markerstrokecolor=:black,
                color=:black
            )
            plot!(
                [Tdew, Tdew, 60 + 273.15] .- k .* 273.15, [0, W, W],
                seriestype=:line,
                linestyle=:dash,
                color=:black
            )
            plot!(
                [Tdry, Tdry, 60 + 273.15] .- k .* 273.15, [0, Wsat, Wsat],
                seriestype=:line,
                linestyle=:dash,
                color=:black
            )
            plot!(
                [Twet, Twet, 60 + 273.15] .- k .* 273.15, [0, Wsatwet, Wsatwet],
                seriestype=:line,
                linestyle=:dash,
                color=:blue
            )
        end
        plot!(
            [Tadiab] .- k .* 273.15, [Wadiab],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:red,
            color=:red
        )
        plot!(
            [Tadiab, Tadiab, 60 + 273.15] .- k .* 273.15, [0, Wadiab, Wadiab],
            seriestype=:line,
            linestyle=:dash,
            color=:red
        )
        display(plot!())
    end

    HumidAir(
        Tdry - k * 273.15, Twet - k * 273.15, Tdew - k * 273.15, Tadiab - k * 273.15,
        W, Wsat, Wsatwet, Wadiab,
        φ,
        h, v, ρ,
        pw, psat, psatwet
    )
end
