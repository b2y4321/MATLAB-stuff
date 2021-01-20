function a=primecount()

fileID = fopen('prime numbers to 1e8 - Copy.txt','r');
result=fscanf(fileID,'%f');
        fclose(fileID);

sizer=size(result,1);

threshold=[];
num=[];
ilast=1;
j=10000;
while(j<=9.99e7)
threshold=[threshold; j;];
i=ilast;
counter=0;
while(i<=sizer)
    if(result(i)>j)
       ilast=i;
       break; 
    else
        counter=counter+1;
    end
    i=i+1;
end
num=[num; counter;];
j=j+10000;
end

xlswrite('primestats.xlsx',[threshold num]);