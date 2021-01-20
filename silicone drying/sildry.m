function dydt=sildry(~,y)

Dpw=1e-3;
Dow=1e-2;
Dp=1e-5;
Do=1e-4;
k=1e-2;
N=10;
R=0.001;
Cso=.1;

h=R/(N+1);

%Cw parameters
Dw=Dpw+(Dow-Dpw)*(y(N+2)/Cso);
a(1)=(Dpw/(h)+(Dow-Dpw)/(h*Cso)*y(N+2)+(Dow-Dpw)/(Cso*h)*(y(N+3)-y(N+2)))*(1/h)*(y(2)-y(1))+(Dw/h^2)*(y(2)-2*y(1)+y(1))-k*y(1)*y(N+2);
for i=2:N
    Dw=Dpw+(Dow-Dpw)*(y(N+1+i)/Cso);
    a(i)=(Dpw/(i*h)+(Dow-Dpw)/(i*h*Cso)*y(N+1+i)+(Dow-Dpw)/(Cso*h)*(y(N+1+i)-y(N+i)))*(1/h)*(y(i)-y(i-1))+(Dw/h^2)*(y(i+1)-2*y(i)+y(i-1))-k*y(i)*y(N+1+i);
end
a(N+1)=0;

%Cs parameters
D=Dp+(Do-Dp)*(y(N+2)/Cso);
a(N+2)=(Dp/(h)+(Do-Dp)/(h*Cso)*y(N+2)+(Do-Dp)/(Cso*h)*(y(N+2)-y(N+2)))*(1/h)*(y(N+2)-y(N+2))+(D/h^2)*(y(N+3)-2*y(N+2)+y(N+2))-k*y(1)*y(N+2);
for i=(N+3):(2*N+1)
    D=Dp+(Do-Dp)*(y(i)/Cso);
    a(i)=(Dp/(((i-(N+1))*h))+(Do-Dp)/((i-(N+1))*h*Cso)*y(i)+(Do-Dp)/(Cso*h)*(y(i)-y(i-1)))*(1/h)*(y(i)-y(i-1))+(D/h^2)*(y(i+1)-2*y(i)+y(i-1))-k*y(i-(N+1))*y(i);
end
a(2*N+2)=a(2*N+1);

dydt=transpose(a);