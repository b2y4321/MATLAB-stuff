clear all;
%This program involves 2 base temperatures!
M=15;
N=15;
k=160;
b=0.001;
Tb=400;%Base temperature
Tinf=270;
qdot=0;
Ux=5;
Uz=50;

hx=1/(N+1);
hz=1/(M+1);
eqnum=0;

for i=1:(N+2)
    for j=1:(M+2)
        eqnum=eqnum+1;
        %Boundary conds
        if(i==1)%Base temperature BC
            A(eqnum,j)=1;
            B(eqnum)=Tb;
            continue;
        end
        if(i==N+2 && j~=M+2)
           A(eqnum,j+(N+2)*(i-1))=1;
           A(eqnum,j+(N+2)*(i-2))=-1;
           B(eqnum)=0;
           continue;
        end
        if(j==M+2)
           A(eqnum,(M+2)+(N+2)*(i-1))=1;  
           B(eqnum)=Tb;
           continue;
        end
        if(j==1 && i~=1)
           A(eqnum,1+(N+2)*(i-1))=1;
           A(eqnum,2+(N+2)*(i-1))=-1;
           B(eqnum)=0;
           continue;
        end

        %Nornmal operating procedure
        A(eqnum,j+(N+2)*(i))=k*b/hx^2;
        A(eqnum,j+(N+2)*(i-1))=-2*k*b/hx^2-2*k*b/hz^2-Ux*hx-Uz*hz;
        A(eqnum,j+(N+2)*(i-2))=k*b/hx^2;
        A(eqnum,j+1+(N+2)*(i-1))=k*b/hz^2;
        A(eqnum,j-1+(N+2)*(i-1))=k*b/hz^2;
        B(eqnum)=-qdot/k-Uz*hz*Tinf-Ux*hx*Tinf;
    end
end

c=[A transpose(B)];
solmatr=rref(c);
solvec=solmatr(:,size(solmatr,2));

for k=1:((M+2)*(N+2))
    res(1+floor((k-1)/(M+2)),1+rem((k-1),(M+2)))=solvec(k);
end

mesh(res);
