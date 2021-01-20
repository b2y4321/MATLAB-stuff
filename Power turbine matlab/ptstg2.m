function a=ptstg2(T3,T2,xn2,xo2,xh2o,xco2,xch4)

Enthrxn_298=-870000;

Trt=T2/1000;
T2t=T2/1000;
T3t=T3/1000;
%New enthalpy calcs
Enthr1=-2*integral(@(T) (25.49+14.17.*T-5.84.*T.^2+0.896.*T.^3+0.0252.*T.^-2),0.298,Trt,'ArrayValued',true);
%of O2
Enthr2=-integral(@(T) (-0.82+109.19.*T-43.73.*T.^2+6.451.*T.^3+0.679.*T.^-2),0.298,Trt,'ArrayValued',true);
%of CH4

Enthp1=integral(@(T) (27.60+29.83.*T+33.43.*T.^2-9.087.*T.^3-0.1433.*T.^-2),0.298,Trt,'ArrayValued',true);
%of CO2
Enthp2=2*integral(@(T) (29.82+7.98.*T+5.396.*T.^2-2.038.*T.^3+0.084.*T.^-2),0.298,Trt,'ArrayValued',true);
%of Water
Enthadj=Enthp1+Enthp2+Enthr1+Enthr2;
Enthalpymol=Enthrxn_298+1000*Enthadj;
Enthalpyfinal=Enthalpymol*xch4;
%end

%Temp calcs
heat1=1000*integral(@(T) (28.24+1.007.*T+5.14.*T.^2-1.89.*T.^3+0.0087.*T.^-2),T2t,T3t,'ArrayValued',true);
%of N2
heat2=1000*integral(@(T) (25.49+14.17.*T-5.84.*T.^2+0.896.*T.^3+0.0252.*T.^-2),T2t,T3t,'ArrayValued',true);
%of O2
heat3=1000*integral(@(T) (27.60+29.83.*T+33.43.*T.^2-9.087.*T.^3-0.1433.*T.^-2),T2t,T3t,'ArrayValued',true);
%of CO2
heat4=1000*integral(@(T) (29.82+7.98.*T+5.396.*T.^2-2.038.*T.^3+0.084.*T.^-2),T2t,T3t,'ArrayValued',true);
%of water

a=xn2*heat1+xo2*heat2+xco2*heat3+xh2o*heat4+Enthalpyfinal;



