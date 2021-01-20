function a=sericrun(y)
ye=[];
col=600;
for i=600:y
        ye=[ye sericond(i,col)];
end

xlswrite('sericond.xlsx',ye);