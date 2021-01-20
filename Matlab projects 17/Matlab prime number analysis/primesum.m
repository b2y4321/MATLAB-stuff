function a=primesum()

fileID = fopen('prime numbers to 1e8 - Copy.txt','r');
result=fscanf(fileID,'%f');
        fclose(fileID);

sizer=size(result,1);

threshold=[];
num=[];
j=10000;
while(j<=9.99e7)
threshold=[threshold; j;];
counter=0;
i=1;
while(i<=sizer)
    if(result(i)>j)
       break; 
    else
        counter=counter+1;
    end
    i=i+1;
end
num=[num; counter;];
j=j+10000;
end

xlswrite('primesums.xlsx',[threshold num]);