R1=6.94e-6;
C=20000;
vfin=.04;
tfin=1e-2;

sim('rccircv2a');

xlswrite('rc3.xlsx',[simout.time simout.data]);