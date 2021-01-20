function nev=pistontemp(T2,a,b,moles,vinit,vfin)

Ugoal=moles*2064300;
Tt=T2./1000;
u1=moles*integral(@(x) 301.86-0.00821.*7+61.03.*x-10.38.*x.^2+0.66.*x.^3-4.694.*x.^-2,.298,Tt);
u3=8.314*moles*18.6*integral(@(x) 2.28+5.93e-4.*x+5e-7.*x.^-2,298,T2);
u2=(3.*a./(2.*Tt.^0.5)).*integral(@(y) (1./(y.^2+b.*y)),vinit,vfin);

nev=u1+u2+u3-Ugoal;