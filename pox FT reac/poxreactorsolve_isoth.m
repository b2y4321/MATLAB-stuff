function a=poxreactorsolve_isoth()

mcool=10;
CPCool=4180;

Ua=1000;
P=1;
V=100;
FA0=28.2; %Methane mol/s
FB0=1;%CO mol/s
FC0=1;%H2 mol/s
FD0=1;%H2O mol/s
FE0=1;%CO2 mol/s
FF0=14.1;%Oxygen mol/s
FI0=.1;%Inerts mol/s
T0=1073;


[v,f]=ode15s(@(v,f) poxreactor_isothermal(v,f,CPCool,mcool,Ua,P,FI0),[0 V],[FA0 FB0 FC0 FD0 FE0 FF0 T0 0]);
xlswrite('poxref_water.xlsx',[v,f]);
met=f(:,1);
methane=met(size(met,1));
disp(1-methane/FA0);


