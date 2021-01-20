function dfdv=hydcombustion(v,f,Tinit)

x=f(1);
T=f(2);

IR=0;%Inerts to feed ratio
PA0=0.66;
v0=1;
CA0=.0832.*Tinit.*PA0;
FA0=v0.*CA0;
Enth=241000;

Tt=T./1000;
CPA=24.47+5..*Tt+.000179.*Tt.^2+.000203.*Tt.^3+.723.*Tt.^-2;
CPB=30.03+8.77.*Tt-3.99.*Tt.^2+0.788.*Tt.^3-0.742.*Tt.^-2;
CPC=41.96+8.622.*Tt-1.5.*Tt.^2+0.0981.*Tt.^3-11.16.*Tt.^-2;
CPI=58.17+2.72.*Tt-0.492.*Tt.^2+0.039.*Tt.^3-6.447.*Tt.^-2;%carbon dioxide

k=1.8e13.*exp(-17614./T);
Ra=(k.*CA0.^1.5).*(1-x).*(0.5-0.5.*x).^.5;
FA=FA0.*(1-x);
FB=FA0.*(0.5-0.5.*x);
FC=FA0.*0.5.*x;
FI=FA0.*IR;

a(1)=(k.*CA0.^1.5./FA0).*(1-x).*(0.5-0.5.*x).^.5;
a(2)=Ra.*Enth./(FA.*CPA+FB.*CPB+FC.*CPC+FI.*CPI);

dfdv=transpose(a);