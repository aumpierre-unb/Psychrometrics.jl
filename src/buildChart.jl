@doc raw"""
`buildChart()`

`buildChart` computes data for
a schematic psychrometric chart.

`buildChart` is an internal function of
the psychrometrics toolbox for Julia.
"""
function buildChart()
    uv=[];
    [T,W]=buildVolume(.78);uv=[uv T W];
    [T,W]=buildVolume(.80);uv=[uv T W];
    [T,W]=buildVolume(.82);uv=[uv T W];
    [T,W]=buildVolume(.84);uv=[uv T W];
    [T,W]=buildVolume(.86);uv=[uv T W];
    [T,W]=buildVolume(.88);uv=[uv T W];
    [T,W]=buildVolume(.90);uv=[uv T W];
    [T,W]=buildVolume(.92);uv=[uv T W];
    [T,W]=buildVolume(.94);uv=[uv T W];
    [T,W]=buildVolume(.96);uv=[uv T W];
    [T,W]=buildVolume(.98);uv=[uv T W];
    uT=[];
    [T,W]=buildWetBulbTemp(00+273.15);uT=[uT T W];
    [T,W]=buildWetBulbTemp(05+273.15);uT=[uT T W];
    [T,W]=buildWetBulbTemp(10+273.15);uT=[uT T W];
    [T,W]=buildWetBulbTemp(15+273.15);uT=[uT T W];
    [T,W]=buildWetBulbTemp(20+273.15);uT=[uT T W];
    [T,W]=buildWetBulbTemp(25+273.15);uT=[uT T W];
    [T,W]=buildWetBulbTemp(30+273.15);uT=[uT T W];
    [T,W]=buildWetBulbTemp(35+273.15);uT=[uT T W];
    ue=[];
    [T,W]=buildEnthalpy(10e3);ue=[ue T W];
    [T,W]=buildEnthalpy(20e3);ue=[ue T W];
    [T,W]=buildEnthalpy(30e3);ue=[ue T W];
    [T,W]=buildEnthalpy(40e3);ue=[ue T W];
    [T,W]=buildEnthalpy(50e3);ue=[ue T W];
    [T,W]=buildEnthalpy(60e3);ue=[ue T W];
    [T,W]=buildEnthalpy(70e3);ue=[ue T W];
    [T,W]=buildEnthalpy(80e3);ue=[ue T W];
    [T,W]=buildEnthalpy(90e3);ue=[ue T W];
    [T,W]=buildEnthalpy(10e4);ue=[ue T W];
    [T,W]=buildEnthalpy(11e4);ue=[ue T W];
    [T,W]=buildEnthalpy(12e4);ue=[ue T W];
    [T,W]=buildEnthalpy(13e4);ue=[ue T W];
    uh=[];
    [T,W]=buildHumidity(1.);uh=[uh T W];
    [T,W]=buildHumidity(.8);uh=[uh T W];
    [T,W]=buildHumidity(.6);uh=[uh T W];
    [T,W]=buildHumidity(.4);uh=[uh T W];
    uH=[];
    [T,W]=buildHumidity(.30);uH=[uH T W];
    [T,W]=buildHumidity(.25);uH=[uH T W];
    [T,W]=buildHumidity(.20);uH=[uH T W];
    [T,W]=buildHumidity(.15);uH=[uH T W];
    [T,W]=buildHumidity(.10);uH=[uH T W];
    [T,W]=buildHumidity(.05);uH=[uH T W];
    #save 'plotData.m' uv uT ue uh uH
end
