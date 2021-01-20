function dTdt=comprair(t,F)

T=F(1);
n=F(2);

h=5;
A=0.05;
Pamb=1;
k=50;
Tinf=298;
Cv=118;
Hvap=22700;
R=0.0832;

Psat=10^(4.234-896.1/(T-34.71));
Vgas=R*T/Psat;

a(1)=(1/(n*Cv))*(h*A*(Tinf-T)-(Hvap/Vgas)*k*(Psat-Pamb)^.5);%dT/dt
a(2)=-(1/Vgas)*k*(Psat-Pamb)^.5;%dn/dt

dTdt=transpose(a);