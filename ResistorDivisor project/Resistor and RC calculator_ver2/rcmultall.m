function minval=rcmultall(desired,errorTol)%Desired ratio and error tolerance

rcval=xlsread('CapacitorVals_Pre.xlsx','B2:BM64');
colum=xlsread('CapacitorVals_Pre.xlsx','B1:BM1');
row=xlsread('CapacitorVals_Pre.xlsx','A2:A64');

errors=abs(rcval-desired);

I=find(errors<=errorTol);
[Irow,Icol]=ind2sub(size(errors),I);

for i=1:size(Icol)
   disp(colum(Icol(i)));
   disp(row(Irow(i)));
end