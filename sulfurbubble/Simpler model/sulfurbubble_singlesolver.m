N=25;
Da=1e-6;
R=0.001;
Rfin=0.01;
Ca0=0.05;
Cb0=5;
k=1;
Vgas=.0224;


C1calc=fsolve(@(C1) sulfurbubble_simple_solve(C1,N,Da,R,Rfin,Ca0,Cb0,k,Vgas),Ca0);
solly=sulfurbubble_simple_eval(C1calc,N,Da,R,Rfin,Ca0,Cb0,k,Vgas);