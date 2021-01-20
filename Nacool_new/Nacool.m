function a=Nacool(Ts,Tin,Tout,m,Ac,Drod,Lrod,qrod)

Tinf=(Tout+Tin)/2;

%Areas
As=pi*Drod*Lrod;

%Thermal properties calc
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

%Calc of q
qcalc=h*As*(Ts-Tinf);
a=qcalc-qrod;





