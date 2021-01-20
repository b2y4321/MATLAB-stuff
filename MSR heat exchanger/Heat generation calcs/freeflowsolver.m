function a=freeflowsolver(mflow)
%Run fsolve on this function
Tgoal=1500;%Desired msalt outlet temperature

csfiss=250;%Fission cross section at energy of reactor
cscap=30;%Capture cross section at energy of reactor
N0=1e14;%Steady state neutron flux m-2
conc=8572*0.03;%Density per m3 of enriched U
t=1e-4;%Time between release and capture of neutron
xreac=1;%length of reactor tube
L=0.0775;%Radius of reactor tube
T1=993;%Inlet salt temperature
Cp=1000;%Heat capacity of salt - set as FluZirK

dens=3217-0.6453*T1;%FluZirK density vs temp
Q=mflow/dens;
Ac=pi*L^2;
vx=Q/Ac;

Nfiss=(xreac/vx)*N0*csfiss/(t*(cscap+csfiss))*(1-exp(-(cscap+csfiss)*conc*L*6.02e-5));
Pwr=(Nfiss/6.02e23)*200e6*98495;

T2=T1+Pwr/(mflow*Cp);
a=T2-Tgoal;

