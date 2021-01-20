
y1=0;
x2=1e-8;
x1=1.7e-5;

LVratio=50;
K=0.453;%Henry solubility

Cgas=1;
Cliq=1;
Eliq=0.85;
Evap=0.85;

xval=[];
yval=[];

y=y1;
x=x2;

while(x<=x1)
    %x side
    xa=(Cliq/Cgas)*(y/K);
    x=x+(xa-x)*Eliq;
    
    if(x<=x1)
       xval=[xval; x;]; 
    end
    
    %y side
    ya=LVratio*x;
    y=y+(ya-y)*Evap;
    
    if(x<=x1)
       yval=[yval; y;]; 
    end
end

disp('Number of stages');
disp(size(xval,1));
disp({'x','y'});
disp([xval yval]);


%Writing to excel
xval2=[];
yval2=[];

for i=1:size(xval,1)
   xval2=[xval2; xval(size(xval,1)-i+1);]; 
   yval2=[yval2; yval(size(yval,1)-i+1);]; 
end
xlswrite('str_results.xlsx',{'Number of stages'});
xlswrite('str_results.xlsx',size(xval,1),1,'A2');
xlswrite('str_results.xlsx',{'x','y'},1,'A3');
xlswrite('str_results.xlsx',[xval2 yval2],1,'A4');
