function a=freeflow()

csfiss=250;
cscap=30;
N0=1e14;
conc=8572*0.03;
t=1e-4;
xreac=1;
L=0.0775;
T1=993;
mflow=28.27;
Cp=1000;

dens=3217-0.6453*T1;
Q=mflow/dens;
Ac=pi*L^2;
vx=Q/Ac;

Nfiss=(xreac/vx)*N0*csfiss/(t*(cscap+csfiss))*(1-exp(-(cscap+csfiss)*conc*L*6.02e-5));
Pwr=(Nfiss/6.02e23)*200e6*98495;

T2=T1+Pwr/(mflow*Cp);
a=T2;
disp(Pwr);

