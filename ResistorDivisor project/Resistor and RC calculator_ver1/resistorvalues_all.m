function minval=resistorvalues_all(desiredRatio,maxError)
vallys=[1.0
2.2
10.0
15.0
22.0
33.0
39.0
51.0
68.0
82.0
100.0
120.0
150.0
180.0
220.0
270.0
330.0
390.0
470.0
510.0
560.0
680.0
820.0
1000.0
1200.0
1500.0
1800.0
2200.0
2700.0
3000.0
3300.0
3900.0
4700.0
5100.0
5600.0
6800.0
8200.0
10000.0
12000.0
15000.0
18000.0
22000.0
27000.0
33000.0
39000.0
47000.0
51000.0
56000.0
68000.0
82000.0
100000.0
120000.0
150000.0
180000.0
220000.0
270000.0
330000.0
470000.0
1000000.0
1500000.0
2200000.0
3300000.0
4700000.0
10000000.0
];

a=xlsread('ResistorDivisor.xlsx');
b=abs(a-desiredRatio);
J=find(b(:)<=maxError);
[Irow,Icol]=ind2sub(size(b),J);%These are the row and col positions of the minimum value!

disp('Working Values:');

for i=1:size(Irow)
    ActValues1=vallys(Irow(i));
    ActValues2=vallys(Icol(i));
    disp([ActValues1 ActValues2]);
end













