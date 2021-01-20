function result=stage1(T2,T1,P1,CR)

R=0.0832;

xn2=0.79;
xo2=0.21;

a1=15.61;
a2=17.37;

b1=0.02683;
b2=0.02197;

b=xn2*b1+xo2*b2;
a=xn2^2*a1+xn2*xo2*(a1*a2)^.5+xo2^2*a2;

v1=R.*T1/P1;
%v2=fsolve(@(v) R*T2/(v-b)-a/(T2^.5*v*(v+b))-P2,1);
v2=v1/CR;
Tt1=T1/1000;
Tt2=T2/1000;

Entr1a=xn2.*integral(@(Tt) (27.24+1.007.*Tt+5.139.*Tt.^2-1.89.*Tt.^3+0.00867.*Tt.^-2)./Tt,Tt1,Tt2,'ArrayValued',true);
Entr1b=xo2.*integral(@(Tt) (24.49+14.17.*Tt-5.845.*Tt.^2+0.896.*Tt.^3+0.02522.*Tt.^-2)./Tt,Tt1,Tt2,'ArrayValued',true);
Entr2=100*integral(@(v) R./(v-b)+a./(2.*T2.^1.5.*v.*(v+b)),v1,v2,'ArrayValued',true);

result=Entr1a+Entr1b+Entr2;
