function a=primes2()
n=1e6;
numbers=[];
h=waitbar(0,'Please Wait');
for i=1:n
   check=i/10000;
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
   if(floor(check)==check)
       fileID = fopen('prime.txt','a');
       fprintf(fileID,'%d\r\n',numbers);
       fclose(fileID);
       numbers=[];
   end
   waitbar(i/n);
end
