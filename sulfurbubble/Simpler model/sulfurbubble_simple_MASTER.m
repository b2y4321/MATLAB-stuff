timefin=100;%in seconds. Will terminate once t>tfin or radius becomes zero.
timestep=.05;

N=20;
Da=1.86e-9;
R=1e-6;
Rfin=25e-6;
Ca0=3.87;
Cb0=6.8;
k=100;
Vgas=.0224;%molar volume of gas, whatever it is

t=0;
R0=R;
Concs=[];
Radii=[];
Vs=[];
exitstats=[];
Vel=0;

while(t<=timefin)
Radii=[Radii; R;];
Vs=[Vs; Vel;];

h=(R/R0)*(Rfin-R)/(N+1);

[C1calc,~,exitstat,~]=fsolve(@(C1) sulfurbubble_simple_solve(C1,N,Da,R,Rfin,Ca0,Cb0,k,Vgas),Ca0);
PartSoln=sulfurbubble_simple_eval(C1calc,N,Da,R,Rfin,Ca0,Cb0,k,Vgas);
PartSoln=PartSoln(:,N+3);


%We reduce by some radius
Vel=(Da/h^2)*(4*pi*R^2)*(Ca0-C1calc);
R=R-Vel*timestep;

%Concentration noting
Concs=horzcat(Concs,PartSoln);

exitstats=[exitstats; exitstat;];
if(R<=0)
   break; 
end

t=t+timestep;
end

%Creation of time vector
tfin_actual=timestep*(size(Concs,2)-1);
ts=linspace(0,tfin_actual,size(Concs,2));

xlswrite('Concprofile vs time.xlsx',{'Time'; 'Concentrations'},1,'A1');
xlswrite('Concprofile vs time.xlsx',ts,1,'B1');
xlswrite('Concprofile vs time.xlsx',Concs,1,'B2');

xlswrite('Concprofile vs time.xlsx',{'Time' 'Bubble radius'},2,'A1');
xlswrite('Concprofile vs time.xlsx',[transpose(ts) Radii],2,'A2');

xlswrite('Concprofile vs time.xlsx',{'Time' 'Velocity'},3,'A1');
xlswrite('Concprofile vs time.xlsx',[transpose(ts) Vs],3,'A2');

xlswrite('Concprofile vs time.xlsx',exitstats,4,'A1');
