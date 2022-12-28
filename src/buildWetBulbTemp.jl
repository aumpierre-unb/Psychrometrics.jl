@doc raw"""
`plotWetBulbTemp(Twet)`

`buildWetBulbTemp` generates two column matrix of
humidity and dry bulb temperature
with given constant wet bulb temperature (in K).

By default, constant specific volume curves
are ploted with with blue solid thin lines.

`buildWetBulbTemp` is an internal function of
the psychrometrics toolbox for Julia.
"""
function buildWetBulbTemp(Twet)
    T1=Twet
    if humidity(satPress(T1),:)>.03
        foo(T1)=.03-humidity2(humidity(satPress(Twet),:),T1,Twet)
        tol=abs(foo(50+273.15)/1e3)
        T1=newtonraphson(foo,50+273.15,tol)
    end
    foo(T2)=0-humidity2(humidity(satPress(Twet),:),T2,Twet)
    tol=abs(foo(50+273.15)/1e3)
    T2=newtonraphson(foo,50+273.15,tol)
    if T2>60+273.15 T2=60+273.15 end
    N=5
    T=[]
    W=[]
    for n=1:N
        T=[T;T1+(T2-T1)/(N-1)*(n-1)]
        foo(W)=W-humidity2(humidity(satPress(Twet),:),T(n),Twet)
        tol=abs(foo(1e-3)/1e3)
        W=[W;newtonraphson(foo,1e-2,tol)]
    end
    return T,W
end

