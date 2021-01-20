function a=Naturbine(T2,T1,P1)

R=8.314;
Tt1=T1/1000;
Tt2=T2/1000;

Hliq=1000*integral(@(T) 40.25-28.23.*T+20.69.*T.^2-3.641.*T.^3-0.079.*T.^-2,1.156,Tt2,'ArrayValued',true);
Hgas=1000*integral(@(T) 20.8-0.277.*T-0.392.*T.^2+0.120.*T.^3-0.0089.*T.^-2,1.156,Tt2,'ArrayValued',true);
Hvapnew=97420-Hliq+Hgas;
P2=0.1*exp(-(Hvapnew/8.314)*(1/T2-1/946));

v1=R*T1/P1;
v2=R*T1/P2;


Entr1=8.314*log(v2/v1);
Entr2=integral(@(T) (20.8-0.277.*T-0.392.*T.^2+0.120.*T.^3-0.0089.*T.^-2)./T,Tt1,Tt2,'ArrayValued',true);

a=Entr1+Entr2;