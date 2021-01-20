function a=primenum()

fileID = fopen('prima.txt','r');
sourc=fscanf(fileID,'%f');
        fclose(fileID);
dump=[];

startpos=size(sourc,1);
if startpos<=4
    startval=8;
    sourc=[2
        3
        5
        7];
    dump=sourc;
else
startval=sourc(startpos);
end
ending=1e5;

for i=startval:ending
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
        disp(i);
    end
end
