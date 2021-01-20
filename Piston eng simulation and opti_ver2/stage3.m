function result=stage3(T4,T3,xn2_2,xwat_2,xco2_2,v3,v4)

R=0.0832;

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

Tt3=T3/1000;
Tt4=T4/1000;

Entr1=100*integral(@(v) R./(v-b)+a./(2.*T3.^1.5.*(v.^2+b.*v)),v3,v4,'ArrayValued',true);
Entr2a=y1.*integral(@(Tt) (27.24+1.007.*Tt+5.139.*Tt.^2-1.89.*Tt.^3+0.00867.*Tt.^-2)./Tt,Tt3,Tt4,'ArrayValued',true);
Entr2b=y2.*integral(@(Tt) (28.82+7.98.*Tt+5.395.*Tt.^2-2.038.*Tt.^3+0.084.*Tt.^-2)./Tt,Tt3,Tt4,'ArrayValued',true);
Entr2c=y3.*integral(@(Tt) (26.6+29.83.*Tt+33.43.*Tt.^2-9.087.*Tt.^3-0.1433.*Tt.^-2)./Tt,Tt3,Tt4,'ArrayValued',true);

result=Entr1+Entr2a+Entr2b+Entr2c;


