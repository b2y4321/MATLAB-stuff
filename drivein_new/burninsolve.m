
N=10;
tfin=3;%Final dimensionless time
initcond=[1];

for i=2:N+2
    initcond=horzcat(initcond,0);
end

[t,c]=ode15s(@(t,c) burnin(t,c,N),[0 tfin],initcond);
