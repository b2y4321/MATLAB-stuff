%Time and timing parameters
tfin=100;
tincr=1;

%Initially, we have the following
V=0;
Vgas=0.0224;
Da=1e-9;
Db=1e-9;
R=1e-4;
Rout=10*R;
k=10;
Ca0=0.05;
Cbinf=0.5;
N=5;

%Initcond stuff
R0=R;
inita=linspace(Ca0/2,Ca0/2,N);
initb=linspace(Cbinf/2,Cbinf/2,N);
initcond=horzcat(inita,initb);

t=0;

Concs=[];
Rs=[];
Vs=[];
ts=[];
exitconds=[];

while(t<=tfin)

[FDconc,~,exitcond,~]=fsolve(@(arr) bimolecular(arr,N,V,Da,Db,R,Rout,k,Ca0,Cbinf),initcond);
exitconds=[exitconds; exitcond;];


%Recauculating velocity
Cp1=FDconc(1);%Concentration at node 1
h=(Rout-R)/(N+1);
V=-Da*((Cp1-Ca0)/h)/(Vgas);%Recauculate velocity based on previous parameters!

%Recauculating radius
R=R-V*tincr;
Rout=Rout*(R/R0);

Rs=[Rs; R;];
Vs=[Vs; V;];
Concs=horzcat(Concs,transpose(FDconc));
ts=[ts; t;];

if(R<0)
   break; 
end



t=t+tincr;
end

