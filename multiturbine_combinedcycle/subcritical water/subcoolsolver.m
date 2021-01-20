function a=subcoolsolver(T3)
%T2 is the saturation temperature
T2=100;
P2=50;
a=1;
b=1;
vFrac=0.95;%Vapor fraction goal

%Vapor pressure vs temp
P3=10^(5.26-1810.9/(T3-28.5));

%Hvap average from T2 to T3
dPdt=2.302*1810.9*

v2=fsolve(@(v) R*T2/(v-b)-a/(T2^.5*v*(v+b))-P2,1);
v3=fsolve(@(v) R*T2/(v-b)-a/(T2^.5*v*(v+b))-P3,1);

%Enthalpy losses J/mol
Enth1a=100*integral(@(v) R.*T2./(v-b)+a./(2.*T2.^.5.*(v.^2+b.*v))-R.*T3.*v./(v-b).^2+a.*(2.*v.^2+b.*v)./(T2.^.5.*(v.^2+b.*v).^2),v2,v3,'ArrayValued',true);
Enth1b=1000*integral(@(Tf) 29.82+7.98.*Tf+5.39.*Tf.^2-2.03.*Tf.^3+0.084.*Tf.^-2,Tfi,Tff,'ArrayValued',true);

