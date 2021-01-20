function a=ccycle(T2,T1,P1)

a=142.88;
b=.02114;
R=8.314;


v1=fsolve(@(v) R*T1/(v-b)-a/(T1^.5*v*(v+b))-P1,1);

P2=(1/760)*10^(8.14-1810.94/(T2-28.52));
disp(P2);
v2=R*T1/P2;

Entr1=integral(@(v) R./(v-b)-a./(2.*T1.^1.5.*v.*(v+b)),v1,v2);

Tt1=T1/1000;
Tt2=T2/1000;

Entr2=integral(@(T) (30.09+6.832.*T+6.793.*T.^2-2.534.*T.^3+0.0821.*T.^-2)./T,Tt1,Tt2);

a=Entr1+Entr2;