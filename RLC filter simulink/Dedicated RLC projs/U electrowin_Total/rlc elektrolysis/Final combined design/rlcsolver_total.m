%Initial RC filter parameters
Ci=.0047;
Ri=1e-2;

%Postrectifier LC filter parameters
R1=.00192;
L1=.02;

%Transformer voltage ratios Vlow/Vhigh
n1=0.8/24;
n2=0.45/24;
n3=0.25/24;

%High filter charac
RH=2.2e-6;
CH=400;

%Med filter charac
RM=1.24e-6;
CM=400;

%Low filter charac
RLw=6.94e-7;
CLw=400;

%Harmonic noise characteristics
freq=61;
RHm=5e-7;
CHm=1e-4;

%Pertubation characteristics
PerV=12;
PerT=0.025;

%End of data



sim('lrlowpass_6');
%Output vectors
times1=Highout.time;
voltageout1=Highout.data;

times2=Medout.time;
voltageout2=Medout.data;

times3=Lowout.time;
voltageout3=Lowout.data;

times4=HVout.time;
voltageout4=HVout.data;

times6=Preinverter.time;
voltageout6=Preinverter.data;
%End


[~,pos1]=max(voltageout1);
maxval1=voltageout1(pos1);
relvoltage1=voltageout1./maxval1;

[~,pos2]=max(voltageout2);
maxval2=voltageout2(pos2);
relvoltage2=voltageout2./maxval2;

[~,pos3]=max(voltageout3);
maxval3=voltageout3(pos3);
relvoltage3=voltageout3./maxval3;

[~,pos4]=max(voltageout4);
maxval4=voltageout4(pos4);
relvoltage4=voltageout4./maxval4;

%[Preinverter voltage/time, postfilter voltage/time, 0.8 voltagev/time,
%0.45 voltage v/time,0.25 voltage v/time]
xlswrite('totalcirc.xlsx',[times6 voltageout6 times4 voltageout4 relvoltage4 times1 voltageout1 relvoltage1 times2 voltageout2 relvoltage2 times3 voltageout3 relvoltage3]);
