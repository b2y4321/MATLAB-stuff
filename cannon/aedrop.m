function dxdt=aedrop(t,x,D,visc,m,A)

P=x(1);
vx=x(2);
vy=x(3);

b=atan(vy/vx);

v=(vx^2+vy^2)^.5;
dens=1.29*0.1^(P/15100);
Re=dens*v*D/visc;
if(Re<=1e5)
    Cd=0.44;
elseif(Re>1e5 && Re<=3.5e5)
    Cd=0.32;
elseif(Re>3.5e5 && Re<=1e6)
    Cd=0.1;
else
    Cd=0.2;
end


    vertical=-sin(b)*(1.29/(2*m))*Cd*A*vy^2*(0.1)^(P/15100)-9.8*cos(b);
    horizontal=-(1.29/(2*m))*Cd*A*vx^2*cos(b)*(0.1)^(P/15100)-9.8*sin(b);



a(1)=vy; %Position
a(2)=horizontal;%Vx
a(3)=vertical;%Vy

dxdt=transpose(a);