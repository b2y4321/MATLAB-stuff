function a=adiabatic_combustion(Tc2,Tfin)

Enthcombust=-8192000;
Estep1=100*integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^-2),Tfin,298,'ArrayValued',true);
Enits2=81.5*integral(@(T) 8.314.*(3.28+(5.93e-4).*T-(4e-7).*T.^-2),298,Tc2,'ArrayValued',true);
Ecds2=12*integral(@(T) 8.314.*(5.457+(10.45e-4).*T-(115.7e-7).*T.^-2),298,Tc2,'ArrayValued',true);
Ewat3=13*integral(@(T) 8.314.*(3.47+(14.5e-4).*T-(121e-7).*T.^-2),298,Tc2,'ArrayValued',true);

a=Enthcombust+Estep1+Enits2+Ecds2+Ewat3;
