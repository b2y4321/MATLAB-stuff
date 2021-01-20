function a=adft(Tout)

n=10;

Hrxn=-800000;%Water vapor factored into calculation
Tin=253;

Ttin=Tin./1000;
Ttout=Tout./1000;

ach4r=integral(@(Tt) -0.826082747+109.197332.*Tt-43.73165652.*Tt.^2+6.451414942.*Tt.^3+0.679227145.*Tt.^-2,Ttin,.298,'Arrayvalued',true);
an2r=(7.52.*(n+1)).*integral(@(Tt) 28.24+1.0078.*Tt+5.139.*Tt.^2-1.888.*Tt.^3+0.0087.*Tt.^-2,Ttin,.298,'Arrayvalued',true);
ao2r=(2+2.*n).*integral(@(Tt) 25.49+14.17.*Tt-5.845.*Tt.^2+0.896.*Tt.^3+0.0252.*Tt.^-2,Ttin,.298,'Arrayvalued',true);
awatp=2.*integral(@(Tt) 29.836+7.98.*Tt+5.39.*Tt.^2-2.038.*Tt.^3+0.084.*Tt.^-2,.298,Ttout,'Arrayvalued',true);
ao2p=2.*n.*integral(@(Tt) 25.49+14.17.*Tt-5.845.*Tt.^2+0.896.*Tt.^3+0.0252.*Tt.^-2,.298,Ttout,'Arrayvalued',true);
aco2p=integral(@(Tt) 27.59+29.83.*Tt+33.43.*Tt.^2-9.087.*Tt.^3-0.1433.*Tt.^-2,.298,Ttout,'Arrayvalued',true);
an2p=(7.52.*n).*integral(@(Tt) 28.24+1.0078.*Tt+5.139.*Tt.^2-1.888.*Tt.^3+0.0087.*Tt.^-2,.298,Ttout,'Arrayvalued',true);

a=1000*(aco2p+ao2p+awatp+an2p+ao2r+ach4r+an2r)+Hrxn;