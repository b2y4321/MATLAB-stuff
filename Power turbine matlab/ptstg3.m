function a=ptstg3(T4,T3,xn2,xo2,xh2o,xco2,P1,P2)

T3t=T3/1000;
T4t=T4/1000;

R=0.0832;
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
a=xn2^2*an2+xo2^2*ao2+xh2o^2*ah2o+2*xn2*xo2*a12+2*xn2*xco2*a13+2*xo2*xco2*a23;
b=xn2*bn2+xo2*bo2+xco2*bco2+xh2o*bh2o;

v1=fsolve(@(v) R*T3/(v-b)-a/(T3^.5*v*(v+b))-P1,1,optimset('Display','off'));
v2=R*T3/P2;

Entr1=100*integral(@(v) R./(v-b)+a./(2.*T3.^1.5.*(v.^2+b.*v)),v1,v2);

Entr2a=xn2*integral(@(T) (28.24+1.007.*T+5.14.*T.^2-1.89.*T.^3+0.0087.*T.^-2)./T,T3t,T4t,'ArrayValued',true);
%of N2
Entr2b=xo2*integral(@(T) (25.49+14.17.*T-5.84.*T.^2+0.896.*T.^3+0.0252.*T.^-2)./T,T3t,T4t,'ArrayValued',true);
%of O2
Entr2c=xco2*integral(@(T) (27.60+29.83.*T+33.43.*T.^2-9.087.*T.^3-0.1433.*T.^-2)./T,T3t,T4t,'ArrayValued',true);
%of CO2
Entr2d=xh2o*integral(@(T) (29.82+7.98.*T+5.396.*T.^2-2.038.*T.^3+0.084.*T.^-2)./T,T3t,T4t,'ArrayValued',true);
%of water

a=Entr1+Entr2a+Entr2b+Entr2c+Entr2d;
