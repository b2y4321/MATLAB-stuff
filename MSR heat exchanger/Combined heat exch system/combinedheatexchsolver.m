function a=combinedheatexchsolver()
%overall heat exch properties
mhot=29;
mcold=4.8;

%supercritical properties
%Hot stream
Thi=1500;
Achot=0.01;
Dhhot=0.002;
khot=0.3;
Cphot=1000;

%Cold stream
Tci=647;
Tco=873;
Cpcold=7030;
pcold=99.1;
viscold=3.05e-5;
kcold=0.115;
Accold=Achot;
Dhcold=0.002;

%Part 1 solving
Aexch1=heatexch1solve(mhot,mcold,Thi,Achot,Dhhot,khot,Cphot,Tci,Tco,Cpcold,pcold,viscold,kcold,Accold,Dhcold);
%supercritical optimal exchange area such that qcold=qhot
Tho1=fsolve(@(Tho) heatexch1(Tho,Aexch1,Thi,mhot,Achot,Dhhot,Tci,Cpcold,pcold,viscold,kcold,mcold,Accold,Dhcold,khot,Cphot),1000);

%Subcritical properties
%Hot stream
Thi=Tho1;
Achot=0.01;
Dhhot=0.002;
khot=0.3;
Cphot=1000;

%Cold stream
Tci=373;
Tco=647;
Accold=Achot;
Dhcold=0.002;
Cpcold=4180;

Aexch2=heatexch2solve(mhot,mcold,Thi,Achot,Dhhot,khot,Cphot,Tci,Tco,Accold,Dhcold,Cpcold);

Tho2=fsolve(@(Tho) heatexch2(Tho,Aexch2,Thi,mhot,Achot,Dhhot,khot,Cphot,Tci,Tco,mcold,Accold,Dhcold,Cpcold),1000);

disp(Aexch1);
disp(Aexch2);
disp(Tho1);
disp(Tho2);
