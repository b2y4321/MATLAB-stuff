function a=ptstg1(T2,T1,xn2,xch4,xo2,P1,P2)

R=0.0832;
an2=15.61;
ao2=17.36;
ach4=32.19;
bn2=0.02683;
bo2=0.02197;
bch4=0.02969;

a12=sqrt(an2*ao2);
a23=sqrt(ao2*ach4);
a13=sqrt(an2*ach4);
a=xn2^2*an2+xo2^2*ao2+xch4^2*ach4+2*xn2*xo2*a12+2*xn2*xch4*a13+2*xo2*xch4*a23;
b=xn2*bn2+xo2*bo2+xch4*bch4;

T1t=T1/1000;
T2t=T2/1000;

%Entropy heat
Entr1a=integral(@(T) xn2.*(28.24+1.007.*T+5.14.*T.^2-1.89.*T.^3+0.0087.*T.^-2)./T,T1t,T2t,'ArrayValued',true);
%of N2
Entr1b=integral(@(T) xo2.*(25.49+14.17.*T-5.84.*T.^2+0.896.*T.^3+0.0252.*T.^-2)./T,T1t,T2t,'ArrayValued',true);
%of O2

Entr1c=integral(@(T) xch4.*(-0.82+109.19.*T-43.73.*T.^2+6.451.*T.^3+0.679.*T.^-2)./T,T1t,T2t,'ArrayValued',true);
%of CH4

%Entropy of compression
v1=0.0832*T2/P1;
v2=fsolve(@(v) (R.*T2./(v-b)-a./(T2.^.5.*v.*(v+b)))-P2,1,optimset('Display','off'));
Entr2=100*integral(@(v) (-0.0832./(v-b).^2+a./(2.*T2.^1.5.*(v.^2+b.*v))),v1,v2,'ArrayValued',true);
a=Entr1a+Entr1b+Entr1c-Entr2;


