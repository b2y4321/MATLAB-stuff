[t,c]=ode15s(@(t,c) dropcooling2(t,c),[0 100],[373 0.01 0],odeset('MaxStep',1e-2));

xlswrite('dropcool_0.5mm_detail.xlsx',[t,c]);