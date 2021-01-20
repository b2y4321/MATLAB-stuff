function dcdt=drivein(t,c,n)

h=1/(n+1);

a(1)=(c(3)-2*c(2)+c(1))/(h^2); %This is equal to a(2),i.e. a(1)=a(2)

for i=2:n+1
   a(i)=(c(i+1)-2*c(i)+c(i-1))/(h^2);    
end

a(n+2)=(c(n+2)-2*c(n+1)+c(n))/(h^2);%This is equal to a(n+1)


dcdt=transpose(a);