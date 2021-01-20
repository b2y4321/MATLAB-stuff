
%So what this simulation does basically is we isentropically expand our gas
%until we reach the saturation curve on the p-h diagram; ie we have a
%saturated vapor. We then take this saturated vapor and superheat it to
%some overtemperature value, and repeat the process.

Tinit=773;%in K
Pinit=180;%in bar. One must think about wtd after critical point!
dsh=200;%Degrees of superheat after turbine stage
nstg=5;%Number of stages we want

%Saving our initial values
xlswrite('multistgparams.xlsx',{'Initial inlet temp K','Initial inlet pressure bar'});
xlswrite('multistgparams.xlsx',[Tinit Pinit],1,'A2');

a=142.88;
b=0.02114;
R=0.0832;

Tfins=[];
Pfins=[];
Eins=[];
Eouts=[];
stats=[];
Eratios=[];
Evol=[];

for i=1:nstg
    [Tfin,~,eflag1,~]=fsolve(@(Tfin) endptsolver(Tfin,Tinit,Pinit),Tinit-100);
    Tfi=Tinit/1000;
    Tff=Tfin/1000;
    stats=[stats; eflag1;];
    
    Pfin=10^(5.26-1810.9/(Tfin-28.5));

    [v1,~,eflag2,~]=fsolve(@(v) R*Tinit/(v-b)-a/(Tinit^0.5*v*(v+b))-Pinit,1);
    [v2,~,eflag3,~]=fsolve(@(v) R*Tfin/(v-b)-a/(Tinit^0.5*v*(v+b))-Pfin,1);%Saturation volume
    stats=[stats; eflag2;];
    stats=[stats; eflag3;];
    
    Enth1=1000*integral(@(Tf) 29.82+7.98.*Tf+5.39.*Tf^2-2.03.*Tf^3+0.084.*Tf^-2,Tfi,Tff,'ArrayValued',true);
    Enth2=100*integral(@(v) R.*Tinit./(v-b)+a./(2.*Tinit.^.5.*(v.^2+b.*v))-R.*Tinit.*v./(v-b).^2-a.*(2.*v.^2+b.*v)./(Tinit.^.5.*(v.^2+b.*v).^2),v1,v2,'ArrayValued',true);
    
    %Energy needed for superheating
    Eheat=1000*integral(@(Tf) 29.82+7.98.*Tf+5.39.*Tf^2-2.03.*Tf^3+0.084.*Tf^-2,Tff,(Tff+dsh./1000),'ArrayValued',true);
    
    Tfins=[Tfins; Tfin;];
    Pfins=[Pfins; Pfin;];
    Eouts=[Eouts; Enth1+Enth2;];
    Eins=[Eins; Eheat;];
    Eratios=[Eratios; (Enth1+Enth2)/Eheat;];
    Evol=[Evol; Enth2;];
    
    Pinit=Pfin;%Set for next time
    Tinit=Tfin+dsh;%We superheat the now saturated vapor
end


xlswrite('multistgparams.xlsx',{'Final temperature of stage K','Final pressure of stage bar','Energy in for postheating J/mol','Energy out of stage J/mol','Eout/Ein ratio'},1,'A3');
xlswrite('multistgparams.xlsx',[Tfins Pfins Eins Eouts Eratios],1,'A4');
xlswrite('exitstats.xlsx',stats);