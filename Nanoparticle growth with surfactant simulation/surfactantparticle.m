function dAdt=surfactantparticle(t,A,Ah,Kp,Kn)

N=A(2);

a(1)=2.*3.14.*Kp.*(A(1)./12.56).^.5.*abs(A(1)-Ah.*N)./A(1);
a(2)=Kn.*abs(A(1)-Ah.*N)./A(1);

dAdt=transpose(a);