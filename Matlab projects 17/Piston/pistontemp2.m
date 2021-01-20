function nev=pistontemp2(T2,a,b,moles,vinit,vfin,vrel)


Tin=fsolve(@(T) pistontemp(T,a,b,moles,vinit,vfin),1500);
u1=moles*integral(@(x) (301.86-0.00821.*7+61.03.*x-10.38.*x.^2+0.66.*x.^3-4.694.*x.^-2)./x,Tin./1000,T2./1000);
u3=8.314*moles*18.6*integral(@(x) (2.28+5.93e-4.*x+5e-7.*x.^-2)./x,Tin,T2);
u2=100*integral(@(y) (0.0832./(y-b)+a./(2.*T2.^1.5.*y.*(y+b))),vfin,vrel);


nev=u1+u2+u3;