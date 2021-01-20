function a=primenum1()

sourc=[2 
    3 
    5 
    7];
dump=[2
    3
    5
    7];
ending=1e4;


for i=8:ending
    count=0;
    sizing=size(sourc,1);
    for k=1:sizing
       divisor=sourc(k); 
       vis=rem(i,divisor);
       if vis==0
           count=1;
           break;
       end
    end
    if count==0
       sourc=[sourc; i;]; 
       dump=[dump; i;];
    end
    if rem(i,5000)==0
        fileID = fopen('prima.txt','a');
        fprintf(fileID,'%d\r\n',dump);
        fclose(fileID);
        dump=[];
    end
end

a=sourc;