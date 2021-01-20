function a=spacedropsolve

D=.21;%Diameter
u=1.8e-5;%Viscosity of air
mveh=22.7;%mass of vehicle
Ac=pi*(D/2)^2;%Cross section area
g=9.8;%gravity
dist_init=10000;%Initial drop distance

%If thrusted:
Ft=0;%Force the thruster produces
Isp=220;%Spec impulse of thruster
m0fuel=0;%initial mass of fuel loaded

%Calculations begin
mrate=Ft/(g*Isp);
m0=mveh+m0fuel;

[t,v]=ode15s(@(t,v) spacedrop(t,v,D,u,Ac,g,Ft,mrate,mveh),[0 10000],[1 dist_init m0],odeset('Events',@event_functions,'MaxStep',1));

vel=v(:,1);
x=v(:,2);
p=1.29.*0.1.^(x./15100);

Re=p.*vel.*D./u;

xlswrite('spacedrop.xlsx',[t,v,Re]);