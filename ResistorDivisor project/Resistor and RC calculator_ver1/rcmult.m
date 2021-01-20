function minval=rcmult(desired)

rcval=xlsread('CapacitorVals_Pre.xlsx','B2:BM64');
colum=xlsread('CapacitorVals_Pre.xlsx','B1:BM1');
row=xlsread('CapacitorVals_Pre.xlsx','A2:A64');

errors=abs(rcval-desired);

[aval,I]=min(errors(:));
[Irow,Icol]=ind2sub(size(errors),I);

disp(row(Irow));
disp(colum(Icol));
disp('Error');
minval=aval;