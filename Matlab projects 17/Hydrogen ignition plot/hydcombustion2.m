function a=hydcombustion2()

i=450;
while(i<=600)
T0=i;
figure();
ode15s(@(v,f) hydcombustion(v,f,T0),[0 0.01],[0 T0]);
i=i+5;
end
