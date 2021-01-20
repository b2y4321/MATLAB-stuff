function res=stgsolve()

%Stage 1 characteristics
T1=298;
P1=1;%Initial air fuel feed pressure
CR=22;%Piston compression ratio

%General characteristics
nair=1;%Initial amount of air in mol
Umol=-5109000;%Enthalpy reaction per mol
nexh=1.075;%mol of exhaust gas per mol air+requisite fuel
nfuel=0.0168*nair;%Number of moles fuel per mol air required in your setup
%intermediate calcs
R=0.0832;
v4=R*T1/P1;%v4 is same as v1 assumed
v3=v4/CR;%v3 is same as v2 assumed
v1=v4;
v2=v3;

%Exhaust composition
xn2_2=0.739;
xwat_2=0.135;
xco2_2=0.125;


T2=fsolve(@(T2) stage1(T2,T1,P1,CR),600);
T3=fsolve(@(T3) stage2(T3,T2,xco2_2,xn2_2,xwat_2,nfuel,Umol),1000);
T4=fsolve(@(T4) stage3(T4,T3,xn2_2,xwat_2,xco2_2,v3,v4),600);

Tt1=T1./1000;
Tt2=T2./1000;
Tt3=T3/1000;
Tt4=T4/1000;

%Stage 1 internal energy

a1=15.61;
a2=17.37;

b1=0.02683;
b2=0.02197;

b=0.79*b1+0.21*b2;
a=0.79^2*a1+0.79*0.21*(a1*a2)^.5+0.21^2*a2;

U1a=nair.*790.*integral(@(Tt) (27.24+1.007.*Tt+5.139.*Tt.^2-1.89.*Tt.^3+0.00867.*Tt.^-2),Tt1,Tt2,'ArrayValued',true);
U1b=nair.*210.*integral(@(Tt) (24.49+14.17.*Tt-5.845.*Tt.^2+0.896.*Tt.^3+0.02522.*Tt.^-2),Tt1,Tt2,'ArrayValued',true);
U1c=nair.*100*integral(@(v) 3.*a./(2.*T2.^.5.*v.*(v+b)),v1,v2,'ArrayValued',true);

%Stage 3 internal energy

a1=15.61;
a2=142.88;
a3=64.62;

b1=0.02683;
b2=0.02114;
b3=0.02967;

y1=xn2_2;
y2=xwat_2;
y3=xco2_2;

b=y1*b1+y2*b2+y3*b3;
a=y1^2*a1+y2^2*a2+y3^2*a3+2*y1*y2*(a1*a2)^.5+2*y1*y3*(a1*a3)^.5+2*y2*y3*(a2*a3)^.5;

U3a=nexh.*nair.*100*integral(@(v) R./(v-b)+a./(2.*T3.^1.5.*(v.^2+b.*v)),v3,v4,'ArrayValued',true);
U3b=1000*nexh.*nair.*xn2_2.*integral(@(Tt) (27.24+1.007.*Tt+5.139.*Tt.^2-1.89.*Tt.^3+0.00867.*Tt.^-2)./Tt,Tt3,Tt4,'ArrayValued',true);
U3c=1000*nexh.*nair.*xwat_2.*integral(@(Tt) (28.82+7.98.*Tt+5.395.*Tt.^2-2.038.*Tt.^3+0.084.*Tt.^-2)./Tt,Tt3,Tt4,'ArrayValued',true);
U3d=1000*nexh.*nair.*xco2_2.*integral(@(Tt) (26.6+29.83.*Tt+33.43.*Tt.^2-9.087.*Tt.^3-0.1433.*Tt.^-2)./Tt,Tt3,Tt4,'ArrayValued',true);

%Other calcs
U3=U3a+U3b+U3c+U3d;
U1=U1a+U1b+U1c;

Erat=-U3/U1;
Efficiency=-U3/(U1-Umol*nfuel);

disp('Energy ratio');
disp(Erat);
disp('Efficiency');
disp(Efficiency);
disp('Energy released');
disp(-U3);
disp('Energy used in compression');
disp(U1);
disp('Stage 1 final temp');
disp(T2);
disp('Combustion temperature');
disp(T3);
disp('Exit temperature from piston');
disp(T4);

xlswrite('Piston properties.xlsx',{'Compression ratio' 'Energy ratio' 'Efficiency' 'Energy released J' 'Energy used in compression J','Stage 1 final temp K','Stage 2 final temp K','Stage 3 exhaust temp K'});
xlswrite('Piston properties.xlsx',[CR Erat Efficiency -U3 U1 T2 T3 T4],1,'A2');