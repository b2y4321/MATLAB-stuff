%12v LC filter parameters
R1=.000192;
L1=.00047;

%Transformer voltage ratios Vlow/Vhigh
n1=0.31/12;
n3=0.1/12;

%High filter charac
RtotH=1.01e-3;
CtotH=6.549e-5;
RH=1e-5;
LH=1e-10;
CH=10;

%Low filter charac
RtotL=3.131e-3;
CtotL=6.549e-5;
RLw=3.1e-5;
LLw=1e-10;
CLw=10;

%Harmonic noise characteristics
freq=120;
RHm=5e-7;
CHm=1e-4;

%Pertubation characteristics
PerV=6;
PerT=0.025;

%End of data



sim('lrlowpass_6');
%Output vectors
times1=Highout.time;


voltageout1=Highout.data;
voltageout3=Lowout.data;
voltageout4=HVout.data;
voltageout6=Preinverter.data;

%Load draw characteristics
voltageload1=Highcurr.data;
voltageload2=Lowcurr.data;
%End


[~,pos1]=max(voltageout1);
maxval1=voltageout1(pos1);
relvoltage1=voltageout1./maxval1;

[~,pos3]=max(voltageout3);
maxval3=voltageout3(pos3);
relvoltage3=voltageout3./maxval3;

[~,pos4]=max(voltageout4);
maxval4=voltageout4(pos4);
relvoltage4=voltageout4./maxval4;

[~,pos5]=max(voltageload1);
maxval5=voltageload1(pos5);
relvoltage5=voltageload1./maxval5;

[~,pos6]=max(voltageload2);
maxval6=voltageload2(pos6);
relvoltage6=voltageload2./maxval6;

%[Preinverter voltage/time, postfilter voltage/time, 0.8 voltagev/time,
%0.45 voltage v/time,0.25 voltage v/time]

finalvector=[times1 voltageout6 times1 voltageout4 relvoltage4 times1 voltageout1 relvoltage1 times1 voltageout3 relvoltage3];
xlswrite('totalcirc.xlsx',finalvector);
xlswrite('startupdata.xlsx', [times1 voltageload1 relvoltage5 times1 voltageload2 relvoltage6])
