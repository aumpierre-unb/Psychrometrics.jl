@doc raw"""
```
buildBasicData()
```

`buildBasicData` computes data for
a schematic psychrometric chart,
stored at `plotData.jl` file.

Edition of this file is
highly not advised.

`buildBasicData` is an internal function of
the `Psychrometrics` package for Julia.
"""
function buildBasicData()
    T, W = buildVolumeLine(0.78)
    uv = [T W]
    T, W = buildVolumeLine(0.80)
    uv = [uv T W]
    T, W = buildVolumeLine(0.82)
    uv = [uv T W]
    T, W = buildVolumeLine(0.84)
    uv = [uv T W]
    T, W = buildVolumeLine(0.86)
    uv = [uv T W]
    T, W = buildVolumeLine(0.88)
    uv = [uv T W]
    T, W = buildVolumeLine(0.90)
    uv = [uv T W]
    T, W = buildVolumeLine(0.92)
    uv = [uv T W]
    T, W = buildVolumeLine(0.94)
    uv = [uv T W]
    T, W = buildVolumeLine(0.96)
    uv = [uv T W]
    T, W = buildVolumeLine(0.98)
    uv = [uv T W]
    T, W = buildVolumeLine(1.00)
    uv = [uv T W]

    T, W = buildWetBulbTempLine(00 + 273.15)
    uT = [T W]
    T, W = buildWetBulbTempLine(05 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTempLine(10 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTempLine(15 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTempLine(20 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTempLine(25 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTempLine(30 + 273.15)
    uT = [uT T W]
    T, W = buildWetBulbTempLine(35 + 273.15)
    uT = [uT T W]

    T, W = buildEnthalpyLine(10e3)
    ue = [T W]
    T, W = buildEnthalpyLine(20e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(30e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(40e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(50e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(60e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(70e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(80e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(90e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(100e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(110e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(120e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(130e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(140e3)
    ue = [ue T W]
    T, W = buildEnthalpyLine(150e3)
    ue = [ue T W]

    T, W = buildHumidityLine(1.0)
    uh = [T W]
    T, W = buildHumidityLine(0.8)
    uh = [uh T W]
    T, W = buildHumidityLine(0.6)
    uh = [uh T W]
    T, W = buildHumidityLine(0.4)
    uh = [uh T W]

    T, W = buildHumidityLine(0.30)
    uH = [T W]
    T, W = buildHumidityLine(0.25)
    uH = [uH T W]
    T, W = buildHumidityLine(0.20)
    uH = [uH T W]
    T, W = buildHumidityLine(0.15)
    uH = [uH T W]
    T, W = buildHumidityLine(0.10)
    uH = [uH T W]
    T, W = buildHumidityLine(0.05)
    uH = [uH T W]

    uv, uT, ue, uh, uH
end
