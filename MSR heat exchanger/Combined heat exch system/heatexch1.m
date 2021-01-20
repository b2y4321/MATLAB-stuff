function a=heatexch1(Tho,Aexch,Thi,mhot,Achot,Dhhot,Tci,Cpcold,pcold,viscold,kcold,mcold,Accold,Dhcold,k,Cp)

%Mean temps
Th=(Thi+Tho)/2;
%Cold temp entered manually

%Hot side properties
u=exp(3174.4/Th-11.044);
p=3217-0.6453*Th;


Chot=mhot*Cp;
Qhot=mhot/p;

Pr=Cp*u/k;
Re=p*(Qhot/Achot)*Dhhot/u;
Nu=0.57*(Re*Pr)^0.25;

hhot=Nu*k/Dhhot;

%Cold side properties - supercritical
Pr=Cpcold*viscold/kcold;
vcold=mcold/(pcold*Accold);
Re=pcold*vcold*Dhcold/viscold;
Nucold=0.027*Re^0.8*Pr^(1/3);
hcold=Nucold*kcold/Dhcold;

Ccold=mcold*Cpcold;
%Combined properties
Cr=Chot/Ccold;

U=(1/hhot+1/hcold)^-1;
NTU=U*Aexch/Chot;
E=(1-exp(-NTU*(1-Cr)))/(1-Cr*exp(-NTU*(1-Cr)));

q=E*Chot*(Thi-Tci);
qhot=Chot*(Thi-Tho);

a=q-qhot;




