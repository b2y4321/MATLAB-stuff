function result=stage2(T3,T2,xco2,xn2,xwat,nfuel,Umol)

Urxn=Umol*nfuel;

Tt2=T2/1000;
Tt3=T3/1000;

U1a=1000*xn2.*integral(@(Tt) (27.24+1.007.*Tt+5.139.*Tt.^2-1.89.*Tt.^3+0.00867.*Tt.^-2),Tt2,Tt3,'ArrayValued',true);
U1b=1000*xwat.*integral(@(Tt) (28.82+7.98.*Tt+5.395.*Tt.^2-2.038.*Tt.^3+0.084.*Tt.^-2),Tt2,Tt3,'ArrayValued',true);
U1c=1000*xco2.*integral(@(Tt) (26.6+29.83.*Tt+33.43.*Tt.^2-9.087.*Tt.^3-0.1433.*Tt.^-2),Tt2,Tt3,'ArrayValued',true);

result=Urxn+(U1a+U1b+U1c);
