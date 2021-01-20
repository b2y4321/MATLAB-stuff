function a=sericond(n,col)
iter=1000;
send=[];
for j=1:iter
b=rand(n,col);

for i=1:n
    for k=1:col
        b(i,k)=round(b(i,k));
    end
end

k=sum(b);
%disp(k);
kreal=(k+1);
%disp(kreal);

R=(kreal./n).^(-1);

send=[send 1./sum(R)];
end

a=transpose(send);