function a=pcooker_springctrl(Ps)

Pamb=1;%Ambient pressure in bar
Xs=0.0159;%Offset distance
qin=1000;%Heating pwr
hvap=40600;%Heat of vap J/mol of fluid
R=8.314;
Ac=7.85e-5;%CS area of spring head
k=500;%spring constant
L=0.01;%Horizontal distance of vent (assuming a rectangular vent)

Tsat=198+643.7/(3.559-log10(Ps));%Sat temp of water, 376 to 539k
dens=101325*Ps*0.01802/(8.314*Tsat);

a=(pi^2/(8*dens))^0.5*(L*(-Xs+Ac*101325*(Ps-Pamb)/k)/(L+(-Xs+101325*Ac*(Ps-Pamb)/k)))-(R*Tsat/(101325*Ps))*qin/hvap;