%function a=Tsolve_modified()

Tin=25;
Tb=125;
L=0.117;%Length of hfin
w=0.006;%Width of channel
d=0.032;%Length of channel
b=15e-4;%Width of fin
kfin=160;
Cp=1010;

As=2*L*d;
Acvent=w*d;
Dh=d*w/(2*d+2*w);


Tout=fsolve(@(Tout) Toutguess(Tout,Tin,Tb,L,w,d,b,kfin,Cp),100);

Tf1=(Tin+Tout)/2;

Ts=fsolve(@(Ts) Tsguess(Ts,Tb,Tf1,Dh,b,L,kfin),100);

%h calc
T=(Ts+Tf1)/2;
pk=[2.92E-11 -7.83E-08 0.000118275 -0.002477125];	
k=polyval(pk,(T+273));
h=3.66*k/Dh;
%end of 

%mdot calculation
densin=28.8/(.0821*(Tin+273));
densout=28.8/(.0821*(Tout+273));%in kg/m3
densmean=28.8/(.0821*(Tf1+273));

%Time determ
t=(2*L*densmean/(9.8*(densin-densmean)))^.5;
vout=(densin-densmean)/densmean*9.8*t;

%Density at 298k is 1.17 kg/m3
mdot=vout*densout*d*w;

%Calc of Re
pkin=[7.16E-11 5.59E-08 -6.36E-06];		
kin=polyval(pkin,(T+273));
Q=mdot/densmean;
vel=Q/Acvent;
Re=vel*Dh/kin;
Remax=vout*Dh/kin;%Max Re number
%end
q=mdot*Cp*(Tout-Tin);

disp('Outlet temp');
disp(Tout);
disp('Velocity mean');
disp(vel);
disp('Velocity out');
disp(vout);
disp('Re average');
disp(Re);
disp('Re maximum');
disp(Remax);
disp('convect coeff');
disp(h);
disp('heat duty W');
disp(q);

