function a=ccyclesolve()

T1=673;
P1=100;

a=142.88;
b=.02114;
R=8.314;


T2=fsolve(@(T2) ccycleimpr(T2,T1,P1),500);
P2=(1/760)*10^(8.14-1810.94/(T2-28.52));

v1=fsolve(@(v) R*T1/(v-b)-a/(T1^.5*v*(v+b))-P1,1);
v2=R*T1/P2;

Tt1=T1/1000;
Tt2=T2/1000;

Enth1=integral(@(v) R.*T1./(v-b)+a./(2.*T1.^1.5.*(v.^2.*b.*v))-R.*T1.*v./(v-b).^2+a.*(2.*v.^2+b.*v)./(T1.^.5.*(v.^2+b.*v).^2),v1,v2);
Enth2=1000*integral(@(T) (30.09+6.832.*T+6.793.*T.^2-2.534.*T.^3+0.0821.*T.^-2),Tt1,Tt2);

disp('Enthalpy');
disp(Enth1+Enth2);
disp('Final Temperature');
disp(T2);
disp('Final pressure');
disp(P2);


