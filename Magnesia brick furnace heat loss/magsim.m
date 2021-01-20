Tinf=298;%Outside temp
T0=1473;%Inside furnace temp, and assumes h is high inside furnace
L=0.25;%Height of wall plate (vertical plate only)
L1=.02;%Thickness of first (high T) refractory layer
L2=.05;%Thickness of second refractory layer
k1=30;%Therm cond of refracroty layer 1
k2=1.2;%Therm cond of refractory layer 2

%Vertical plate temperature properties
Ta=fsolve(@(T) magsim_vert(T,Tinf,T0,L,L1,L2,k1,k2),[T0 T0]);

%Horiz plate temperature properties
Tb=fsolve(@(T) magsim_horiz(T,Tinf,T0,L,L1,L2,k1,k2),[T0 T0]);

T1a=Ta(1);
T2a=Ta(2);
T1b=Tb(1);
T2b=Tb(2);

qvert=k2*L^2*(T1a-T2a)/L2;
qhoriz=k2*L^2*(T1b-T2b)/L2;