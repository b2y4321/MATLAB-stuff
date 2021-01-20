function a=Nacooldivisorcalc()

Tinit=450;
m=120;
Lrod=3.5;
qrod=5e4;
Nrod=1000;
Ac=5;
Drod=0.008;
amat=1.947e-6;%Thermal diffusivity of rod material
n=1000;%How many partitions?

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
xlswrite('Cycleresults.xlsx',{'mass flow rate kg/s' 'Initial coolant temp K' 'q per rod in W' 'N of rods' 'Ac of inlet flow'});
xlswrite('Cycleresults.xlsx',[m Tinit qrod Nrod Ac],1,'A2');
xlswrite('Cycleresults.xlsx',{'Tout of stage' 'Tinf of stage' 'Ts of rods'},1,'A4');
xlswrite('Cycleresults.xlsx',a,1,'A5');



