
Tb=150;
Tinf=50;
L=0.1;
b=0.001;
vel=0;

Ttip=fsolve(@(Ttip) singlefinwater(Ttip,Tb,Tinf,L,b,vel),100);

%Heat transf calcs
Tf1=(Ttip+Tb)/2;
Tf2=(Tf1+Tinf)/2;
pdens=[-0.003337707	0.003181559	995.9648755];
pexp=[8.57E-13	-2.72E-10	2.22E-08	6.32E-06	0.000131754];

expans=polyval(pexp,Tf2);
dens=polyval(pdens,Tf2);
pk=[-5.63E-06	0.001608262	0.571700375];

k=polyval(pk,Tf2);
u=0.00126*exp(-0.03531*Tf2)+0.0004699*exp(-0.006736*Tf2);
kin=u/dens;
alpha=k/(dens*4180);

%Re number calc
Re=dens*vel*L/u;

Ra=9.8*expans*(Tf1-Tinf)*L^3/(kin*alpha);
Nu1=(0.825+0.3323*Ra^(1/6))^2;
Nu2=0.0296*Re^0.8;
Nu=Nu1+Nu2;
h=Nu*k/L;

%Other calcs
m=(2*h/k*b)^.5;

%Final calcs
q=k*(Tb-Tinf)*m*tanh(m*L);
