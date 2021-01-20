function minval=resistorvalues(desiredRatio)
vals=xlsread('vals_resistor.xlsx');

valmatr=zeros(size(vals,1),size(vals,1));
for i=1:size(vals,1)
    numer=vals(i);
    for j=1:size(vals,1)
        valmatr(i,j)=vals(j)/numer;
    end
end


b=abs(valmatr-desiredRatio);

[val,I]=min(b(:));
disp('Error of best match in percent:');
disp(val/desiredRatio);%Percent error, minimum result

[Irow,Icol]=ind2sub(size(b),I);%These are the row and col positions of the minimum value!

disp('Best match:');
minval=[vals(Irow) vals(Icol)];















