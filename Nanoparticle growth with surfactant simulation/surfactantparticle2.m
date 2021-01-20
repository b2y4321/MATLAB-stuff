function ae=surfactantparticle2(Kp,Kn)
Ah=.001;
%Kp=1;
%Kn=.4;

[t,A]=ode15s(@(t,A) surfactantparticle(t,A,Ah,Kp,Kn),[1e-10 2.5e-4],[1e-8 1e-12]);


Nsurf=A(:,2).*Ah;

figure();
plot(t,Nsurf,'r',t,A(:,1),'b');
names=strcat('Kn',num2str(Kn),'Kp',num2str(Kp),'.jpg');
saveas(gcf,names);
ae=1;