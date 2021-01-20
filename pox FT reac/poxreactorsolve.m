function a=poxreactorsolve()

mcool=10;
CPCool=2580;

Ua=300;
P=10;
V=100;
FA0=28.2; %Methane mol/s
FB0=.01;%CO mol/s
FC0=.01;%H2 mol/s
FD0=.01;%H2O mol/s
FE0=.01;%CO2 mol/s
FF0=14.1;%Oxygen mol/s
FI0=0;%Inerts mol/s
T0=1173;
Ta0=1000;

opts_1 = odeset('RelTol',1e-2,'AbsTol',1e-3);
[v,f]=ode15s(@(v,f) poxreactor(v,f,CPCool,mcool,Ua,P),[0 V],[FA0 FB0 FC0 FD0 FE0 FF0 T0 Ta0],opts_1);
xlswrite('poxref_waterb.xlsx',[v,f]);
met=f(:,1);
methane=met(size(met,1));
disp(1-methane/FA0);


