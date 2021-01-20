function a=gasheater1(Th2,mcold,mhot,L,w,Aexch,Th1,Tc1,Tc2)


%theses
Tc=(Tc1+Tc2)/2;
Th=(Th1+Th2)/2;
Dh=L*w/(2*L+2*w);

%u calc
pk=[2.92E-11 -7.83E-08 0.000118275 -0.002477125];
pkin=[7.16E-11 5.59E-08 -6.36E-06];
kcold=polyval(pk,Tc);
khot=polyval(pk,Th);
kincold=polyval(pkin,Tc);
kinhot=polyval(pkin,Th);
phot=.0288/(0.0821*Th);
pcold=.0288/(.0821*Tc);
uhot=kinhot*phot;
ucold=kincold*pcold;
Pr=0.7;
vcold=mcold/(L*w*pcold);
vhot=mhot/(L*w*phot);
Recold=vcold*Dh/kincold;
Rehot=vhot*Dh/kinhot;

Nuhot=0.027*Rehot^.8*Pr^(1/3);
Nucold=0.027*Recold^.8*Pr^(1/3)*(uhot/ucold)^.14;
ucold=Nucold*kcold/Dh;
uhot=Nuhot*khot/Dh;

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








