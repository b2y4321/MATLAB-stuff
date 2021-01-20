function a=Naturbinesolver()

T1=1700;
P1=2;
Ngas=1.5;

T3=fsolve('Naturbine_tsolver',1200);

T2=fsolve(@(T2) Naturbine(T2,T1,P1),1500);
P2=Naturbine_psolver(T2);

disp('Turbine outlet temperature');
disp(T2);
disp('Turbine outlet pressure');
disp(P2);

Tt1=T1/1000;
Tt2=T2/1000;
Tt3=T3/1000;
Enth=1000*integral(@(T) (20.8-0.277.*T-0.392.*T.^2+0.120.*T.^3-0.0089.*T.^-2),Tt1,Tt2,'ArrayValued',true);

%Energy required to heat Na
%Hvap adjustments
Hliq=1000*integral(@(T) 40.25-28.23.*T+20.69.*T.^2-3.641.*T.^3-0.079.*T.^-2,1.156,Tt3,'ArrayValued',true);
Hgas=1000*integral(@(T) 20.8-0.277.*T-0.392.*T.^2+0.120.*T.^3-0.0089.*T.^-2,1.156,Tt3,'ArrayValued',true);

Hheat1=1000*integral(@(T) 40.25-28.23.*T+20.69.*T.^2-3.641.*T.^3-0.079.*T.^-2,1.156,Tt3,'ArrayValued',true);
%Heating liquid to boiling point
Hheat2=97420-Hliq+Hgas;%boiling Na
Hheat3=1000*integral(@(T) 20.8-0.277.*T-0.392.*T.^2+0.120.*T.^3-0.0089.*T.^-2,Tt3,Tt1,'ArrayValued',true);
Hheat=Hheat1+Hheat2+Hheat3;

%Energy duty of cooling Na after cycle
%More hvap adjustments
Hliq1=1000*integral(@(T) 40.25-28.23.*T+20.69.*T.^2-3.641.*T.^3-0.079.*T.^-2,1.156,Tt2,'ArrayValued',true);
Hgas1=1000*integral(@(T) 20.8-0.277.*T-0.392.*T.^2+0.120.*T.^3-0.0089.*T.^-2,1.156,Tt2,'ArrayValued',true);
Hheatcool=Ngas*(97420-Hliq1+Hgas1);%boiling Na

%Efficiency
Efficiency=-Enth/Hheat;

%Energy produced/vented
disp('Turbine shaft work');
disp(-Ngas*Enth);%Enthalpy released by turbine
disp('Cooling duty');
disp(Hheatcool);%Enthalpy released in cooling
disp('Heating duty');
disp(Ngas*Hheat);%Enthalpy used in heating
disp('Efficiency');
disp(Efficiency);