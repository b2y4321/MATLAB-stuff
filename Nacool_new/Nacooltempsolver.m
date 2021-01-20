function a=Nacooltempsolver(Tout,Tin,qtot,m)

b=integral(@(Tf) -(3.001e6).*Tf.^-2+1658-0.8479.*Tf+(4.454e-4).*Tf.^2,Tin,Tout);
a=Tin-Tout+qtot*(Tout-Tin)/(m.*b);