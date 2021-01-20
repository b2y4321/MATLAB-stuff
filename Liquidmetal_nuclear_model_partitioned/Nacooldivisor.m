function a=Nacooldivisor(Nrod,Lrod,qrod,Tin,m,Ac,Drod,amat)

%Heat calcs
qtot=qrod*Nrod;
Tout=fsolve(@(Tout) Nacooltempsolver(Tout,Tin,qtot,m),800,optimset('Disp','off'));
qvol=qrod/(4*pi*(Drod/2)^2*Lrod);%Heat generated per unit volume

%Surface temp calc
Ts=fsolve(@(Ts) Nacool(Ts,Tin,Tout,m,Ac,Drod,Lrod,qrod),1000,optimset('Disp','off'));

%Center temp calculation
Tc=Ts+qvol*(Drod/2)^2/(4*amat);

%%%%%%%%%%%%%%convection calcs
Tinf=(Tout+Tin)/2;
Tf=(Ts+Tinf)/2;

Cp=-(3.001e6)*Tf^-2+1658-0.8479*Tf+(4.454e-4)*Tf^2;
b=1/(4316-Tf);
u=exp(556.835/Tf-0.3958*log(Tf)-6.4406);
p=1014-0.235*Tf;
k=110-0.0648*Tf+(1.16e-5)*Tf^2;
v=m/(p*Ac);
kin=u/p;
alpha=k/(p*Cp);
Pr=Cp*u/k;

%Re and Ra calc
Re=p*v*Drod/u;
Ra=9.8*b*(Ts-Tinf)*Lrod^3/(kin*alpha);

%On to the params
Nuforced=1.125*(Re*Pr);
Nufree=(0.825+0.387*Ra^(1/6)*(1/(1+(0.492/Pr)^(9/16))^(8/27)));
hforced=Nuforced*k/Drod;
hfree=Nufree*k/Lrod;
h=hforced+hfree;
%%%%%%%%%%%%%%%%%%%%%%%

a=[Tout Tinf Ts hforced hfree h];

