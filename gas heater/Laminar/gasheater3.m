function a=gasheater3()

mcold=1;
L=1;
w=0.01;
Aexch=0.2;
n=1000;

Th1=523;
Tc1=253;
Tc2=293;

mhot=fsolve(@(mhot) gasheater2(mhot,mcold,L,w,Aexch,Th1,Tc1,Tc2),mcold);
Th2=fsolve(@(Th2) gasheater1(Th2,mcold,mhot,L,w,Aexch,Th1,Tc1,Tc2),300);

%Other calcs
%theses
Tc=(Tc1+Tc2)/2;
Th=(Th1+Th2)/2;
Dh=L*w/(2*L+2*w);

%thermal capacity
Cpcold=3.355+5.75e-4*Tc-1600*Tc^-2;
Cphot=3.355+5.75e-4*Th-1600*Th^-2;

Cc=mcold*Cpcold;
Ch=mhot*Cphot;
Cr=Ch/Cc;
qh=Ch*(Th2-Th1);

%Re number
pkin=[7.16E-11 5.59E-08 -6.36E-06];
ucold=polyval(pkin,Tc);
uhot=polyval(pkin,Th);

phot=0.0288/(0.0821*Th);
pcold=0.0288/(0.0821*Tc);
vhot=mhot/(L*w*phot*n);
vcold=mhot/(L*w*pcold*n);

Rehot=vhot*Dh/uhot;
Recold=vcold*Dh/ucold;

disp('Heat transfer rate');
disp(qh*n);
disp('Heat transfer rate per vane');
disp(qh);
disp('Rel capacity');
disp(Cr);
disp('Hot outlet temp');
disp(Th2);
disp('Hot mass flow rate');
disp(mhot);
disp('Hot Re');
disp(Rehot);
disp('Cold Re');
disp(Recold);