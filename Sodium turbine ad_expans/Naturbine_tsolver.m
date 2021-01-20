function a=Naturbine_tsolver(T)

Pgoal=1.8801;
Tt1=T/1000;
Hliq=1000*integral(@(T) 40.25-28.23.*T+20.69.*T.^2-3.641.*T.^3-0.079.*T.^-2,1.156,Tt1,'ArrayValued',true);
Hgas=1000*integral(@(T) 20.8-0.277.*T-0.392.*T.^2+0.120.*T.^3-0.0089.*T.^-2,1.156,Tt1,'ArrayValued',true);

Hvapnew=97420-Hliq+Hgas;

Pnew=0.1*exp(-(Hvapnew/8.314)*(1/T-1/946));

a=Pnew-Pgoal;