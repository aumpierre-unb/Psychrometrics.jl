@doc raw"""
`buildEnthalpy(h)`

`buildEnthalpy` generates a two column matrix of
humidity and dry bulb temperature
with given constant specific enthalpy (in J/kg).
# By default, constant specific enthalpy curves
are ploted with red dash-doted thin lines

`buildEnthalpy` is an internal function of
the psychrometrics toolbox for Julia.
"""
function buildEnthalpy(h)
    foo(T1)=h-enthalpy(T1,humidity(satPress(T1),:))
    tol=h/1e3
    T1=newtonraphson(foo,50+273.15,tol)
    if humidity(satPress(T1),:)>.03
        foo(T1)=h-enthalpy(T1,.03)
        tol=abs(foo(50+273.15)/1e3)
        T1=newtonraphson(foo,50+273.15,tol)
    end
    foo(T2)=h-enthalpy(T2,0)
    T2=newtonraphson(foo,T1,tol)
    if T2>60+273.15 T2=60+273.15 end
    N=5
    T=[]
    W=[]
    for n=1:N
        T=[T;T1+(T2-T1)/(N-1)*(n-1)]
        foo(W)=h-enthalpy(T(n),W)
        tol=abs(foo(1e-2)/1e3)
        W=[W;newtonraphson(foo,1e-2,tol)]
    end
    return T,W
end

