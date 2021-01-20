function a=adiabatic_total(T2,T1,P1,P2)

R=0.0832;
a=15.86;
b=0.02533;


v1=R.*T2./P1;
v2=fsolve(@(v) (R.*T2./(v-b)-a./(T2.^.5.*v.*(v+b)))-P2,1);

s1=integral(@(T) 8.314./T.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^2),T1,T2,'ArrayValued',true);
s2=100.*integral(@(v) (R./(v-b)+a./(2.*T2.^1.5.*v.*(v+b))),v1,v2,'ArrayValued',true);

a=s1+s2;