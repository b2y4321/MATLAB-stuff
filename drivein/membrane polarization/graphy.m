gam=1.5;
Pe=100;

fplot(@(x) 1+(gam-1)/(exp(Pe)-1)*(exp(Pe*x)-1),[0 1]);