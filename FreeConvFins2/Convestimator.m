
L=0.008;
w=0.002;
Tst=25;
Tend=125;

hs=[];
Ts=[];
for i=Tst:Tend
T=i;

Dh=L*w/(2*L+2*w);
pk=[2.92E-11 -7.83E-08 0.000118275 -0.002477125];	
k=polyval(pk,(T+273));

h=3.66*k/Dh;
Ts=[Ts; T;];
hs=[hs; h;];
end