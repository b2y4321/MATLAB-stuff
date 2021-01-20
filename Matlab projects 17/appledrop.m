function dvdt=appledrop(t,v)
g=9.8;
p=1.29; %Density in kg/m3
A=9.50e-3; %Area in m2

RedV=4521;
aa(1)=g-(p.*A./2).*v(1).^2.*((24./RedV).^0.5.*v(1).^0.5+0.5407).^2;
aa(2)=v(1);
dvdt=transpose(aa);