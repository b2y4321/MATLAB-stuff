function dfdv=poxreactor_isothermal(~,f,CPCool,mcool,Ua,P,FI)

FA=f(1);%CH4
FB=f(2);%CO
FC=f(3);%H2
FD=f(4);%H2O
FE=f(5);%CO2
FF=f(6);%O2
T=f(7);
Ta=500;

Tt=T./1000;
CPB=25.57+6.096.*Tt+4.055.*Tt.^2-2.671.*Tt.^3-0.131.*Tt.^-2;%CO
CPC=33.07-11.36.*Tt+11.43.*Tt.^2-2.772.*Tt.^3-0.159.*Tt.^-2;%H2
CPE=-0.144+129.1.*Tt-50.12.*Tt.^2+6.844.*Tt.^3-0.112.*Tt.^-2+3.637.*Tt.^-1;%CO2
CPD=25+55.19.*Tt-33.69.*Tt.^2+7.948.*Tt.^3-0.1366.*Tt.^-2;%H2O
CPA=-0.703+108.47.*Tt-42.52.*Tt.^2+5.862.*Tt.^3-0.679./Tt.^-2;%CH4
CPF=30.03+8.773*Tt-3.988*Tt^2+0.788*Tt^3-0.742*Tt^-2;

R=0.0832;
Enth1=-802000;
Enth2=-32000;
V0=(FA+FB+FC+FD+FE+FF+FI).*R.*T./P;

PA=R.*T.*FA./V0;%CH4
PB=R.*T.*FB./V0;%CO
PC=R.*T.*FC./V0;%H2
PD=R.*T.*FD./V0;%H2O
PE=R.*T.*FE./V0;%CO2
PF=R*T*FF/V0; %O2

CA=PA/(R*T);
CF=PF/(R*T);

k1=328.7.*exp(-30800./(8.314.*T));
KO2=7.4e-5*exp(57970/(8.314*T));
KCH4=2.02e-3.*exp(36330./(8.314.*T));
k2=1.6e22*exp(-59000/T);

r1=(k1*PA*PF^.5)/(1+KCH4*PA+KO2*PF^.5)^2;
r2=k2*CA*CF;

a(1)=-r1-r2;
a(2)=r1;
a(3)=2*r1;
a(4)=2*r2;
a(5)=r2;
a(6)=-0.5*r1-2*r2;
a(7)=((-r1*Enth1-r2*Enth2)-Ua*(T-Ta))/(FA*CPA+FB*CPB+FC*CPC+FD*CPD+FE*CPE+FF*CPF);
a(8)=Ua*(T-Ta);

dfdv=transpose(a);








