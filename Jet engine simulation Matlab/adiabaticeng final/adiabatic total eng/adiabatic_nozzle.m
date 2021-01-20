function a=adiabatic_nozzle(Tcf,Tcini,P1,P2)

R=0.0832;
a=28.23;
b=0.02646;


v2=R.*Tcini./P2;
v1=fsolve(@(v) (R.*Tcini./(v-b)-a./(Tcini.^.5.*v.*(v+b)))-P1,1,optimset('Disp','off'));

s1=100.*integral(@(v) (R./(v-b)+a./(2.*Tcf.^1.5.*v.*(v+b))),v1,v2,'ArrayValued',true);
s2=integral(@(T) 8.314./T.*(3.355+(5.75e-4).*T-(1.6e-7).*T.^-2),Tcini,Tcf,'ArrayValued',true);


a=s1+s2;