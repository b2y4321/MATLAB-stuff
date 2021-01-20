C=1;
R=.00192;
L=5;

PerV=30;
PerT=0.1;

sim('lrlowpass_4');
times=simout.time;
voltageout=simout.data;

[~,pos]=max(voltageout);
maxval=voltageout(pos);
relvoltage=voltageout./maxval;


xlswrite('lccirc.xlsx',[times voltageout relvoltage]);
