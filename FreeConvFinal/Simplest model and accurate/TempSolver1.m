function a=TempSolver1(Tout,Tin,Tb,L,S,th,g,Cp)

Tf=(Tin+Tout)/2;
Ac=th*S;
As=2*L*th;

%Mass flow rate calcs
plight=28.8/(.0832*(Tf+273));%density of rising gas
pheavy=28.8/(.0832*(Tin+273));%density of ambient air
pexit=28.8/(.0832*(Tout+273));

vout=g*((pheavy-plight)/plight)*(2*L*plight/(g*(pheavy-plight)))^.5;
mdot=vout*pexit*Ac;
%vout assuming acceleration is constant

%Heat transfer rate calcs
b=1/Tf;%Thermal expans
pkin=[7.16E-11	5.59E-08	-6.36E-06];
palpha=[9.73E-11	8.09E-08	-8.63E-06];
pk=[2.92E-11	-7.83E-08	0.000118275	-0.002477125];

kin=polyval(pkin,Tf+273);
alpha=polyval(palpha,Tf+273);
k=polyval(pk,Tf+273);

Ra=g*b*(Tb-Tf)*L^3/(kin*alpha);

Nu=(576/((Ra*(S/L))^2)+2.873/((Ra*(S/L))^.5))^(-0.5);

h=Nu*k/S;

q1=mdot*Cp*(Tout-Tin);
q2=h*As*(Tb-Tf);

a=q1-q2;
