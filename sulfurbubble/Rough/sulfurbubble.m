N=10;
Ca0=0.05;
Cbinf=0.5;

Ca_guess=[Ca0];
Ca_guess=horzcat(Ca_guess, linspace(Ca0/2,Ca0/2,N+1));%Guess CA0 first!
Cb_guess=linspace(Cbinf,Cbinf,N+2);


guessMat=horzcat(Ca_guess,Cb_guess);


%d=sulfurbubble_solve(guessMat,N,Ca0,Cbinf);

Cprofile=lsqnonlin(@(arr) sulfurbubble_solve(arr,N,Ca0,Cbinf),guessMat,0,Cbinf,optimset('TolFun',1e-8));


