function a=Tsguess(Ts,Tb,Tf1,Dh,b,L,kfin)

T=(Tf1+Ts)/2;

%Calc of h
		
pk=[2.92E-11 -7.83E-08 0.000118275 -0.002477125];	

k=polyval(pk,(T+273));
h=3.66*k/Dh;
m=(2*h/(kfin*b))^.5;

Tsgues=(Tb/2)+(Tf1/2)+((Tb-Tf1)/(2*cosh(m*L)));

a=Ts-Tsgues;