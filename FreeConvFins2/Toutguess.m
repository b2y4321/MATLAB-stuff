function a=Toutguess(Tout,Tin,Tb,L,w,d,b,kfin,Cp)

Dh=d*w/(2*d+2*w);
Tf1=(Tin+Tout)/2;

Ts=fsolve(@(Ts) Tsguess(Ts,Tb,Tf1,Dh,b,L,kfin),100,optimset('Disp','off'));

%h calc
T=(Ts+Tf1)/2;
pk=[2.92E-11 -7.83E-08 0.000118275 -0.002477125];	
k=polyval(pk,(T+273));
h=3.66*k/Dh;
%end of 

%mdot calculation
densout=28.8/(.0821*Tout);%in kg/m3
vout=9.8*(1.17-densout)/1.17*(2*L*1.17/(9.8*(1.17-densout)));%Outlet (hot end) velocity
%Density at 298k is 1.17 kg/m3
mdot=vout*densout*d*w;

Toutcalc=Ts+(Tin-Ts)*exp(-pi*Dh*h/(mdot*Cp));

a=Toutcalc-Tout;
