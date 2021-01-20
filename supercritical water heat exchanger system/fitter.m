function a=fitter(matrx)
A=matrx(1);
B=matrx(2);
C=matrx(3);
D=matrx(4);
E=matrx(5);
F=matrx(6);

par=xlsread('Water supercritical props refined.xlsx','A2:E455');

T=par(:,1);
Cp=par(:,3);

Cpcalc=A.*exp(B.*T)+C.*exp(D.*T)+E.*exp(F.*T);

a=sum((Cp-Cpcalc).^2);