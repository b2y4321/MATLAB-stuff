Tinit=25;%Initial inlet temperature
Tb=125;
Ltot=0.05;%Total length
S=0.002;
th=0.008;
g=9.8;
Cp=1010;
Liter=0.01;%Slice length

niter=Ltot/Liter;
Tin=Tinit;
L=Liter;

vouts=[];
mdots=[];
Touts=[];
Tins=[];
qs=[];
Lindex=[];

for i=1:niter
Tout=fsolve(@(Tout) TempSolver1(Tout,Tin,Tb,L,S,th,g,Cp),Tb);

%Mass flow rate calcs
Tf=(Tin+Tout)/2;
Ac=th*S;
As=2*L*th;

plight=28.8/(.0832*(Tf+273));%density of rising gas
pheavy=28.8/(.0832*(Tin+273));%density of ambient air
pexit=28.8/(.0832*(Tout+273));

vout=g*((pheavy-plight)/plight)*(2*L*plight/(g*(pheavy-plight)))^.5;
mdot=vout*pexit*Ac;
%vout assuming acceleration is constant

q=mdot*Cp*(Tout-Tin);

vouts=[vouts; vout;];
mdots=[mdots; mdot;];
Touts=[Touts; Tout;];
Tins=[Tins; Tin;];
qs=[qs; q;];
Lindex=[Lindex; i*Liter;];

Tin=Tout;
end
