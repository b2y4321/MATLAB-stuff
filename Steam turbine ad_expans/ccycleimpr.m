function a=ccycleimpr(T2,T1,P1)

a=142.88;
b=.02114;
R=8.314;


v1=fsolve(@(v) R*T1/(v-b)-a/(T1^.5*v*(v+b))-P1,1);%initial volume 1
v2=R*T1;%P2 is 1 bar
Entr1=integral(@(v) R./(v-b)-a./(2.*T1.^1.5.*v.*(v+b)),v1,v2);

Tt1=T1/1000;
Tt2=T2/1000;

Entr2=integral(@(T) (30.09+6.832.*T+6.793.*T.^2-2.534.*T.^3+0.0821.*T.^-2)./T,Tt1,Tt2);

v25=R*T2;

P3=(1/760)*10^(8.14-1810.94/(T2-28.52));
v3=fsolve(@(v) R*T2/(v-b)-a/(T2^.5*v*(v+b))-P3,1);

Entr3=integral(@(v) R./(v-b)-a./(2.*T1.^1.5.*v.*(v+b)),v25,v3);


a=Entr1+Entr2+Entr3;