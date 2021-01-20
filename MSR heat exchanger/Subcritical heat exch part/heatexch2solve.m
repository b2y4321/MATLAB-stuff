function a=heatexch2solve(Aexch)

%Hot stream
Thi=1223;
mhot=29;
Achot=0.01;
Dhhot=0.002;
khot=0.3;
Cphot=1000;

%Cold stream
Tci=373;
Tco=647;
mcold=5;
Accold=Achot;
Dhcold=0.002;
Cpcold=4180;



q=[];
for Aexch=1:100

Tho=fsolve(@(Tho) heatexch2(Tho,Aexch,Thi,mhot,Achot,Dhhot,khot,Cphot,Tci,Tco,mcold,Accold,Dhcold,Cpcold),1000,optimset('Disp','off'));

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
Tho=fsolve(@(Tho) heatexch2(Tho,Aexch,Thi,mhot,Achot,Dhhot,khot,Cphot,Tci,Tco,mcold,Accold,Dhcold,Cpcold),1000,optimset('Disp','off'));
disp('Hot side temperature');
disp(Tho);


