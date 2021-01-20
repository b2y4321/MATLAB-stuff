function a=heatexch1solve(mhot,mcold,Thi,Achot,Dhhot,khot,Cphot,Tci,Tco,Cpcold,pcold,viscold,kcold,Accold,Dhcold)



q=[];
for Aexch=1:100

Tho=fsolve(@(Tho) heatexch1(Tho,Aexch,Thi,mhot,Achot,Dhhot,Tci,Cpcold,pcold,viscold,kcold,mcold,Accold,Dhcold,khot,Cphot),1000,optimset('Disp','off'));

qcold=Cpcold*mcold*(Tco-Tci);
qhot=-Cphot*mhot*(Tho-Thi);
q=[q; qcold-qhot;];

end

[~,I]=min(abs(q));

a=I;

