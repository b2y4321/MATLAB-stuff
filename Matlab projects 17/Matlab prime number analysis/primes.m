function a=primes()
n=1e6;
numbers=[];
for i=1:n
   alpha=false;
   for k=2:i-1
       div=i/k;
       if(floor(div)==div)
           alpha=true;
           continue;
       end
   end
   if(alpha==false)
        numbers=[numbers; i;];
   end
end
fileID = fopen('prime.txt','w');
fprintf(fileID,'%d\r\n',numbers);
fclose(fileID);