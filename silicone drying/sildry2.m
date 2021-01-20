function dydt=sildry2(t,y)

Dow=.5e-3;
Dos=1.5e-3;
N=10;
Cs0=1;
k=0.1;

h=1/(N+1);

%Cw equations
Dw=Dow*(y(N+2)/Cs0);
a(1)=(Dow/Cs0)*(1/h^2)*(y(N+2)-y(N+2))*(y(1)-y(1))+(Dw/h^2)*(y(2)-2*y(1)+y(1))-k*y(1)*y(N+2);

for i=2:N
    Dw=Dow*(y(N+1+i)/Cs0);
    a(i)=(Dow/Cs0)*(1/h^2)*(y(N+1+i)-y(N+i))*(y(i)-y(i-1))+(Dw/h^2)*(y(i+1)-2*y(i)+y(i-1))-k*y(i)*y(N+1+i);
end
a(N+1)=0;

%Cw equations
Ds=Dos*(y(N+2)/Cs0);
a(N+2)=(Dos/Cs0)*(1/h^2)*(y(N+2)-y(N+2))*(y(N+2)-y(N+2))+(Ds/h^2)*(y(N+3)-2*y(N+2)+y(N+2))-k*y(1)*y(N+2);

for i=(N+3):(2*N+1)
    Ds=Dos*(y(i)/Cs0);
    a(i)=(Dos/Cs0)*(1/h^2)*(y(i)-y(i-1))*(y(i)-y(i-1))+(Ds/h^2)*(y(i+1)-2*y(i)+y(i-1))-k*y(i)*y(i-(N+1));
end
a(2*N+2)=a(2*N+1);

dydt=transpose(a);