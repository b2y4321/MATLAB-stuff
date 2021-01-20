function a=heatexch1solve()

%Hot stream
Thi=1500;
mhot=29;
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
mcold=5;
Accold=Achot;
Dhcold=0.002;

q=[];
for Aexch=1:100

Tho=fsolve(@(Tho) heatexch1(Tho,Aexch,Thi,mhot,Achot,Dhhot,Tci,Cpcold,pcold,viscold,kcold,mcold,Accold,Dhcold,khot,Cphot),1000,optimset('Disp','off'));

qcold=Cpcold*mcold*(Tco-Tci);
qhot=-Cphot*mhot*(Tho-Thi);
q=[q; qcold-qhot;];

end

[~,I]=min(abs(q));

disp('minimum value');
disp(q(I));
disp('optimum area');
disp(I);

%Solving for the temperature
Tho=fsolve(@(Tho) heatexch1(Tho,I,Thi,mhot,Achot,Dhhot,Tci,Cpcold,pcold,viscold,kcold,mcold,Accold,Dhcold,khot,Cphot),1000,optimset('Disp','off'));
disp('Hot side temperature');
disp(Tho);


