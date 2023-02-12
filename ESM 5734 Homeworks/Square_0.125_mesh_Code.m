
NELM=100;

%% MESH AND CONNECTIVITY MATRIX
h=1/8;

elem=[1,12 ; 13,32 ; 33,56 ; 57,84 ; 85,114 ; 115,144 ; 145,176 ; 177,208 ; 209,240 ; 241,272 ; 273,302 ; 303,332 ; 333,360 ; 361,384 ; 385,404 ; 405,416 ];
for r=1:16
    for i=
    Connec()




XG=zeros(NELM,4); 
YG=zeros(NELM,4);
Connec=zeros(NELM,4);
for n=1:NELM
    if n<=12
        Connec(n,1)=n;Connec(n,2)=n+1;Connec(n,3)=18+n;Connec(n,4)=17+n;        
        XG(n,1)=-6*h+n*h;XG(n,2)=-5*h+n*h;XG(n,3)=-5*h+n*h;XG(n,4)=-6*h+n*h; 
        YG(n,1)=-8*h;YG(n,2)=-8*h;YG(n,3)=-7*h;YG(n,4)=-7*h;
    elseif n<=20
        Connec(n,1)=n+1;Connec(n,2)=n+2;Connec(n,3)=16+n;Connec(n,4)=15+n;
        XG(n,1)=-7*h+(n-8)*h;XG(n,2)=-6*h+(n-8)*h;XG(n,3)=-6*h+(n-8)*h;XG(n,4)=-7*h+(n-8)*h;
        YG(n,1)=-3*h;YG(n,2)=-3*h;YG(n,3)=-2*h;YG(n,4)=-2*h;
    elseif n<=34
        Connec(n,1)=n+2;Connec(n,2)=n+3;Connec(n,3)=n+19;Connec(n,4)=n+18;
        XG(n,1)=-8*h+(n-20)*h;XG(n,2)=-7*h+(n-20)*h;XG(n,3)=-7*h+(n-20)*h;XG(n,4)=-8*h+(n-20)*h;
        YG(n,1)=-2*h;YG(n,2)=-2*h;YG(n,3)=-h;YG(n,4)=-h;
    elseif n<=50
        Connec(n,1)=n+3;Connec(n,2)=n+4;Connec(n,3)=n+21;Connec(n,4)=n+20;
        XG(n,1)=-9*h+(n-34)*h;XG(n,2)=-8*h+(n-34)*h;XG(n,3)=-8*h+(n-34)*h;XG(n,4)=-9*h+(n-34)*h;
        YG(n,1)=-h;YG(n,2)=-h;YG(n,3)=0;YG(n,4)=0;
    elseif n<=66
        Connec(n,1)=n+4;Connec(n,2)=n+5;Connec(n,3)=n+22;Connec(n,4)=n+21;
        XG(n,1)=-9*h+(n-50)*h;XG(n,2)=-8*h+(n-50)*h;XG(n,3)=-8*h+(n-50)*h;XG(n,4)=-9*h+(n-50)*h;
        YG(n,1)=0;YG(n,2)=0;YG(n,3)=h;YG(n,4)=h;
    elseif n<=80
        Connec(n,1)=n+6;Connec(n,2)=n+7;Connec(n,3)=n+23;Connec(n,4)=n+22;
        XG(n,1)=-8*h+(n-66)*h;XG(n,2)=-7*h+(n-66)*h;XG(n,3)=-7*h+(n-66)*h;XG(n,4)=-8*h+(n-66)*h;
        YG(n,1)=h;YG(n,2)=h;YG(n,3)=2*h;YG(n,4)=2*h;
    elseif n<=92
        Connec(n,1)=n+9;Connec(n,2)=n+10;Connec(n,3)=n+24;Connec(n,4)=n+23;
        XG(n,1)=-7*h+(n-80)*h;XG(n,2)=-6*h+(n-80)*h;XG(n,3)=-6*h+(n-80)*h;XG(n,4)=-7*h+(n-80)*h;
        YG(n,1)=2*h;YG(n,2)=2*h;YG(n,3)=3*h;YG(n,4)=3*h;
    else 
        Connec(n,1)=n+13;Connec(n,2)=n+14;Connec(n,3)=n+25;Connec(n,4)=n+24;
        XG(n,1)=-5*h+(n-92)*h;XG(n,2)=-4*h+(n-92)*h;XG(n,3)=-4*h+(n-92)*h;XG(n,4)=-5*h+(n-92)*h;
        YG(n,1)=3*h;YG(n,2)=3*h;YG(n,3)=4*h;YG(n,4)=4*h;
    end
end
Connec;