function a=adiabatic_totalsolve()

T1=298;
P1=1;
P2=100;

Tfin=fsolve(@(T2) adiabatic_total(T2,T1,P1,P2),1000,optimset('Disp','off'));


R=0.0832;
a=15.86;
b=0.02533;

v1=R.*Tfin./P1;
v2=fsolve(@(v) (R.*Tfin./(v-b)-a./(Tfin.^0.5.*v.*(v+b)))-P2,1);

h1=integral(@(T) 8.314.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^2),T1,Tfin,'ArrayValued',true);
h2=100.*integral(@(v) (R.*Tfin./(v-b)+a.*Tfin./(2.*Tfin.^1.5.*v.*(v+b))-(R.*Tfin.*v./(v-b).^2-a.*(2.*v+b)./(Tfin.^.5.*(v.^2+b.*v).^2))),v1,v2);
htot=(h1+h2)/1000;

disp('Tfin');
disp(Tfin);
disp('Enthalpy KJ/mol');
disp(htot);
