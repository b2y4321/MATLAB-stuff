R=1e-4;
C=1000;

freq=61;
Vmax=0.2;

sim('rccircv2a');

xlswrite('rc3.xlsx',[simout.time simout.data]);