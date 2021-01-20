function a=adiabatic_stagesolve()

T1=298;
P1=1;
P2=[2.5 5 10 15 20 30 40 50 65];%List of end pressures for each stage
Plow=1;
Tcool=473;%Temperature we cool each outlet stream to

Ntrial=size(P2,2);


enthalpy=[];
Tfinals=[];
enthcool=[];

%First stage
%Solving for temperature
Pfin1=P2(1);
Tfin=fsolve(@(T2) adiabatic_stage(T2,T1,P1,Pfin1,Plow),1000,optimset('Display','off'));
Tfinals=[Tfinals; Tfin;];

%Solving for enthalpy
R=0.0832;
a=15.86;
b=0.02533;

v1=fsolve(@(v) (R.*T1./(v-b)-a./(Tfin.^.5.*v.*(v+b)))-P1,1,optimset('Display','off'));
v3=R.*T1./Plow;
v4=R.*Tfin./Plow;
v2=fsolve(@(v) (R.*Tfin./(v-b)-a./(Tfin.^.5.*v.*(v+b)))-P2,1,optimset('Display','off'));

h1=100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v1,v3);
h2=integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^2),T1,Tfin,'ArrayValued',true);
h3=100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v4,v2);

enthalpy=[enthalpy; (h1+h2+h3);];
%end

hcool=integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^2),Tfin,Tcool,'ArrayValued',true);
enthcool=[enthcool; hcool;];

for(i=2:Ntrial)
%Final temperature
Pini=P2(i-1);
Pfin=P2(i);
Tfin=fsolve(@(T2) adiabatic_stage(T2,Tcool,Pini,Pfin,Plow),1000,optimset('Display','off'));
Tfinals=[Tfinals; Tfin;];

%Solving for enthalpy
R=0.0832;
a=15.86;
b=0.02533;

v1=fsolve(@(v) (R.*T1./(v-b)-a./(Tfin.^.5.*v.*(v+b)))-Pini,1,optimset('Display','off'));
v3=R.*T1./Plow;
v4=R.*Tfin./Plow;
v2=fsolve(@(v) (R.*Tfin./(v-b)-a./(Tfin.^.5.*v.*(v+b)))-Pfin,1,optimset('Display','off'));

h1=100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v1,v3);
h2=integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^2),T1,Tfin,'ArrayValued',true);
h3=100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v4,v2);

enthalpy=[enthalpy; (h1+h2+h3);];
%end

%Cooling enthalpy
hcool=integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^2),Tfin,Tcool,'ArrayValued',true);
enthcool=[enthcool; hcool;];

end
a=[Tfinals enthalpy enthcool];
xlswrite('adiastages.xlsx',[Tfinals enthalpy enthcool]);