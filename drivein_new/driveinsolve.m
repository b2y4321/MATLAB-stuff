
N=10;
tfin=2;
divider=3;

initcond=[];
for i=1:divider
    initcond=horzcat(initcond,1);
end
for i=(1+divider):N+2
    initcond=horzcat(initcond,0);
end

[t,c]=ode15s(@(t,c) drivein(t,c,N),[0 tfin],initcond);