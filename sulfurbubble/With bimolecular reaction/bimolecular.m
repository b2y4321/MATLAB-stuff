function aa=bimolecular(arr,N,V,Da,Db,R,Rout,k,Ca0,Cbinf)

h=(Rout-R)/(N+1);

a=zeros(2*N,1);
for i=2:(N+1)
    first=(Da/h^2)+2*Da/(h*((i-1)*h+R))+V/h;
    second=-(2*Da/h^2+2*Da/(h*((i-1)*h+R))+V/h);
    third=Da/h^2;
    
    first2=(Db/h^2)+2*Db/(h*((i-1)*h+R))+V/h;
    second2=-(2*Db/h^2+2*Db/(h*((i-1)*h+R))+V/h);
    third2=Db/h^2;
    
    if(i==2)
       a(1)=first*arr(2)+second*arr(1)+third*Ca0-(first2*arr(N+2)+second2*arr(N+1));
       continue; 
    end
    if(i==N+1)%Adiabatic
       a(N)=second*arr(N)+third*arr(N-1)-(first2*Cbinf+second2*arr(2*N)+third2*arr(2*N-1));
       continue;
    end
    a(i-1)=first*arr(i)+second*arr(i-1)+third*arr(i-2)-(first2*arr(N+i)+second2*arr(N-1+i)+third2*arr(N-2+i));
end

for i=2:(N+1)
    %Solving for concentration of a ONLY, but with reaction!
    first=(Da/h^2)+2*Da/(h*((i-1)*h+R))+V/h;
    second=-(2*Da/h^2+2*Da/(h*((i-1)*h+R))+V/h);
    third=Da/h^2;
    
    if(i==2)
       a(N+1)=first*arr(2)+second*arr(1)+third*Ca0-k*arr(N+1)*arr(1);
       continue; 
    end
    if(i==N+1)
       a(2*N)=second*arr(N)+third*arr(N-1)-k*arr(2*N)*arr(N);
       continue;
    end
    a(N-1+i)=first*arr(i)+second*arr(i-1)+third*arr(i-2)-k*arr(N-1+i)*arr(i-1);
end

aa=a;