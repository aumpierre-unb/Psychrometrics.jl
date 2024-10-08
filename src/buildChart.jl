@doc raw"""
```
buildChart()
```

`buildChart` computes data for
a schematic psychrometric chart,
stored at `plotData.jl` file.

Edition of this file is
highly not advised.

`buildChart` is an internal function of
the `Psychrometrics` package for Julia.
"""
function buildChart()
    T, W = buildVolume(0.78)
    uv = [T W]
    T, W = buildVolume(0.80)
    uv = [uv T W]
    T, W = buildVolume(0.82)
    uv = [uv T W]
    T, W = buildVolume(0.84)
    uv = [uv T W]
    T, W = buildVolume(0.86)
    uv = [uv T W]
    T, W = buildVolume(0.88)
    uv = [uv T W]
    T, W = buildVolume(0.90)
    uv = [uv T W]
    T, W = buildVolume(0.92)
    uv = [uv T W]
    T, W = buildVolume(0.94)
    uv = [uv T W]
    T, W = buildVolume(0.96)
    uv = [uv T W]
    T, W = buildVolume(0.98)
    uv = [uv T W]
    T, W = buildVolume(1.00)
    uv = [uv T W]

    T, W = buildWetBulbTemp(00 + 273.15)
    uT = [T W]
    T, W = buildWetBulbTemp(05 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTemp(10 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTemp(15 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTemp(20 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTemp(25 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTemp(30 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTemp(35 + 273.15)
    uT = [uT T W]

    T, W = buildEnthalpy(10e3)
    ue = [T W]
    T, W = buildEnthalpy(20e3)
    ue = [ue T W]
    T, W = buildEnthalpy(30e3)
    ue = [ue T W]
    T, W = buildEnthalpy(40e3)
    ue = [ue T W]
    T, W = buildEnthalpy(50e3)
    ue = [ue T W]
    T, W = buildEnthalpy(60e3)
    ue = [ue T W]
    T, W = buildEnthalpy(70e3)
    ue = [ue T W]
    T, W = buildEnthalpy(80e3)
    ue = [ue T W]
    T, W = buildEnthalpy(90e3)
    ue = [ue T W]
    T, W = buildEnthalpy(100e3)
    ue = [ue T W]
    T, W = buildEnthalpy(110e3)
    ue = [ue T W]
    T, W = buildEnthalpy(120e3)
    ue = [ue T W]
    T, W = buildEnthalpy(130e3)
    ue = [ue T W]
    T, W = buildEnthalpy(140e3)
    ue = [ue T W]
    T, W = buildEnthalpy(150e3)
    ue = [ue T W]

    T, W = buildHumidity(1.0)
    uh = [T W]
    T, W = buildHumidity(0.8)
    uh = [uh T W]
    T, W = buildHumidity(0.6)
    uh = [uh T W]
    T, W = buildHumidity(0.4)
    uh = [uh T W]

    T, W = buildHumidity(0.30)
    uH = [T W]
    T, W = buildHumidity(0.25)
    uH = [uH T W]
    T, W = buildHumidity(0.20)
    uH = [uH T W]
    T, W = buildHumidity(0.15)
    uH = [uH T W]
    T, W = buildHumidity(0.10)
    uH = [uH T W]
    T, W = buildHumidity(0.05)
    uH = [uH T W]

    uv, uT, ue, uh, uH
end
