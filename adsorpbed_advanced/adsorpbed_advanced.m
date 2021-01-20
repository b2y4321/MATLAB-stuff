
%Inlet conditions
Tin=298;
R=8.314;
Pinit=[0.42 0.79*2];%Initial pressure bar
Cinit=101325.*Pinit./(R.*Tin);
pin=1.29;%Inlet density kg/m3
vin=0.5;%Inlet velocity m/s
Ac=0.01;%Cross sectional area of inlet
pbed=1500;%in kg/m3

%Other params
n=2;%Number of species
Dparticle=20e-6;
nparticle=1e5;
tfin=10;%Number of secs to calculate to
L=1;%Length of reactor

L0=L;
%for i=1..n diffusivities
D=[9.92e-5 1.5e-4
    1.5e-4 5e-4];
%put them in this form:
%D=[D11 D12 D13
%   D21 D22 D23
%   D31 D32 D33]

%Competitive adsorption coefficients for species i=1..n, from 0 to 1
Z=[0.2 0.6];

u=[8.9e-4 8.9e-4];%u1,u2,etc for 1..n viscosities im Pa-s
M=[32 28];%Molar masses of comps 1..n as kg/mol
kads=[10 25];%Adsorption coeffs mol/kg sorbent

%Calculation time!
Couts=[];
vouts=[];
Ls=[];
Scs=[];
Res=[];
ptotals=[];
Kms=[];
utotals=[];

for i=1:tfin
    [x,c]=ode15s(@(x,c) cprofilesolver(x,c,pin,vin,n,Dparticle,nparticle,D,Z,u,M),[0 L],Cinit);
    cfin=c(size(c,1),:);
    
    %Bed depletion calculations
    ptotalfin=sum((cfin.*M));
    vout=pin*vin/ptotalfin;%velocity
    
    delC=Cinit-cfin;
    delN=Ac.*vin.*Cinit-Ac.*vout.*cfin;
    L=L-L0.*sum(delN.*Z./(kads.*pbed.*Ac));
    
    %Other calculations for outlet properties
    ctotalfin=sum(cfin);
    
    %Diffusivity mean calculation of each component, AT OUTLET
    Diffstotal=[];
    for j=1:n
        Dcol=D(j,:);%Scrape out the row
        diffus=(sum((cfin./ctotalfin)./Dcol)).^-1;%Diffusivity of i in the mixture    
        Diffstotal=[Diffstotal; diffus;];
    end
    Diffstotal=transpose(Diffstotal);
    
    %Outlet viscosity, density, Schmidt, Reynolds, mass transfer coeff AT OUTLET
    utotal=sum((cfin./ctotalfin).*u);
    ptotal=sum((cfin.*M));%Total density of system
    Sc=utotal./(ptotal.*Diffstotal);%Schmidt number of system
    Re=ptotal*vout*Dparticle/utotal;
    Km=(Diffstotal./Dparticle).*(2+(0.4.*Re^0.5+0.06.*Re.^(2/3)).*Sc.^0.4);%Mass tf coeff vector
    
    %Writing data
    Couts=vertcat(Couts,cfin);
    vouts=[vouts; vout;];
    Ls=[Ls; L;];
    Scs=[Scs; Sc;];
    Res=[Res; Re;];
    ptotals=[ptotals; ptotal;];
    Kms=vertcat(Kms,Km);
    utotals=[utotals; utotal;];
    
    %Rewriting params for next iteration
    Cinit=cfin;
end

xlswrite('concprofiles.xlsx',{'Vout m/s','Usable bed length m','Re','Density of system kg/m3','Gas viscosity','Schmidt number of species i','Final concentrations mol/m3','Mass transf coefficients'});
xlswrite('concprofiles.xlsx',[vouts Ls Res ptotals utotals Scs Couts Kms],1,'A2');





