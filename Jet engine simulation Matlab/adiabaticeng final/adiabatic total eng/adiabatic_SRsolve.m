function a=adiabatic_SRsolve()

%Conmpression
T1=298;
P1=0.25;
SRstart=1;
P2=65;
SRend=10;
incrSR=10;
Pdisch=0.25;
TempCeling=2200;%Celing temperature, 0=unlimited
TurEff=0.88;%Combined efficiency of exhaust turbine and compr turbine


Nmuf=[];
MrgUf=[];
Tfins=[];
htots=[];
Tcomb2s=[];
Eheatlosses=[];
TempDiffs=[];
Te2s=[];
hetots=[];
ratios=[];
AbsEffs=[];
MKEs=[];
Evels=[];
SRs=[];

for j=(incrSR*SRstart):(incrSR*SRend)
SR=j/incrSR;

%!!!!!!!!!!!Main program!!!!!!!!!!!!!!!
Tfin=fsolve(@(T2) adiabatic_compressor(T2,T1,P1,P2),1000,optimset('Disp','off'));
%For air
R=0.0832;
a=15.86;
b=0.02533;

v1=R.*Tfin./P1;
v2=fsolve(@(v) (R.*Tfin./(v-b)-a./(Tfin.^0.5.*v.*(v+b)))-P2,1);
h1=integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^-2),T1,Tfin,'ArrayValued',true);
h2=100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v1,v2);
%57.6 moles of air per mol fuel , multiplied by SR
htot=57.6*SR*(h1+h2)/1000;


%Combustion
Tcomb2=fsolve(@(Tc2) adiabatic_combustion(Tc2,Tfin,SR),3000);
Enthcombust=-8192000;
if(TempCeling~=0)
    if(Tcomb2>=TempCeling)
        TempDiff=Tcomb2-TempCeling;
        Tcomb2=TempCeling;
        
        %Calculating energy lost by heatcap of O2,N2,etc, on a molar basis
        Enits2=45.1*SR*integral(@(T) 8.314.*(3.28+(5.93e-4).*T-(4e-7).*T.^-2),TempCeling,(TempCeling+TempDiff),'ArrayValued',true);
        Eoxy2=12.5*(SR-1)*integral(@(T) 8.314.*(3.639+(5.06e-4).*T-(2.27e4).*T.^-2),TempCeling,(TempCeling+TempDiff),'ArrayValued',true);
        Ecds2=12*integral(@(T) 8.314.*(5.457+(10.45e-4).*T-(1.157e5).*T.^-2),TempCeling,(TempCeling+TempDiff),'ArrayValued',true);
        Ewat3=13*integral(@(T) 8.314.*(3.47+(14.5e-4).*T-(1.21e4).*T.^-2),TempCeling,(TempCeling+TempDiff),'ArrayValued',true);
        %Divide by num of moles:
        Eheatloss=(Enits2+Eoxy2+Ecds2+Ewat3);
    end
end

%Expansion
a2=28.23;
b2=0.02646;

%The expansion, adiabatically, assumes only air
Te2=fsolve(@(Tcf) adiabatic_nozzle(Tcf,Tcomb2,P2,Pdisch),500);
v2=R.*Tcomb2./Pdisch;
v1=fsolve(@(v) (R.*Tcomb2./(v-b2)-a2./(Tcomb2.^.5.*v.*(v+b2)))-P2,1,optimset('Disp','off'));

%Enthalpy change associated with stream
Enits2=45.1*SR*integral(@(T) 8.314.*(3.28+(5.93e-4).*T-(4e-7).*T.^-2),Tcomb2,Te2,'ArrayValued',true);
Eoxy2=12.5*(SR-1)*integral(@(T) 8.314.*(3.639+(5.06e-4).*T-(2.27e4).*T.^-2),Tcomb2,Te2,'ArrayValued',true);
Ecds2=12*integral(@(T) 8.314.*(5.457+(10.45e-4).*T-(115.7e-7).*T.^-2),Tcomb2,Te2,'ArrayValued',true);
Ewat3=13*integral(@(T) 8.314.*(3.47+(14.5e-4).*T-(121e-7).*T.^-2),Tcomb2,Te2,'ArrayValued',true);
he1=(Enits2+Ecds2+Ewat3+Eoxy2);

nmol=(45.1*SR+12.5*(SR-1)+12+13);%Moles expanded per mol of fuel
%RK uses parameters for air, as it's easier
he2=nmol*100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v1,v2);
hetot=(he1+he2)/1000;

%Velocity of exhaust, assuming extracted energy to stage 1
KE=1000*(hetot+htot/TurEff);

%Writing everything down
SRs=[SRs; SR;];
Nmuf=[Nmuf; (SR*57.6);];
MrgUf=[MrgUf; nmol;];
Tfins=[Tfins; Tfin;];
htots=[htots; htot;];
Tcomb2s=[Tcomb2s; Tcomb2;];
Eheatlosses=[Eheatlosses; Eheatloss;];
TempDiffs=[TempDiffs; TempDiff;];
Te2s=[Te2s; Te2;];
hetots=[hetots; hetot;];
ratios=[ratios; (-hetot/htot);];
AbsEffs=[AbsEffs; ((1000*hetot+1000*htot)/Enthcombust);];
MKEs=[MKEs; (-KE/nmol);];
Evels=[Evels; ((-KE/(.0143*nmol))^.5);];

end

xlswrite('jetenginestats_SR.xlsx',{'Inlet P in bar','Inlet T in K','Compression Pressure','Outlet Pressure'}); 
xlswrite('jetenginestats_SR.xlsx',[P1 T1 P2 Pdisch],1,'A2');
xlswrite('jetenginestats_SR.xlsx',{'Stoich ratio' 'Moles air inlet/mol fuel' 'Moles resultant gas/mol fuel' 'Tfin of compressor stage' 'Enthalpy of compressor stage KJ/mol fuel','Tout of combustion stage','Energy lost during combustuion KJ/mol fuel','Temperature celing vs calculated difference','Tout of nozzle stage','Enthalpy of nozzle stage KJ/mol fuel','Net energy ratio Production/consumption','Absolute Efficiency without bypass','Molar Kinetic Energy','Exhaust velocity m/s without bypass'},1,'A3');
xlswrite('jetenginestats_SR.xlsx',[SRs Nmuf MrgUf Tfins htots Tcomb2s Eheatlosses TempDiffs Te2s hetots ratios AbsEffs MKEs Evels],1,'A4');