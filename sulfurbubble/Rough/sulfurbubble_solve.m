function a=sulfurbubble_solve(arr,N,Ca0,Cb0)
R=0.001;
R2=0.05;%Final radius to iterate to
h=(R2-R)/(N+1);
Da=1e-4;
Db=1e-6;
k=0.1;

for i=1:N+2
    if(i==1)
        a(i)=Ca0;
        continue;
    end
    if(i==2)
       v=Da*(arr(i)-arr(1))/h*4*pi*R^2; 
    end
    if(i==N+2)
        a(i)=a(i-1);
        continue;
    end
    Cb=arr(N+2+i);
    eqni=(Da/h^2+2*Da/(h*((i-1)*h+R))-v/h)*arr(i+1)-(2*Da/h^2+2*Da/(h*((i-1)*h+R))-v/h-k*Cb)*arr(i)+(Da/h^2)*arr(i-1);
    a(i)=eqni;
end

%Concentration of b
for i=(N+3):(2*N+4)
    j=i-(N+2);
    if(j==1)
        a(i)=1;%We'll assign this later
        continue;
    end
    if(j==N+2)
        a(i)=Cb0;
        continue;
    end
    Ca=arr(i-(N+2));
    eqni=(Db/h^2+2*Db/(h*((j-1)*h+R))-v/h)*arr(i+1)-(2*Db/h^2+2*Db/(h*((j-1)*h+R))-v/h-k*Ca)*arr(i)+(Db/h^2)*arr(i-1);
    a(i)=eqni;
    if(j==2)
       a(i-1)=a(i); 
    end
end

