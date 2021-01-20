function a=Nacooldivisorcalc()

Tinit=450;
m=100;
Lrod=3.5;
qrod=1e5;
Nrod=1000;
Ac=5;
Drod=0.008;
amat=1.947e-6;%Thermal diffusivity of rod material
n=100;%How many partitions?

Tin=Tinit;

Touts=[];
Tinfs=[];
Tss=[];
hforceds=[];
hfrees=[];
hs=[];
for i=1:n
    Nrodincr=Nrod/n;
    
    outpt=Nacooldivisor(Nrodincr,Lrod,qrod,Tin,m,Ac,Drod,amat);
    Tout=outpt(1);
    Tinf=outpt(2);
    Ts=outpt(3);
    hforced=outpt(4);
    hfree=outpt(5);
    h=outpt(6);
    
    Touts=[Touts; Tout;];
    Tinfs=[Tinfs; Tinf;];
    Tss=[Tss; Ts;];
    hforceds=[hforceds; hforced;];
    hfrees=[hfrees; hfree;];
    hs=[hs; h;];
    
    Tin=Tout;
end

a=[Touts Tinfs Tss];
xlswrite('Cycleresults.xlsx',{'Tout of stage' 'Tinf of stage' 'Ts of rods'});
xlswrite('Cycleresults.xlsx',a,1,'A2');



