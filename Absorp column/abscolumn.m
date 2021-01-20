
x1=0;%This might get confused near x=0, relative to y
y2=1e-10;
y1=1.7e-5;
LVratio=1;
Ka=173;

Cgas=1;
Cliq=1;
Eliq=0.85;
Evap=0.85;

xval=[];
yval=[];

y=y2;
x=x1;

while(y<=y1)
   %y part
   ya=x*Ka*(Cliq/Cgas); 
   y=y+(ya-y)*Evap;
   
   if(y<=y1)
       yval=[yval; y;];
   end
   
   %x part
   xa=y/LVratio;
   x=x+(xa-x)*Eliq;
   
   if(y<=y1)
       xval=[xval; x;];
   end
   
end

disp('Number of stages');
disp(size(xval,1));
disp({'x','y'});
disp([xval yval]);
disp('x output');
disp(x1+(LVratio^-1)*y2);

%Writing to excel
xval2=[];
yval2=[];

for i=1:size(xval,1)
   xval2=[xval2; xval(size(xval,1)-i+1);]; 
   yval2=[yval2; yval(size(yval,1)-i+1);]; 
end
xlswrite('abs_results.xlsx',{'Number of stages'});
xlswrite('abs_results.xlsx',size(xval,1),1,'A2');
xlswrite('abs_results.xlsx',{'x','y'},1,'A3');
xlswrite('abs_results.xlsx',[xval2 yval2],1,'A4');



