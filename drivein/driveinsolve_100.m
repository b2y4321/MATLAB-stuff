
ncutoff=5;
n=100;

initval=[];

for i=1:ncutoff
   initval=horzcat(initval,1);
end

for i=(ncutoff+1):(n+2)
   initval=horzcat(initval,0);
end

[t,c]=ode15s(@(t,c) drivein(t,c,n),[0 1],initval,odeset('MaxStep',0.01));

xlswrite('concprofile_time_100.xlsx',{'time' 'Concentrations'});
xlswrite('concprofile_time_100.xlsx',[t,c],1,'A2');

