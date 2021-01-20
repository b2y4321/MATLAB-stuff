function a=heatexch2(Tho,Aexch,Thi,mhot,Achot,Dhhot,k,Cp,Tci,Tco,mcold,Accold,Dhcold,Cpcold)



%Mean temps
Th=(Thi+Tho)/2;
Tc=(Tci+Tco)/2-273;

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
viscold=0.00126*exp(-0.03531*Tc)+0.0004699*exp(-0.006736*Tc);
p2=[-5.63E-06 0.001608262 0.571700375];%liquid therm cond
p3=[-0.003337707 0.003181559 995.9648755];%liquid dens
Pr=11.73*exp(-0.03369*Tc)+1.31*exp(-0.0006746*Tc);
kcold=polyval(p2,Tc);
pcold=polyval(p3,Tc);

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




