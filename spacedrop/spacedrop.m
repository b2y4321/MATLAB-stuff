function dvdt=spacedrop(t,v,D,u,Ac,g,Ft,mrate,mveh)

vel=v(1);
x=v(2);
m=v(3);

if(x>=5e5)
    p=1e-30;
else
    p=1.29*0.1^(x/15100);
end

Re=p*vel*D/u;
Cd=(24/Re)+((2.6*(Re/5))/(1+(Re/5)^1.52))+(0.411*(Re/2.63e5)^-7.94/(1+(Re/2.63e5)^-8))+0.25*(Re/1e6)/(1+Re/1e6);

a(1)=-(p/(2*m))*Cd*vel^2*Ac+g+Ft/m;
a(2)=-vel;
a(3)=-mrate*heaviside(m-mveh);

dvdt=transpose(a);