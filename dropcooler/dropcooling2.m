function dcdt=dropcooling2(t,c)

T=c(1);
v=c(2);

D=0.25e-3;
Cd=0.1;%Cd for a smooth sphere, assumed constant
Tinf=310;
Cp=4180;

%Properties assumed at 50C
Tf=(Tinf+T)/2;
pkin=[7.16E-11	5.59E-08	-6.36E-06];
pk=[2.92E-11	-7.83E-08	0.000118275	-0.002477125];
kin=polyval(pkin,Tf);
k=polyval(pk,Tf);
Pr=0.7;


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

