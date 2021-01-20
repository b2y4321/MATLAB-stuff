function dcdx=cprofilesolver(~,c,pin,vin,n,Dparticle,nparticle,D,Z,u,M)
%c in mol/m3
c=transpose(c);%We need to bend the shape of the vector into the right form!

ctotal=sum(c);
Diffstotal=[];

%Diffusivity for each component i
for i=1:n
    Dcol=D(i,:);%Scrape out the row
    diffus=(sum((c./ctotal)./Dcol)).^-1;%Diffusivity of i in the mixture    
    Diffstotal=[Diffstotal; diffus;];
end

%General viscosity
utotal=sum((c./ctotal).*u);

%Densities
ptotal=sum((c.*M));

v=pin*vin/ptotal;%velocity
Sc=utotal./(ptotal.*Diffstotal);%Schmidt number of system

%General params
Re=ptotal*v*Dparticle/utotal;

Km=(Diffstotal./Dparticle).*(2+(0.4.*Re^0.5+0.06.*Re.^(2/3)).*Sc.^0.4);%Mass tf coeff vector

coeffs=(Km.*nparticle./v).*pi.*Dparticle.^2.*Z;


%Diff eq's
for i=1:n
   a(i)=-coeffs(i)*c(i); 
end

dcdx=transpose(a);
