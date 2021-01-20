function a=heatexch2solve(mhot,mcold,Thi,Achot,Dhhot,khot,Cphot,Tci,Tco,Accold,Dhcold,Cpcold)


q=[];
for Aexch=1:100

Tho=fsolve(@(Tho) heatexch2(Tho,Aexch,Thi,mhot,Achot,Dhhot,khot,Cphot,Tci,Tco,mcold,Accold,Dhcold,Cpcold),1000,optimset('Disp','off'));

qcold=Cpcold*mcold*(Tco-Tci);
qhot=-Cphot*mhot*(Tho-Thi);
q=[q; qcold-qhot;];

end

[~,I]=min(abs(q));

a=I;

