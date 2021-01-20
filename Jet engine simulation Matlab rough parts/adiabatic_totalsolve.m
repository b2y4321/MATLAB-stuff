function a=adiabatic_totalsolve()

%Conmpression
T1=298;
P1=0.25;
P2=65;
Pdisch=0.25;

Tfin=fsolve(@(T2) adiabatic_compressor(T2,T1,P1,P2),1000,optimset('Disp','off'));

R=0.0832;
a=15.86;
b=0.02533;

v1=R.*Tfin./P1;
v2=fsolve(@(v) (R.*Tfin./(v-b)-a./(Tfin.^0.5.*v.*(v+b)))-P2,1);

h1=integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^-2),T1,Tfin,'ArrayValued',true);
h2=100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v1,v2);
htot=(h1+h2)/1000;


%Combustion
Tcomb2=fsolve(@(Tc2) adiabatic_combustion(Tc2,Tfin),3000);
Enthcombust=-8192000;

%Expansion
a2=28.23;
b2=0.02646;

Te2=fsolve(@(Tcf) adiabatic_nozzle(Tcf,Tcomb2,P2,Pdisch),500);

v2=R.*Tcomb2./Pdisch;
v1=fsolve(@(v) (R.*Tcomb2./(v-b2)-a2./(Tcomb2.^.5.*v.*(v+b2)))-P2,1,optimset('Disp','off'));

Enits2=80*integral(@(T) 8.314.*(3.28+(5.93e-4).*T-(4e-7).*T.^-2),Tcomb2,Te2,'ArrayValued',true);
Ecds2=12*integral(@(T) 8.314.*(5.457+(10.45e-4).*T-(115.7e-7).*T.^-2),Tcomb2,Te2,'ArrayValued',true);
Ewat3=13*integral(@(T) 8.314.*(3.47+(14.5e-4).*T-(121e-7).*T.^-2),Tcomb2,Te2,'ArrayValued',true);
he1=(Enits2+Ecds2+Ewat3)/100;

he2=100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v1,v2);
hetot=(he1+he2)/1000;

%Velocity of exhaust
KEmolar=1000*hetot;

%Final results
disp('Tfin of compressor stage');
disp(Tfin);
disp('Enthalpy of compressor stage KJ/mol');
disp(htot);
disp('Tout of combustion stage');
disp(Tcomb2);
disp('Tout of nozzle stage');
disp(Te2);
disp('Enthalpy of nozzle stage KJ/mol');
disp(hetot);
disp('Net energy ratio Production/consumption');
disp(-hetot/htot);
disp('Absolute Efficiency without bypass');
disp((1000*100*hetot+100*1000*htot)/Enthcombust);
disp('Molar Kinetic Energy');
disp(-KEmolar);
disp('Exhaust velocity m/s');
disp((-KEmolar/.0143)^.5);

xlswrite('jetenginestats.xlsx',{'Inlet P in bar','Inlet T in K','Compression Pressure bar','Outlet Pressure bar'}); 
xlswrite('jetenginestats.xlsx',[P1 T1 P2 Pdisch],1,'A2');
xlswrite('jetenginestats.xlsx',{'Tfin of compressor stage' 'Enthalpy of compressor stage KJ/mol','Tout of combustion stage','Tout of nozzle stage','Enthalpy of nozzle stage KJ/mol','Net energy ratio Production/consumption','Absolute Efficiency without bypass','Molar Kinetic Energy','Exhaust velocity m/s'},1,'A3');
xlswrite('jetenginestats.xlsx',[Tfin htot Tcomb2 Te2 hetot -hetot/htot ((1000*100*hetot+100*1000*htot)/Enthcombust) -KEmolar (-KEmolar/.0143)^.5],1,'A4');

