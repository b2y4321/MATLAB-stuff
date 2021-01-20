function a=gasheater1(Th2,mcold,mhot,L,w,Aexch,Th1,Tc1,Tc2)

%theses
Tc=(Tc1+Tc2)/2;
Th=(Th1+Th2)/2;
Dh=L*w/(2*L+2*w);

%u calc - assumes lam flow
pk=[2.92E-11 -7.83E-08 0.000118275 -0.002477125];
kcold=polyval(pk,Tc);
khot=polyval(pk,Th);
ucold=3.66*kcold/Dh;
uhot=3.66*khot/Dh;
u=(1/ucold+1/uhot)^-1;

%thermal capacity
Cpcold=3.355+5.75e-4*Tc-1600*Tc^-2;
Cphot=3.355+5.75e-4*Th-1600*Th^-2;

Cc=mcold*Cpcold;
Ch=mhot*Cphot;
Cr=Ch/Cc;
%end
NTU=u*Aexch/Cc;
E=(1-exp(-NTU*(1-Cr)))/(1-Cr*exp(-NTU*(1-Cr)));
%q calcs
q1=E*Ch*(Th1-Tc1);
qh=Ch*(Th2-Th1);

a=q1+qh;








