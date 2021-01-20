function a=ptstgsolver()

Pentry=1;
Pcomp=65;
n=0.3;%Mol/s of inlet gas
R=0.0832;
Enthrxn_298=870000;
Ac=.01;%Cross sectional area of combustor

%Compression stage characteristics
T1=298;
xn2_1=0.751;
xch4_1=0.0498;
xo2_1=0.2;
P1=Pentry;
P2=Pcomp;

%Combustion stage characteristics
xn2_2=.751;
xo2_2=.1;
xh2o_2=.0976;
xco2_2=.0498;
xch4_precombust=0.0498;

%Exit stage characteristics
xn2_3=.751;
xo2_3=.1;
xh2o_3=.0976;
xco2_3=.0498;
P3=Pcomp;
P4=Pentry;

T2=fsolve(@(T2) ptstg1(T2,T1,xn2_1,xch4_1,xo2_1,P1,P2),1000);
T3=fsolve(@(T3) ptstg2(T3,T2,xn2_2,xo2_2,xh2o_2,xco2_2,xch4_precombust),1000);
T4=fsolve(@(T4) ptstg3(T4,T3,xn2_3,xo2_3,xh2o_3,xco2_3,P3,P4),1000);


T1t=T1/1000;
T2t=T2/1000;
T3t=T3/1000;
T4t=T4/1000;

%Stage number 1
Enth1a=1000*integral(@(T) xn2_1.*(28.24+1.007.*T+5.14.*T.^2-1.89.*T.^3+0.0087.*T.^-2)./T,T1t,T2t,'ArrayValued',true);
%of N2
Enth1b=1000*integral(@(T) xo2_1.*(25.49+14.17.*T-5.84.*T.^2+0.896.*T.^3+0.0252.*T.^-2)./T,T1t,T2t,'ArrayValued',true);
%of O2
Enth1c=1000*integral(@(T) xch4_1.*(-0.82+109.19.*T-43.73.*T.^2+6.451.*T.^3+0.679.*T.^-2)./T,T1t,T2t,'ArrayValued',true);
%of CH4

an2=15.61;
ao2=17.36;
ach4=32.19;
bn2=0.02683;
bo2=0.02197;
bch4=0.02969;

a12=sqrt(an2*ao2);
a23=sqrt(ao2*ach4);
a13=sqrt(an2*ach4);
a=xn2_1^2*an2+xo2_1^2*ao2+xch4_1^2*ach4+2*xn2_1*xo2_1*a12+2*xn2_1*xch4_1*a13+2*xo2_1*xch4_1*a23;
b=xn2_1*bn2+xo2_1*bo2+xch4_1*bch4;

v1a=0.0832*T2/P1;
v1b=fsolve(@(v) (R.*T2./(v-b)-a./(T2.^.5.*v.*(v+b)))-P2,1,optimset('Display','off'));

Enth1d=100*integral(@(v) R.*T2./(v-b)+a./(2.*T2.^.5.*(v.^2+b.*v))-R.*T2.*v./(v-b).^2+a.*(2.*v.^2+b.*v)./(T2.^.5.*(v.^2+b.*v).^2),v1a,v1b,'ArrayValued',true);
%Stage number 2 characteristics
v2a=v1b;
v2b=fsolve(@(v) (R.*T3./(v-b)-a./(T3.^.5.*v.*(v+b)))-P2,1,optimset('Display','off'));
velocity2a=n*v2a/Ac;
velocity2b=n*v2b/Ac;

%Stage number 3

an2=15.61;
ao2=17.36;
ah2o=142.88;
bn2=0.02683;
bo2=0.02197;
bco2=0.02967;
bh2o=0.02114;

a12=sqrt(an2*ao2);
a23=sqrt(ao2*ah2o);
a13=sqrt(an2*ah2o);
a=xn2_3^2*an2+xo2_3^2*ao2+xh2o_3^2*ah2o+2*xn2_3*xo2_3*a12+2*xn2_3*xco2_3*a13+2*xo2_3*xco2_3*a23;
b=xn2_3*bn2+xo2_3*bo2+xco2_3*bco2+xh2o_3*bh2o;

v3a=fsolve(@(v) R*T3/(v-b)-a/(T3^.5*v*(v+b))-P3,1,optimset('Display','off'));
v3b=R*T3/P4;

Enth3a=100*integral(@(v) R.*T3./(v-b)+a./(2.*T3.^.5.*(v.^2+b.*v))-R.*T3.*v./(v-b).^2+a.*(2.*v.^2+b.*v)./(T3.^.5.*(v.^2+b.*v).^2),v3a,v3b,'ArrayValued',true);

Enth3b=xn2_3*1000*integral(@(T) (28.24+1.007.*T+5.14.*T.^2-1.89.*T.^3+0.0087.*T.^-2),T3t,T4t,'ArrayValued',true);
%of N2
Enth3c=xo2_3*1000*integral(@(T) (25.49+14.17.*T-5.84.*T.^2+0.896.*T.^3+0.0252.*T.^-2),T3t,T4t,'ArrayValued',true);
%of O2
Enth3d=xco2_3*1000*integral(@(T) (27.60+29.83.*T+33.43.*T.^2-9.087.*T.^3-0.1433.*T.^-2),T3t,T4t,'ArrayValued',true);
%of CO2
Enth3e=xh2o_3*1000*integral(@(T) (29.82+7.98.*T+5.396.*T.^2-2.038.*T.^3+0.084.*T.^-2),T3t,T4t,'ArrayValued',true);

Enth1=n*(Enth1a+Enth1b+Enth1c+Enth1d);
Enth3=n*(Enth3a+Enth3b+Enth3c+Enth3d+Enth3e);

Efficiency=(-Enth1-Enth3)/(n*Enthrxn_298*xch4_precombust);

disp('Stage 1 exit temp');
disp(T2);
disp('Stage 2 exit temp');
disp(T3);
disp('Exhaust/stage3 exit temp');
disp(T4);
disp('Enthalpy stage 1');
disp(Enth1);
disp('Enthalpy stage 3');
disp(Enth3);
disp('Net power production');
disp(-(Enth3+Enth1));
disp('Efficiency');
disp(Efficiency);
disp('Energy Ratio');
disp(-Enth3/Enth1);
disp('Combustor entry velocity');
disp(velocity2a);
disp('Combustor exit velocity');
disp(velocity2b);

xlswrite('report.xlsx',{'Stage 1 exit temp' 'Stage 2 exit temp' 'Exhaust/stage3 exit temp' 'Enthalpy stage 1' 'Enthalpy stage 3' 'Net power production' 'Efficiency' 'Energy Ratio' 'Combustor entry velocity' 'Combustor exit velocity'});
xlswrite('report.xlsx',[T2 T3 T4 Enth1 Enth3 -(Enth3+Enth1) Efficiency -Enth3/Enth1 velocity2a velocity2b],1,'A2');