function dcdt=dropcooling(t,c)

%Properties assumed at 50C
kin=1.92e-5;
Pr=0.7;
k=0.0285;
D=1e-3;
Cd=0.1;%Cd for a smooth sphere, assumed constant
Tinf=310;
Cp=4180;

T=c(1);
v=c(2);

Re=v*D/kin;
Nu=2+0.6*Re^0.5*Pr^(1/3);
h=Nu*k/D;
Adrop=4*pi*(D/2)^2;
Ac=pi*(D/2)^2;
m=1000*(4/3)*pi*(D/2)^3;
pair=28.8/(0.0832*Tinf);

a(1)=-h*Adrop*(T-Tinf)/(m*Cp);
a(2)=9.8-pair/(2*m)*Cd*v^2*Ac;
a(3)=v;

dcdt=transpose(a);

