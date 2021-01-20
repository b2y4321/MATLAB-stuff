function minval=resistorvalues_all()
desiredRatio=2.5;
maxError=0.03;

vals=xlsread('vals_resistor.xlsx');

valmatr=zeros(size(vals,1),size(vals,1));
for i=1:size(vals,1)
    numer=vals(i);
    for j=1:size(vals,1)
        valmatr(i,j)=vals(j)/numer;
    end
end


b=abs(valmatr-desiredRatio);
J=find(b(:)<=maxError);
[Irow,Icol]=ind2sub(size(b),J);%These are the row and col positions of the minimum value!

disp('Working Values:');

ActValuesRow=vals(Irow);
ActValuesCol=vals(Icol);
valerr=ActValuesCol./ActValuesRow-desiredRatio;

disp([ActValuesRow ActValuesCol valerr]);
xlswrite('resistor_compliant_vals.xlsx',[ActValuesRow ActValuesCol valerr]);







