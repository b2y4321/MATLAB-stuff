function a=aedropsolve()

v0=10000;
b0=pi/4-.01;
D=0.1;
m=100;
visc=1.81e-5;
A=0.0314;

vx=v0*cos(b0);
vy=v0*sin(b0);

[t,x]=ode15s(@(t,x) aedrop(t,x,D,visc,m,A),[0 10000],[1 vx vy]);

a=[t,x];

xlswrite('posdata.xlsx',[t,x]);