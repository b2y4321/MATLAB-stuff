function a=sulfurbubble_simple_solve(C1,N,Da,R,Rfin,Ca0,Cb0,k,Vgas)

A=zeros(N+2);
B=zeros(N+2,1);
h=(Rfin-R)/(N+1);

for i=1:N+2
    if(i==1)
       A(1,1)=1;
       B(1)=Ca0;
       continue; 
    end
    if(i==N+2)
       %A(N+2,N+1)=1;
       A(N+2,N+2)=1;
       continue; 
    end
    entr1=Da/h^2*(1+(Ca0-C1)*(1/Vgas))+2*Da/(h*(h*(i-1)+R));
    entr2=-(2*Da/(h*(h*(i-1)+R))+(2*Da/h^2)+(Da/h^2)*(1/Vgas)*(Ca0-C1)+k*Cb0);
    entr3=Da/h^2;
    
    A(i,i+1)=entr1;
    A(i,i)=entr2;
    A(i,i-1)=entr3;
end

solvmatr=horzcat(A,B);
solns=rref(solvmatr);

C1calc=solns(2,N+3);

a=C1-C1calc;