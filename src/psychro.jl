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
psychro( # all results ordered in one tuple
    Tdew=22 + 273.15, # dew temperature in K
    φ=0.29, # relative humidity
    fig=true # show plot
)
```

or, assigning values to variables:

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
    ) = psychro(
        Tdew=22 + 273.15, # dew temperature in K
        φ=0.29, # relative humidity
        fig=true # show plot
    )
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

```
# The volume of humid air is
V = 8.5;
# The initial condition is
Tdry1 = 293;
Twet1 = 288;
(
    Tdry1, Twet1, Tdew1, Tadiab1,
    W1, Wsat1, Wsatwet1, Wadiab1,
    h1, v1,
    φ1,
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
    h2, v2,
    φ2,
    pw2, psat2, psatwet2,
    ρ2
    ) = psychro(Tdry=Tdry2, W=W2, fig=true)
sleep(3)

# The thermodynamic state the after first adiabatic saturation is
h3 = h2;
Tdry3, W3 = adiabSat(h3, true)
sleep(3)

# The thermodynamic state after the second heating is
Tdry4 = 323;
W4 = W3;
(
    Tdry4, Twet4, Tdew4, Tadiab4,
    W4, Wsat4, Wsatwet4, Wadiab4,
    h4, v4,
    φ4,
    pw4, psat4, psatwet4,
    ρ4
    ) = psychro(Tdry=Tdry4, W=W4, fig=true)
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
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        Tdew = dewTemp(pw)
        φ = pw / psat
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 0, 1, 1, 1, 1]
        tol = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, tol)
        W = humidity(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 0, 1, 1, 1]
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        Tdew = dewTemp(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 1, 0, 1, 1]
        tol = h / 1e3
        W = newtonraphson(foo4, 1e-2, tol)
        v = volume(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        W = humidity(pw)
        φ = pw / psat
        Tdew = dewTemp(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 1, 1, 0, 1]
        tol = v / 1e3
        W = newtonraphson(foo6, 1e-2, tol)
        h = enthalpy(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        W = humidity(pw)
        φ = pw / psat
        Tdew = dewTemp(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
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
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdry, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 0, 0, 1, 1, 1, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        tol = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, tol)
        W = humidity(pw)
        tol = W / 1e3
        Tdry = newtonraphson(foo9, Twet, tol)
        psat = satPress(Tdry)
        φ = pw / psat
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 0, 1, 0, 1, 1, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        tol = W / 1e3
        pw = newtonraphson(foo1, psatwet, tol)
        Tdew = dewTemp(pw)
        tol = W / 1e3
        Tdry = newtonraphson(foo3, Twet, tol)
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
        tol = h / 1e3
        W = newtonraphson(foo4, Wsatwet, tol)
        while W < humidity2(Wsatwet, Tdry, Twet)
            Tdry = Tdry + 5e-3
            tol = h / 1e3
            W = newtonraphson(foo4, Wsatwet, tol)
        end
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        Tdew = dewTemp(pw)
        φ = pw / psat
    elseif a == [1, 0, 1, 1, 1, 0, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        tol = v / 1e3
        W = newtonraphson(foo6, Wsatwet, tol)
        while W > humidity2(Wsatwet, Tdry, Twet)
            Tdry = Tdry + 5e-3
            tol = v / 1e3
            W = newtonraphson(foo6, Wsatwet, tol)
        end
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        ρ = (1 + Wsatwet) / v
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        Tdew = dewTemp(pw)
        φ = pw / psat
    elseif a == [1, 0, 1, 1, 1, 1, 0]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        W = humidity2(Wsatwet, Tdry, Twet)
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        while pw / psat > φ
            Tdry = Tdry + 5e-3
            psat = satPress(Tdry)
            Wsat = humidity(psat)
            W = humidity2(Wsatwet, Tdry, Twet)
            tol = W / 1e3
            pw = newtonraphson(foo1, psat, tol)
        end
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
        φ = pw / psat
    elseif a == [1, 1, 0, 0, 1, 1, 1]
        tol = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, tol)
        w = humidity(pw)
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        tdew = dewTemp(pw)
        error(string(
            "Dew point temperature and humidity are not independent variables. For ", W,
            " kg/kg humidity, one has ", tdew,
            " K dew point temperature, and for ", Tdew,
            " K dew point temperature, one has ", w, " kg/kg humidity."))
    elseif a == [1, 1, 0, 1, 0, 1, 1]
        tol = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, tol)
        W = humidity(pw)
        tol = h / 1e3
        Tdry = newtonraphson(foo5, Tdew, tol)
        psat = satPress(Tdry)
        φ = pw / psat
        v = volume(Tdry, W)
        Wsat = humidity(psat)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 0, 1, 1, 0, 1]
        tol = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, tol)
        W = humidity(pw)
        tol = v / 1e3
        Tdry = newtonraphson(foo7, Tdew, tol)
        psat = satPress(Tdry)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        Wsat = humidity(psat)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdry, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 0, 1, 1, 1, 0]
        tol = Tdew / 1e3
        pw = newtonraphson(foo8, 1e3, tol)
        tol = φ / 1e3
        Tdry = newtonraphson(foo10, Tdew, tol)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        W = humidity(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 0, 1, 1]
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        Tdew = dewTemp(pw)
        tol = h / 1e3
        Tdry = newtonraphson(foo5, Tdew, tol)
        v = volume(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 1, 0, 1]
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        Tdew = dewTemp(pw)
        tol = v / 1e3
        Tdry = newtonraphson(foo7, Tdew, tol)
        h = enthalpy(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdry, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 1, 1, 0]
        tol = W / 1e3
        Tdry = newtonraphson(foo11, 50 + 273.15, tol)
        psat = satPress(Tdry)
        pw = φ * psat
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        Tdew = dewTemp(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 0, 0, 1]
        W = 1e-2
        dW = W
        tol = v / 1e3
        Tdry = newtonraphson(foo6, 50 + 273.15, tol)
        while abs(h - enthalpy(Tdry, W)) > h / 1e3
            if h > enthalpy(Tdry, W)
                W = W + dW
            else
                W = W - dW
                dW = dW / 2
            end
            Tdry = newtonraphson(foo7, 50 + 273.15, tol)
        end
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        Tdew = dewTemp(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdry, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 0, 1, 0]
        function foo(pw, h, φ)
            W = humidity(pw)
            tol = h / 1e3
            Tdry = newtonraphson(foo5, 50 + 273.15, tol)
            tol = satPress(Tdry) / 1e3
            psat = newtonraphson(foo12, pw, tol)
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
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 1, 0, 0]
        function bar(pw, v, φ)
            W = humidity(pw)
            tol = v / 1e3
            Tdry = newtonraphson(foo7, 50 + 273.15, tol)
            tol = satPress(Tdry) / 1e3
            psat = newtonraphson(foo12, pw, tol)
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
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
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

