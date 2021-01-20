%Reading 2Theta in degrees

%Mode and seek
mode=0;%0: show all planes (incl reduntant), 1: show only first plane found
seekmax=5;



bsys=0;

Thets_2=xlsread('2Theta.xlsx');
Thets=Thets_2./2;

square_sins=(sind(Thets)).^2;

Rs=zeros(size(Thets_2,1),1);

for i=1:size(Rs,1)
   Rs(i)=square_sins(i)/square_sins(1); 
end

mguess=1/(Rs(2)-Rs(1));
m=fmincon(@(m) minfunc(m,Rs),mguess);%m that finds local min, initial guess used



hkls=round(m.*Rs);%hkl planes, specifically h^2+k^2+l^2
%Notice we round!

%Finding out which plane we have


indexs=cell(size(hkls,1),1);
    
for n=1:size(hkls,1)
    hs=[];
    ks=[];
    ls=[];
    
    bsys=0;
    for i=0:seekmax
        for j=0:seekmax
            for k=0:seekmax
                
                if((i^2+j^2+k^2)==hkls(n) && mode==0)
                    hs=[hs; i;];
                    ks=[ks; j;];
                    ls=[ls; k;];
                end
                
                if((i^2+j^2+k^2)==hkls(n) && mode==1)
                    hs=[hs; i;];
                    ks=[ks; j;];
                    ls=[ls; k;];
                    
                    %Trigger a break cascade in the loop
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
    
    
    summatr=horzcat(hs,ks,ls);
    indexs{n}=summatr;
end

%Now, getting a file with everything in it
wrInd=2;
xlswrite('finresults.xlsx',{'Angle','R factor','h^2+k^2+L^2','h','k','L','mode','seekmax','mult factor'});
xlswrite('finresults.xlsx',[mode seekmax round(m)],1,'G2:I2');%Notice we round mult. factor!

for i=1:size(indexs,1)
   %Basically, for one independent val, we list all dependent vals and
   %increment the writing commensurately.
   dataMatr=[Thets(i) Rs(i) hkls(i)];
   cData=indexs{i}; 
   hs=cData(:,1);
   ks=cData(:,2);
   Ls=cData(:,3);
   
   %Writing independent val matr
   xlswrite('finresults.xlsx',dataMatr,1,conv2xlscell(wrInd,1));
   
   %Writing data matr
   xlswrite('finresults.xlsx',hs,1,conv2xlscell(wrInd,4));
   xlswrite('finresults.xlsx',ks,1,conv2xlscell(wrInd,5));
   xlswrite('finresults.xlsx',Ls,1,conv2xlscell(wrInd,6));
   
   %Indexing
   wrInd=wrInd+size(hs,1)+1;
end






