function a=adiabatic_combustion(Tc2,Tfin,SR)

Enthcombust=-8192000;%of 1 mol C12H26
%So here, we heat an basis of air required to burn 1 mol fuel, multiplied by SR (fuel not incl)
%For 1 mol C12H26, we need 12.5 mol O2, and thus 45.1 mol N2 (multiplied by
%SR to correct for excess air)
Estep1=67.1*SR*integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(4e3).*T.^-2),Tfin,298,'ArrayValued',true);
%And these are the molar ratios of the exit
Enits2=45.1*SR*integral(@(T) 8.314.*(3.28+(5.93e-4).*T-(4e-7).*T.^-2),298,Tc2,'ArrayValued',true);
Eoxy2=12.5*(SR-1)*integral(@(T) 8.314.*(3.639+(5.06e-4).*T-(2.27e4).*T.^-2),298,Tc2,'ArrayValued',true);
Ecds2=12*integral(@(T) 8.314.*(5.457+(10.45e-4).*T-(1.157e5).*T.^-2),298,Tc2,'ArrayValued',true);
Ewat3=13*integral(@(T) 8.314.*(3.47+(14.5e-4).*T-(1.21e4).*T.^-2),298,Tc2,'ArrayValued',true);

a=Enthcombust+Estep1+Enits2+Ecds2+Ewat3+Eoxy2;
