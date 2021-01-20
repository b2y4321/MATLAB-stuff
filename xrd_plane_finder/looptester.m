%you CANNOT call multiple breaks

for n=1:3

bsys=0;
for i=1:5
    for j=1:5
        for k=1:5
            if(i==1 && j==3 && k==5)
                bsys=1;
                break;
            end
        end
        
        if(bsys==1)
           break; 
        end
    end
    
    if(bsys==1)
       break; 
    end
end

disp([i j k]);
end