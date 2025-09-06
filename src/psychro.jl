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
    fig::Bool=false, # show/omit chart
    back::Symbol=:white, # plot background color
    unit::Symbol=:K # units for temperature (:K or :°C)
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

See also: `dewTemp`, `humidity`, `satPress`, `enthalpy`, `volume`, `adiabSat` and `buildBasicChart`.

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
the relative humidity is 0.29 # and
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

julia> begin
       using Plots
       buildBasicChart()
       local T = [state.Tdry for state in [state1, state2, state3, state4, state5]]
       local W = [state.W for state in [state1, state2, state3, state4, state5]]
       plot!(T, W, seriestype=:path, linewidth=2, color=:red)
       plot!(T, W, seriestype=:scatter, markersize=5, markerstrokecolor=:red, color=:red)
       end

julia> try # PrettyTables is not included in Psychrometrics!
       using PrettyTables
       local mytable = [name for name in fieldnames(Psychrometrics.HumidAir)]
       for i in (state1, state2, state3, state4, state5)
       mytable = [mytable [getfield(i, field) for field in 1:nfields(i)]]
       end
       local myheader = [
       "Parameter", "State 1", "State 2", "State 3", "State 4", "State 5"
       ]
       print(
       "\nSummary of process states:\n"
       )
       pretty_table(mytable, column_labels=myheader)
       catch
       end
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
    tempInKelvin = unit == :°C ? 1 : 0

    psychrParam = [Tdry, Twet, Tdew, W, h, v, φ]
    myVars = isnan.(psychrParam) .!= 0
    if sum(myVars) != length(psychrParam) - 2
        printstyled(
            "psychro requires two and only two parameters.\n",
            color=:red
        )
    end

    if !isnan(Tdry) && !isnan(Twet)
        psat = satPress(Tdry)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Wsat = humidity(psat)
        W = humiditySatWet(Wsatwet, Tdry, Twet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, psat, rtol=1e-8)
        Tdew = dewTemp(pw)
        φ = pw / psat
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Tdry) && !isnan(Tdew)
        foo = pw -> Tdew - dewTemp(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        W = humidity(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Tdry) && !isnan(W)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        Tdew = dewTemp(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Tdry) && !isnan(h)
        foo = W -> h - enthalpy(Tdry, W)
        W = find_zero(foo, 1e-2, rtol=1e-8)
        v = volume(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, psat, rtol=1e-8)
        W = humidity(pw)
        φ = pw / psat
        Tdew = dewTemp(pw)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Tdry) && !isnan(v)
        foo = W -> v - volume(Tdry, W)
        W = find_zero(foo, 1e-2, rtol=1e-8)
        h = enthalpy(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, psat, rtol=1e-8)
        W = humidity(pw)
        φ = pw / psat
        Tdew = dewTemp(pw)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Tdry) && !isnan(φ)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        pw = φ * psat
        φ = pw / psat
        Tdew = dewTemp(pw)
        W = humidity(pw)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdry, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Twet) && !isnan(Tdew)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        foo = pw -> Tdew - dewTemp(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        W = humidity(pw)
        foo = Tdry -> W - humiditySatWet(Wsatwet, Tdry, Twet)
        Tdry = find_zero(foo, Twet, rtol=1e-8)
        psat = satPress(Tdry)
        φ = pw / psat
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Twet) && !isnan(W)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, psatwet, rtol=1e-8)
        Tdew = dewTemp(pw)
        foo = Tdry -> W - humidity(Tdry, Twet)
        Tdry = find_zero(foo, Twet, rtol=1e-8)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Twet) && !isnan(h)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        foo = W -> h - enthalpy(Tdry, W)
        W = find_zero(foo, Wsatwet, rtol=1e-8)
        while W < humiditySatWet(Wsatwet, Tdry, Twet)
            Tdry = Tdry + 5e-3
            W = find_zero(foo, Wsatwet, rtol=1e-8)
        end
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, psat, rtol=1e-8)
        Tdew = dewTemp(pw)
        φ = pw / psat
    elseif !isnan(Twet) && !isnan(v)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        foo = W -> v - volume(Tdry, W)
        W = find_zero(foo, Wsatwet, rtol=1e-8)
        while W > humiditySatWet(Wsatwet, Tdry, Twet)
            Tdry = Tdry + 5e-3
            W = find_zero(foo, Wsatwet, rtol=1e-8)
        end
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        ρ = (1 + Wsatwet) / v
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, psat, rtol=1e-8)
        Tdew = dewTemp(pw)
        φ = pw / psat
    elseif !isnan(Twet) && !isnan(φ)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        Tdry = Twet
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        W = humiditySatWet(Wsatwet, Tdry, Twet)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, psat, rtol=1e-8)
        while pw / psat > φ
            Tdry = Tdry + 5e-3
            psat = satPress(Tdry)
            Wsat = humidity(psat)
            W = humiditySatWet(Wsatwet, Tdry, Twet)
            foo = pw -> W - humidity(pw)
            pw = find_zero(foo, psat, rtol=1e-8)
        end
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
        φ = pw / psat
    elseif !isnan(Tdew) && !isnan(W)
        foo = pw -> Tdew - dewTemp(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        w = humidity(pw)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        tdew = dewTemp(pw)
        printstyled(string(
                "Dew point temperature and humidity are not independent variables. ", W,
                " kg/kg humidity corresponds to ", tdew,
                " K dew point temperature, and ", Tdew,
                " K dew point temperature corresponds to ", w, " kg/kg humidity.\n"
            ), color=:red)
    elseif !isnan(Tdew) && !isnan(h)
        foo = pw -> Tdew - dewTemp(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        W = humidity(pw)
        foo = Tdry -> h - enthalpy(Tdry, W)
        Tdry = find_zero(foo, Tdew, rtol=1e-8)
        psat = satPress(Tdry)
        φ = pw / psat
        v = volume(Tdry, W)
        Wsat = humidity(psat)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Tdew) && !isnan(v)
        foo = pw -> Tdew - dewTemp(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        W = humidity(pw)
        foo = Tdry -> v - volume(Tdry, W)
        Tdry = find_zero(foo, Tdew, rtol=1e-8)
        psat = satPress(Tdry)
        φ = pw / psat
        h = enthalpy(Tdry, W)
        Wsat = humidity(psat)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdry, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(Tdew) && !isnan(φ)
        foo = pw -> Tdew - dewTemp(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        foo = Tdry -> φ - pw / satPress(Tdry)
        Tdry = find_zero(foo, Tdew, rtol=1e-8)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        W = humidity(pw)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(W) && !isnan(h)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        Tdew = dewTemp(pw)
        foo = Tdry -> h - enthalpy(Tdry, W)
        Tdry = find_zero(foo, Tdew, rtol=1e-8)
        v = volume(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(W) && !isnan(v)
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        Tdew = dewTemp(pw)
        foo = Tdry -> v - volume(Tdry, W)
        Tdry = find_zero(foo, Tdew, rtol=1e-8)
        h = enthalpy(Tdry, W)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdry, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(W) && !isnan(φ)
        foo = Tdry -> W - humidity(φ * satPress(Tdry))
        Tdry = find_zero(foo, 50 + 273.15, rtol=1e-8)
        psat = satPress(Tdry)
        pw = φ * psat
        Wsat = humidity(psat)
        h = enthalpy(Tdry, W)
        v = volume(Tdry, W)
        Tdew = dewTemp(pw)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(h) && !isnan(v)
        W = 1e-2
        dW = W
        foo = W -> v - volume(Tdry, W)
        Tdry = find_zero(foo, 50 + 273.15, rtol=1e-8)
        while abs(h - enthalpy(Tdry, W)) > h / 1e3
            if h > enthalpy(Tdry, W)
                W = W + dW
            else
                W = W - dW
                dW = dW / 2
            end
            foo = Tdry -> v - volume(Tdry, W)
            Tdry = find_zero(foo, 50 + 273.15, rtol=1e-8)
        end
        foo = pw -> W - humidity(pw)
        pw = find_zero(foo, 1e3, rtol=1e-8)
        Tdew = dewTemp(pw)
        psat = satPress(Tdry)
        Wsat = humidity(psat)
        φ = pw / psat
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdry, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(h) && !isnan(φ)
        bar = (pw, h, φ) -> begin
            W = humidity(pw)
            foo = Tdry -> h - enthalpy(Tdry, W)
            Tdry = find_zero(foo, 50 + 273.15, rtol=1e-8)
            foo = psat -> psat - satPress(Tdry)
            psat = find_zero(foo, pw, rtol=1e-8)
            y = pw / psat - φ
            y, Tdry, psat
        end
        pw = 0
        y, Tdry, psat = bar(pw, h, φ)
        dp = 1e3
        while abs(y) > 1e-3
            if y < 0
                pw += dp
            else
                pw -= dp
                dp /= 2
            end
            y, Tdry, psat = bar(pw, h, φ)
        end
        W = humidity(pw)
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        v = volume(Tdry, W)
        ρ = (1 + Wsatwet) / v
    elseif !isnan(v) && !isnan(φ)
        bar = (pw, v, φ) -> begin
            W = humidity(pw)
            foo = Tdry -> v - volume(Tdry, W)
            Tdry = find_zero(foo, 50 + 273.15, rtol=1e-8)
            foo = psat -> psat - satPress(Tdry)
            psat = find_zero(foo, pw, rtol=1e-8)
            y = pw / psat - φ
            y, Tdry, psat
        end
        pw = 0
        y, Tdry, psat = bar(pw, v, φ)
        dp = 1e3
        while abs(y) > 1e-3
            if y < 0
                pw += dp
            else
                pw -= dp
                dp /= 2
            end
            y, Tdry, psat = bar(pw, v, φ)
        end
        W = humidity(pw)
        Tdew = dewTemp(pw)
        Wsat = humidity(psat)
        foo = Twet -> W - humidity(Tdry, Twet)
        Twet = find_zero(foo, Tdew, rtol=1e-8)
        psatwet = satPress(Twet)
        Wsatwet = humidity(psatwet)
        ρ = (1 + Wsatwet) / v
        h = enthalpy(Tdry, W)
    end

    Tadiab, Wadiab = adiabSat(h)

    fig && doShowPlot(
        HumidAir(
            Tdry,
            Twet,
            Tdew,
            Tadiab,
            W,
            Wsat,
            Wsatwet,
            Wadiab,
            φ,
            h,
            v,
            ρ,
            pw,
            psat,
            psatwet
        ),
        back,
        unit
    )

    HumidAir(
        Tdry - tempInKelvin * 273.15,
        Twet - tempInKelvin * 273.15,
        Tdew - tempInKelvin * 273.15,
        Tadiab - tempInKelvin * 273.15,
        W,
        Wsat,
        Wsatwet,
        Wadiab,
        φ,
        h,
        v,
        ρ,
        pw,
        psat,
        psatwet
    )

end