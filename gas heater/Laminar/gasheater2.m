function a=gasheater2(mhot,mcold,L,w,Aexch,Th1,Tc1,Tc2)

Th2=fsolve(@(Th2) gasheater1(Th2,mcold,mhot,L,w,Aexch,Th1,Tc1,Tc2),300);

%Other calcs
%theses
Tc=(Tc1+Tc2)/2;
Th=(Th1+Th2)/2;

%thermal capacity
Cpcold=3.355+5.75e-4*Tc-1600*Tc^-2;
Cphot=3.355+5.75e-4*Th-1600*Th^-2;

Cc=mcold*Cpcold;
Ch=mhot*Cphot;

qh=Ch*(Th2-Th1);
qc=Cc*(Tc2-Tc1);

a=qh+qc;


