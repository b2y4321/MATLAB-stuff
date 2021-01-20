function a=endptsolver(Tfin,Tinit,Pinit)

a=142.88;
b=0.02114;
R=0.0832;

Tfi=Tinit/1000;
Tff=Tfin/1000;

Pfin=10^(5.26-1810.9/(Tfin-28.5));

v1=fsolve(@(v) R*Tinit/(v-b)-a/(Tinit^0.5*v*(v+b))-Pinit,1);
v2=fsolve(@(v) R*Tfin/(v-b)-a/(Tinit^0.5*v*(v+b))-Pfin,1);%Saturation volume

Entr1=integral(@(Tf) 29.82./Tf+7.98+5.39.*Tf-2.03.*Tf^2+0.084.*Tf^-3,Tfi,Tff,'ArrayValued',true);
Entr2=100*integral(@(v) R./(v-b)+a./(2.*Tinit.^1.5.*v.*(v+b)),v1,v2,'ArrayValued',true);

a=Entr1+Entr2;