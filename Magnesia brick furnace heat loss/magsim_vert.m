function a=magsim_vert(T,Tinf,T0,L,L1,L2,k1,k2)
ems=0.4;

T1=T(1);
T2=T(2);

%Convection coeff calculation
Tf=(T2+Tinf)/2;
B=1/Tf;

pkin=[7.16E-11	5.59E-08	-6.36E-06];
palpha=[9.73E-11	8.09E-08	-8.63E-06];
pk3=[2.92E-11	-7.83E-08	0.000118275	-0.002477125];

kin=polyval(pkin,Tf);
alpha=polyval(palpha,Tf);
k3=polyval(pk3,Tf);

Ra=9.8*B*(T2-Tinf)*L^3/(kin*alpha);
Nu=(0.825+0.325*Ra^(1/6))^2;
h=Nu*k3/L;

disp(h);
%Eqns
a(1)=k1*(T0-T1)/L1-k2*(T1-T2)/L2;
a(2)=h*(T2-Tinf)+(5.67e-8)*ems*(T2^4-Tinf^4)-k2*(T1-T2)/L2;


