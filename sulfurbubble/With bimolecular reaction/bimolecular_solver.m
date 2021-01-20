%Initially, we have the following
V=0;
Da=1e-4;
Db=1e-4;
R=0.001;
Rout=0.01;
k=10;
Ca0=0.05;
Cbinf=0.5;
N=5;

%Initcond stuff
inita=linspace(Ca0,Ca0,N);
initb=linspace(Cbinf,Cbinf,N);
initcond=horzcat(inita,initb);

%concfins=bimolecular(initcond,N,V,Da,Db,R,Rout,k,Ca0,Cbinf); %This is to test it!
concfins=fsolve(@(arr) bimolecular(arr,N,V,Da,Db,R,Rout,k,Ca0,Cbinf),initcond);