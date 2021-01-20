
ncutoff=2;
n=10;

initval=[];

for i=1:ncutoff
   initval=horzcat(initval,1);
end

for i=(ncutoff+1):(n+2)
   initval=horzcat(initval,0);
end

[t,c]=ode15s(@(t,c) drivein(t,c,n),[0 1],initval,odeset('MaxStep',0.001));
[t2,c2]=ode15s(@(t,c) drivein(t,c,n),[0 1],initval);

xlswrite('concprofile_time.xlsx',{'time' 'Concentrations'});
xlswrite('concprofile_time.xlsx',[t,c],1,'A2');

xlswrite('concprofile_time_truncated.xlsx',{'time' 'Concentrations'});
xlswrite('concprofile_time_truncated.xlsx',[t2,c2],1,'A2');