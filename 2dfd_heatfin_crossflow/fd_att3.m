clear all;

M=25;
N=30;
k=100;
T0=400;
T1=300;
qdot=1e5;


hx=1/(N+1);
hz=1/(M+1);
eqnum=0;

for i=1:(N+2)
    for j=1:(M+2)
        eqnum=eqnum+1;
        %Boundary conds
        if(i==1)
            A(eqnum,j)=1;
            B(eqnum)=T0;
            continue;
        end
        if(i==N+2 && j~=M+2)
           A(eqnum,j+(N+2)*(i-1))=1;
           A(eqnum,j+(N+1)*(i-1))=-1;
           B(eqnum)=0;
           continue;
        end
        if(j==M+2)
           A(eqnum,(M+2)+(N+2)*(i-1))=1; 
           B(eqnum)=T1;
           continue;
        end
        if(j==1 && i~=1)
           A(eqnum,1+(N+2)*(i-1))=1;
           A(eqnum,2+(N+2)*(i-1))=-1;
           B(eqnum)=0;
           continue;
        end
        
        disp(j+(N+2)*(i-2));
        %Nornmal operating procedure
        A(eqnum,j+(N+2)*(i))=1/hx^2;
        A(eqnum,j+(N+2)*(i-1))=-2/hx^2-2/hz^2;
        A(eqnum,j+(N+2)*(i-2))=1/hx^2;
        A(eqnum,j+1+(N+2)*(i-1))=1/hz^2;
        A(eqnum,j-1+(N+2)*(i-1))=1/hz^2;
        B(eqnum)=-qdot/k;
    end
end

c=[A transpose(B)];
solmatr=rref(c);
solvec=solmatr(:,size(solmatr,2));

for k=1:((M+2)*(N+2))
    res(1+floor((k-1)/(M+2)),1+rem((k-1),(M+2)))=solvec(k);
end


