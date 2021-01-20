%Burnin process

N=10;
t1=0.5;%Final dimensionless time
t2=2;
initcond=[1];

for i=2:N+2
    initcond=horzcat(initcond,0);
end

[t,c]=ode15s(@(t,c) burnin(t,c,N),[0 t1],initcond);

%Drivein process
initcond2=[];
index1=size(c,1);

for i=1:N+2
    initcond2=horzcat(initcond2,c(index1,i));
end

[t2,c2]=ode15s(@(t,c) drivein(t,c,N),[0 tfin],initcond2);


