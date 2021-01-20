function a=rodflow(Ts)

n=100;
qdot=5e6;
L=3;
D=0.03;

Tin=993;
Cp=1000;
m=500;
k=0.3;
Ac=0.03;

v=pi*(D/2)^2*L;
As=pi*D*L;
Pwr=qdot*v;


Tout=Tin+(n*qdot*v)/(Cp*m);
Tm1=(Tin+Tout)/2;
Tm2=(Tm1+Ts)/2;

p=3217-0.6453*Tm2;
u=exp(3191.2/Tm2-11.058);

vel=m/(p*Ac);
Pr=Cp*u/k;
Re=p*vel*D/u;
Nu=1.125*(Re*Pr)^0.413;

h=Nu*D/k;

a=h*As*(Ts-Tm1)-Pwr;


