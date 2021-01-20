Tin=25;
Tb=150;
L=0.006;%Height of channels formed by fins
S=0.0018;%The fin separation, or width of channel
th=0.02;%Depth of channels formed by fins
g=9.8;
Cp=1010;
%Decide between L and S term in the Ra (in the TempSolver1 func itself)
Tout=fsolve(@(Tout) TempSolver1(Tout,Tin,Tb,L,S,th,g,Cp),Tb);

%Mass flow rate calcs
Tf=(Tin+Tout)/2;
Ac=th*S;
As=2*L*th;
Dh=Ac/(2*th+2*S);

pkin=[7.16E-11	5.59E-08	-6.36E-06];
kin=polyval(pkin,Tf+273);

plight=28.8/(.0832*(Tf+273));%density of rising gas
pheavy=28.8/(.0832*(Tin+273));%density of ambient air
pexit=28.8/(.0832*(Tout+273));

vout=g*((pheavy-plight)/plight)*(2*L*plight/(g*(pheavy-plight)))^.5;
mdot=vout*pexit*Ac;
%vout assuming acceleration is constant

q1=mdot*Cp*(Tout-Tin);
ReExit=vout*Dh/kin;
