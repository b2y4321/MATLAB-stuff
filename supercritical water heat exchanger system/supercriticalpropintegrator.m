function a=supercriticalpropintegrator()

Tstart=647;
Tend=873;

par=xlsread('Water supercritical props refined.xlsx','A2:E455');
T=par(:,1);
dens=par(:,2);
Cp=par(:,3);
vis=par(:,4);
k=par(:,5);

densinteg=0;
Cpinteg=0;
visinteg=0;
kinteg=0;

for i=1:(Tend-Tstart)
    densinteg=densinteg+(dens(i+1)+dens(i))/2;
    Cpinteg=Cpinteg+(Cp(i+1)+Cp(i))/2;
    visinteg=visinteg+(vis(i+1)+vis(i))/2;
    kinteg=kinteg+(k(i+1)+k(i))/2;
end
densavg=densinteg/(Tend-Tstart);
Cpavg=Cpinteg/(Tend-Tstart);
visavg=visinteg/(Tend-Tstart);
kavg=kinteg/(Tend-Tstart);

xlswrite('scprops.xlsx',{'Avg density' 'Avg Cp' 'Avg viscosity' 'Avg k'});
xlswrite('scprops.xlsx',[densavg Cpavg visavg kavg],1,'A2');







