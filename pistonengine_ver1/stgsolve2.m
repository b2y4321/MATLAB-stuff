function res=stgsolve2()

%Stage 1 characteristics
T1=298;
P1=1;
CR=10;

%intermediate calcs
R=0.0832;
v4=R*T1/P1;%v4 is same as v1 assumed
v3=v4/CR;%v3 is same as v2 assumed

%stage 2 chars
xn2_2=0.739;
xwat_2=0.135;
xco2_2=0.125;
nfuel=0.0168;

T2=fsolve(@(T2) stage1(T2,T1,P1,CR),600);
T3=fsolve(@(T3) stage2(T3,T2,xco2_2,xn2_2,xwat_2,nfuel),1000);
T4=fsolve(@(T4) stage3(T4,T3,xn2_2,xwat_2,xco2_2,v3,v4),600);

disp([T2 T3 T4]);
disp([v3 v4]);