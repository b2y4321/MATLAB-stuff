function dcdn=burnin(t,c,N)

h=1/(N+1);

a(1)=0;
for i=2:N+1
    a(i)=(c(i+1)-2*c(i)+c(i-1))/h^2;
    
end
a(N+2)=(c(N+2)-2*c(N+1)+c(N))/h^2;

dcdn=transpose(a);