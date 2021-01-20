
mcold=1;
L=1;
w=0.01;
Aexch=0.2;
n=1000;

Th1=523;
Tc1=253;
Tc2=293;

mhot=fsolve(@(mhot) gasheater2(mhot,mcold,L,w,Aexch,Th1,Tc1,Tc2),mcold/10);
Th2=fsolve(@(Th2) gasheater1(Th2,mcold,mhot,L,w,Aexch,Th1,Tc1,Tc2),300);
