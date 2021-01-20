function nev=pistontemp3()

moles=0.0017;
a=52.44;
b=.0263;
vinit=24.45;
vfin=(24.6/25.6)*24.45;
vrel=30;

Tin=fsolve(@(T) pistontemp(T,a,b,moles,vinit,vfin),1500);
Tfin=fsolve(@(T) pistontemp2(T,a,b,moles,vinit,vfin,vrel),1500);

u1=1000*moles*integral(@(x) (301.86-0.00821.*7+61.03.*x-10.38.*x.^2+0.66.*x.^3-4.694.*x.^-2)./x,Tin./1000,Tfin./1000);
u2=8.314*moles*18.6*integral(@(x) (2.28+5.93e-4.*x+5e-7.*x.^-2)./x,Tin,Tfin);

disp('Tin');
disp(Tin);
disp('Tfin');
disp(Tfin);
disp('delU');
disp(u1+u2);
