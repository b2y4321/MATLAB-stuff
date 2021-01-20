C=0.0047;
Cn=0.0047;
Rn=4.4;
R=146;
L=1e-10;
Ln=1e-10;
PerV=6;
PerT=0.1;
NumF=3;
sim('lclowpass_4');
times=simout.time;
voltageout=simout.data;

[~,pos]=max(voltageout);
maxval=voltageout(pos);
relvoltage=voltageout./maxval;


xlswrite('lccirc.xlsx',[times voltageout relvoltage]);
xlswrite('lccirc.xlsx',{'inductance','resistance','capacitance','voltage','time','Rn','Ln','Cn','Numfilter'},'D1:L1');
xlswrite('lccirc.xlsx',[L R C PerV PerT Rn Ln Cn NumF],'D2:L2');