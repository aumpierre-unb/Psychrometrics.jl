include("satPress.jl")
include("dewTemp.jl")
include("enthalpy.jl")
include("volume.jl")
include("newtonraphson.jl")
include("humidity.jl")
include("humidity2.jl")
include("adiabSat.jl")
include("doPlot.jl")
include("buildEnthalpy.jl")
include("buildHumidity.jl")
include("buildVolume.jl")
include("buildWetBulbTemp.jl")

using Plots

@doc raw"""
`Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho=psychro([;Tdry][,Twet][,Tdew][,W][,h][,v][,phi][,fig=false])`

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
the the relative humidity phi,
the water vapor pressure pw (in Pa),
the water saturation pressure psat (in Pa),
the saturation pressure at the wet bulb temperature psatwet (in Pa) and
the density rho (in kg/cu. m) given
any two input arguments,
except the combination of water vapor pressure pw and
dew point temperature Tdew, which are not independent.

If fig = true is given, a schematic psychrometric chart
is plotted as a graphical representation
of the solution.

`psychro` is a main function of
the `Psychrometrics` toolbox for Julia.

See also: `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat`.

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
# This call computes the answer and
# omits the psychrometric chart:
Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho=
psychro(Tdew=22+273.15,phi=.29)
```

```
# This call computes the answer and
# plots a schematic psychrometric chart:
Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho=
psychro(Tdew=22+273.15,phi=.29,fig=true)
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
Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho=
psychro(h=79.5e3,phi=.29,fig=true)
```

8.5 cubic meters of humid air at
dry bulb temperature of 293 K and
wet bulb temperature of 288 K
is subjected to two cycles of
heating to 323 and adiabatic saturation.
Compute the energy and water vapor demands.
Assume the amount of dry air is constant.

```
# The initial condition is
Tdry1=293;
Twet1=288;
Tdry1,Twet1,Tdew1,Tadiab1,W1,Wsat1,Wsatwet1,Wadiab1,h1,v1,phi1,pw1,psat1,psatwet1,rho1=
psychro(Tdry=Tdry1,Twet=Twet1,fig=true)
sleep(3)

# The thermodynamic state after the first heating is
Tdry2=323;
W2=W1;
Tdry2,Twet2,Tdew2,Tadiab2,W2,Wsat2,Wsatwet2,Wadiab2,h2,v2,phi2,pw2,psat2,psatwet2,rho2=
psychro(Tdry=Tdry2,W=W2,fig=true)
sleep(3)

# The thermodynamic state the after first adiabatic saturation is
h3=h2;
Tdry3,W3=adiabSat(h3)
Tdry3,Twet3,Tdew3,Tadiab3,W3,Wsat3,Wsatwet3,Wadiab3,h3,v3,phi3,pw3,psat3,psatwet3,rho3=
psychro(Tdry=Tdry3,W=W3,fig=true)
sleep(3)

# The thermodynamic state after the second heating is
Tdry4=323;
W4=W3;
Tdry4,Twet4,Tdew4,Tadiab4,W4,Wsat4,Wsatwet4,Wadiab4,h4,v4,phi4,pw4,psat4,psatwet4,rho4=
psychro(Tdry=Tdry4,W=W4,fig=true)
sleep(3)

# The thermodynamic state the after second adiabatic saturation is
h5=h4;
Tdry5,W5=adiabSat(h5)
Tdry5,Twet5,Tdew5,Tadiab5,W5,Wsat5,Wsatwet5,Wadiab5,h5,v5,phi5,pw5,psat5,psatwet5,rho5=
psychro(Tdry=Tdry5,W=W5,fig=true)
sleep(3)

# The energy demand is
(h5-h1)*(8.5/v1)

# The water vapor demand is
(W5-W1)*(8.5/v1)
```
"""
function psychro(; Tdry::Number=-1, Twet::Number=-1, Tdew::Number=-1, W::Number=-1, h::Number=-1, v::Number=-1, phi::Number=-1, fig::Bool=false)
    foo1(pw) = W - humidity(pw)
    foo2(Twet) = W - humidity2(humidity(satPress(Twet)), Tdry, Twet)
    foo21(Tdry) = W - humidity2(humidity(satPress(Twet)), Tdry, Twet)
    foo3(W) = h - enthalpy(Tdry, W)
    foo31(Tdry) = h - enthalpy(Tdry, W)
    foo4(W) = v - volume(Tdry, W)
    foo41(Tdry) = v - volume(Tdry, W)
    foo5(pw) = Tdew - dewTemp(pw)
    foo6(Tdry) = W - humidity2(Wsatwet, Tdry, Twet)
    foo7(Tdry) = phi - pw / satPress(Tdry)
    foo8(Tdry) = W - humidity(phi * satPress(Tdry))
    foo9(psat) = psat - satPress(Tdry)
    a = [Tdry, Twet, Tdew, W, h, v, phi] .== -1
    if sum(a) != 5
        error("Function psychro demands two and only two inputs.")
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
        phi = pw / psat
        rho = (1 + Wsatwet) / v
    elseif a == [0, 1, 0, 1, 1, 1, 1]
        tol = Tdew / 1e3
        pw = newtonraphson(foo5, 1e3, tol)
        W = humidity(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        phi = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 0, 1, 1, 1]
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        Tdew = dewTemp(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        phi = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 1, 0, 1, 1]
        tol = h / 1e3
        W = newtonraphson(foo3, 1e-2, tol)
        v = volume(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        W = humidity(pw)
        phi = pw / psat
        Tdew = dewTemp(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 1, 1, 0, 1]
        tol = v / 1e3
        W = newtonraphson(foo4, 1e-2, tol)
        h = enthalpy(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        W = humidity(pw)
        phi = pw / psat
        Tdew = dewTemp(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [0, 1, 1, 1, 1, 1, 0]
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        pw = phi * psat
        phi = pw / psat
        Tdew = dewTemp(pw)
        W = humidity(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdry, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 0, 0, 1, 1, 1, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        tol = Tdew / 1e3
        pw = newtonraphson(foo5, 1e3, tol)
        W = humidity(pw)
        tol = W / 1e3
        Tdry = newtonraphson(foo6, Twet, tol)
        psat = satPress(Tdry)
        phi = pw / psat
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 0, 1, 0, 1, 1, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        tol = W / 1e3
        pw = newtonraphson(foo1, psatwet, tol)
        Tdew = dewTemp(pw)
        tol = W / 1e3
        Tdry = newtonraphson(foo21, Twet, tol)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        phi = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 0, 1, 1, 0, 1, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        tol = h / 1e3
        W = newtonraphson(foo3, Wsatwet, tol)
        while W < humidity2(Wsatwet, Tdry, Twet)
            Tdry = Tdry + 5e-3
            tol = h / 1e3
            W = newtonraphson(foo3, Wsatwet, tol)
        end
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        v = volume(Tdry, W)
        rho = (1 + Wsatwet) / v
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        Tdew = dewTemp(pw)
        phi = pw / psat
    elseif a == [1, 0, 1, 1, 1, 0, 1]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        tol = v / 1e3
        W = newtonraphson(foo4, Wsatwet, tol)
        while W > humidity2(Wsatwet, Tdry, Twet)
            Tdry = Tdry + 5e-3
            tol = v / 1e3
            W = newtonraphson(foo4, Wsatwet, tol)
        end
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        rho = (1 + Wsatwet) / v
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        Tdew = dewTemp(pw)
        phi = pw / psat
    elseif a == [1, 0, 1, 1, 1, 1, 0]
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        W = humidity2(Wsatwet, Tdry, Twet)
        tol = W / 1e3
        pw = newtonraphson(foo1, psat, tol)
        while pw / psat > phi
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
        rho = (1 + Wsatwet) / v
        phi = pw / psat
    elseif a == [1, 1, 0, 0, 1, 1, 1]
        tol = Tdew / 1e3
        pw = newtonraphson(foo5, 1e3, tol)
        w = humidity(pw)
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        tdew = dewTemp(pw)
        error(string("Dew point temperature and humidity are not independent variables. For ", W, " kg/kg humidity, one has ", tdew, " K dew point temperature, and for ", Tdew, " K dew point temperature, one has ", w, " kg/kg humidity."))
    elseif a == [1, 1, 0, 1, 0, 1, 1]
        tol = Tdew / 1e3
        pw = newtonraphson(foo5, 1e3, tol)
        W = humidity(pw)
        tol = h / 1e3
        Tdry = newtonraphson(foo31, Tdew, tol)
        psat = satPress(Tdry)
        phi = pw / psat
        v = volume(Tdry, W)
        Wsat = humidity(psat)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 1, 0, 1, 1, 0, 1]
        tol = Tdew / 1e3
        pw = newtonraphson(foo5, 1e3, tol)
        W = humidity(pw)
        tol = v / 1e3
        Tdry = newtonraphson(foo41, Tdew, tol)
        psat = satPress(Tdry)
        phi = pw / psat
        h = enthalpy(Tdry, W)
        Wsat = humidity(psat)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdry, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 1, 0, 1, 1, 1, 0]
        tol = Tdew / 1e3
        pw = newtonraphson(foo5, 1e3, tol)
        tol = abs(phi / 1e3)
        Tdry = newtonraphson(foo7, Tdew, tol)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        W = humidity(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 0, 1, 1]
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        Tdew = dewTemp(pw)
        tol = h / 1e3
        Tdry = newtonraphson(foo31, Tdew, tol)
        v = volume(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        phi = pw / psat
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 1, 0, 1]
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        Tdew = dewTemp(pw)
        tol = v / 1e3
        Tdry = newtonraphson(foo41, Tdew, tol)
        h = enthalpy(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        phi = pw / psat
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdry, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 0, 1, 1, 0]
        tol = W / 1e3
        Tdry = newtonraphson(foo8, 50 + 273.15, tol)
        psat = satPress(Tdry)
        pw = phi * psat
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        Tdew = dewTemp(pw)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 0, 0, 1]
        W = 1e-2
        dW = W
        tol = v / 1e3
        Tdry = newtonraphson(foo4, 50 + 273.15, tol)
        while abs(h - enthalpy(Tdry, W)) > h / 1e3
            if h > enthalpy(Tdry, W)
                W = W + dW
            else
                W = W - dW
                dW = dW / 2
            end
            Tdry = newtonraphson(foo41, 50 + 273.15, tol)
        end
        tol = W / 1e3
        pw = newtonraphson(foo1, 1e3, tol)
        Tdew = dewTemp(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        phi = pw / psat
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdry, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 0, 1, 0]
        function foobar(pw, h, phi)
            W = humidity(pw)
            tol = h / 1e3
            Tdry = newtonraphson(foo31, 50 + 273.15, tol)
            tol = satPress(Tdry) / 1e3
            psat = newtonraphson(foo9, pw, tol)
            y = pw / psat - phi
            return y, Tdry, psat
        end
        pw = 0
        dp = 1e3
        y, Tdry, psat = foobar(pw, h, phi)
        while abs(y) > 1e-3
            if y < 0
                pw = pw + dp
            else
                pw = pw - dp
                dp = dp / 2
            end
            y, Tdry, psat = foobar(pw, h, phi)
        end
        W = humidity(pw)
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        v = volume(Tdry, W)
        rho = (1 + Wsatwet) / v
    elseif a == [1, 1, 1, 1, 1, 0, 0]
        function foobaz(pw, v, phi)
            W = humidity(pw)
            tol = v / 1e3
            Tdry = newtonraphson(foo41, 50 + 273.15, tol)
            tol = satPress(Tdry) / 1e3
            psat = newtonraphson(foo9, pw, tol)
            y = pw / psat - phi
            return y, Tdry, psat
        end
        pw = 0
        dp = 1e3
        y, Tdry, psat = foobaz(pw, v, phi)
        while abs(y) > 1e-3
            if y < 0
                pw = pw + dp
            else
                pw = pw - dp
                dp = dp / 2
            end
            y, Tdry, psat = foobaz(pw, v, phi)
        end
        W = humidity(pw)
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        tol = W / 1e3
        Twet = newtonraphson(foo2, Tdew, tol)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        rho = (1 + Wsatwet) / v
        h = enthalpy(Tdry, W)
    end
    Tadiab, Wadiab = adiabSat(h)
    if fig
        tv, wv = buildVolume(v)
        tb, wb = buildWetBulbTemp(Twet)
        te, we = buildEnthalpy(h)
        th, wh = buildHumidity(phi)
        doPlot()
        plot!(tv, wv,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:green)
        plot!(tb, wb,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:blue)
        plot!(te, we,
            seriestype=:line,
            linestyle=:dash,
            linewidth=:2,
            color=:red)
        plot!(th, wh,
            seriestype=:line,
            linewidth=:2,
            color=:black)
        plot!([Tdry], [W],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:green,
            color=:green)
        plot!([Twet], [Wsatwet],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:blue,
            color=:blue)
        plot!([Tadiab], [Wadiab],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:red,
            color=:red)
        plot!([Tdry], [Wsat],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:black,
            color=:black)
        plot!([Tdew], [W],
            seriestype=:scatter,
            markersize=:5,
            markerstrokecolor=:black,
            color=:black)
        plot!([Tdew, Tdew, 60 + 273.15], [0, W, W],
            seriestype=:line,
            linestyle=:dash,
            color=:black)
        plot!([Tdry, Tdry, 60 + 273.15], [0, Wsat, Wsat],
            seriestype=:line,
            linestyle=:dash,
            color=:black)
        plot!([Tadiab, Tadiab, 60 + 273.15], [0, Wadiab, Wadiab],
            seriestype=:line,
            linestyle=:dash,
            color=:red)
        display(plot!([Twet, Twet, 60 + 273.15], [0, Wsatwet, Wsatwet],
            seriestype=:line,
            linestyle=:dash,
            color=:blue))
    end
    return [Tdry; Twet; Tdew; Tadiab; W; Wsat; Wsatwet; Wadiab; h; v; phi; pw; psat; psatwet; rho]
end
