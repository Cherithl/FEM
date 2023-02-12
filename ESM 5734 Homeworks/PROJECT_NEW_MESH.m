clear
clc
NELM=416;

%% MESH AND CONNECTIVITY MATRIX
h=1/8;

%elem=[1,12 ; 13,32 ; 33,56 ; 57,84 ; 85,114 ; 115,144 ; 145,176 ; 177,208 ; 209,240 ; 241,272 ; 273,302 ; 303,332 ; 333,360 ; 361,384 ; 385,404 ; 405,416 ];

XG=zeros(NELM,4); 
YG=zeros(NELM,4);
Connec=zeros(NELM,4);
for n=1:NELM     %FIX THE CONNECTIVITY ARRAY YOU DIDNT CHANGE AFTER PASTING 
 1;   if n<=12
        Connec(n,1)=n;Connec(n,2)=n+1;Connec(n,3)=18+n;Connec(n,4)=17+n;        
        XG(n,1)=-7*h+n*h;XG(n,2)=-6*h+n*h;XG(n,3)=-6*h+n*h;XG(n,4)=-7*h+n*h; 
        YG(n,1)=-8*h;YG(n,2)=-8*h;YG(n,3)=-7*h;YG(n,4)=-7*h;
 2;   elseif n<=32
        Connec(n,1)=n+1;Connec(n,2)=n+2;Connec(n,3)=25+n;Connec(n,4)=24+n;
        XG(n,1)=-11*h+(n-12)*h;XG(n,2)=-10*h+(n-12)*h;XG(n,3)=-10*h+(n-12)*h;XG(n,4)=-11*h+(n-12)*h;
        YG(n,1)=-7*h;YG(n,2)=-7*h;YG(n,3)=-6*h;YG(n,4)=-6*h;
 3;   elseif n<=56
        Connec(n,1)=n+2;Connec(n,2)=n+3;Connec(n,3)=n+30;Connec(n,4)=n+29;
        XG(n,1)=-13*h+(n-32)*h;XG(n,2)=-12*h+(n-32)*h;XG(n,3)=-12*h+(n-32)*h;XG(n,4)=-13*h+(n-32)*h;
        YG(n,1)=-6*h;YG(n,2)=-6*h;YG(n,3)=-5*h;YG(n,4)=-5*h;
 4;   elseif n<=84
        Connec(n,1)=n+3;Connec(n,2)=n+4;Connec(n,3)=n+34;Connec(n,4)=n+33;
        XG(n,1)=-15*h+(n-56)*h;XG(n,2)=-14*h+(n-56)*h;XG(n,3)=-14*h+(n-56)*h;XG(n,4)=-15*h+(n-56)*h;
        YG(n,1)=-5*h;YG(n,2)=-5*h;YG(n,3)=-4*h;YG(n,4)=-4*h;
 5;   elseif n<=114
        Connec(n,1)=n+4;Connec(n,2)=n+5;Connec(n,3)=n+36;Connec(n,4)=n+35;
        XG(n,1)=-16*h+(n-84)*h;XG(n,2)=-15*h+(n-84)*h;XG(n,3)=-15*h+(n-84)*h;XG(n,4)=-16*h+(n-84)*h;
        YG(n,1)=-4*h;YG(n,2)=-4*h;YG(n,3)=-3*h;YG(n,4)=-3*h;
 6;   elseif n<=144
        Connec(n,1)=n+5;Connec(n,2)=n+6;Connec(n,3)=n+38;Connec(n,4)=n+37;
        XG(n,1)=-16*h+(n-114)*h;XG(n,2)=-15*h+(n-114)*h;XG(n,3)=-15*h+(n-114)*h;XG(n,4)=-16*h+(n-114)*h;
        YG(n,1)=-3*h;YG(n,2)=-3*h;YG(n,3)=-2*h;YG(n,4)=-2*h;
 7;   elseif n<=176
        Connec(n,1)=n+6;Connec(n,2)=n+7;Connec(n,3)=n+40;Connec(n,4)=n+39;
        XG(n,1)=-17*h+(n-144)*h;XG(n,2)=-16*h+(n-144)*h;XG(n,3)=-16*h+(n-144)*h;XG(n,4)=-17*h+(n-144)*h;
        YG(n,1)=-2*h;YG(n,2)=-2*h;YG(n,3)=-h;YG(n,4)=-h;
 8;   elseif n<=208
        Connec(n,1)=n+7;Connec(n,2)=n+8;Connec(n,3)=n+41;Connec(n,4)=40+n;
        XG(n,1)=-17*h+(n-176)*h;XG(n,2)=-16*h+(n-176)*h;XG(n,3)=-16*h+(n-176)*h;XG(n,4)=-17*h+(n-176)*h;
        YG(n,1)=-h;YG(n,2)=-h;YG(n,3)=0;YG(n,4)=0;
 9;   elseif n<=240
        Connec(n,1)=n+8;Connec(n,2)=n+9;Connec(n,3)=n+42;Connec(n,4)=n+41;
        XG(n,1)=-17*h+(n-208)*h;XG(n,2)=-16*h+(n-208)*h;XG(n,3)=-16*h+(n-208)*h;XG(n,4)=-17*h+(n-208)*h;
        YG(n,1)=0;YG(n,2)=0;YG(n,3)=h;YG(n,4)=h;
 10;   elseif n<=272
        Connec(n,1)=n+9;Connec(n,2)=n+10;Connec(n,3)=n+43;Connec(n,4)=n+42;
        XG(n,1)=-17*h+(n-240)*h;XG(n,2)=-16*h+(n-240)*h;XG(n,3)=-16*h+(n-240)*h;XG(n,4)=-17*h+(n-240)*h;
        YG(n,1)=h;YG(n,2)=h;YG(n,3)=2*h;YG(n,4)=2*h;
  11;  elseif n<=302
        Connec(n,1)=n+11;Connec(n,2)=n+12;Connec(n,3)=n+44;Connec(n,4)=n+43;
        XG(n,1)=-16*h+(n-272)*h;XG(n,2)=-15*h+(n-272)*h;XG(n,3)=-15*h+(n-272)*h;XG(n,4)=-16*h+(n-272)*h;
        YG(n,1)=2*h;YG(n,2)=2*h;YG(n,3)=3*h;YG(n,4)=3*h;
  12;  elseif n<=332
        Connec(n,1)=n+13;Connec(n,2)=n+14;Connec(n,3)=n+45;Connec(n,4)=n+44;
        XG(n,1)=-16*h+(n-302)*h;XG(n,2)=-15*h+(n-302)*h;XG(n,3)=-15*h+(n-302)*h;XG(n,4)=-16*h+(n-302)*h;
        YG(n,1)=3*h;YG(n,2)=3*h;YG(n,3)=4*h;YG(n,4)=4*h;
  13;    elseif n<=360
        Connec(n,1)=n+15;Connec(n,2)=n+16;Connec(n,3)=n+46;Connec(n,4)=n+45;
        XG(n,1)=-15*h+(n-332)*h;XG(n,2)=-14*h+(n-332)*h;XG(n,3)=-14*h+(n-332)*h;XG(n,4)=-15*h+(n-332)*h;
        YG(n,1)=4*h;YG(n,2)=4*h;YG(n,3)=5*h;YG(n,4)=5*h;
  14;     elseif n<=384
        Connec(n,1)=n+19;Connec(n,2)=n+20;Connec(n,3)=n+47;Connec(n,4)=n+46;
        XG(n,1)=-13*h+(n-360)*h;XG(n,2)=-12*h+(n-360)*h;XG(n,3)=-12*h+(n-360)*h;XG(n,4)=-13*h+(n-360)*h;
        YG(n,1)=5*h;YG(n,2)=5*h;YG(n,3)=6*h;YG(n,4)=6*h;
   15; elseif n<=404
        Connec(n,1)=n+24;Connec(n,2)=n+25;Connec(n,3)=n+48;Connec(n,4)=n+47;
        XG(n,1)=-11*h+(n-384)*h;XG(n,2)=-10*h+(n-384)*h;XG(n,3)=-10*h+(n-384)*h;XG(n,4)=-11*h+(n-384)*h;
        YG(n,1)=6*h;YG(n,2)=6*h;YG(n,3)=7*h;YG(n,4)=7*h;
   16; else 
        Connec(n,1)=n+31;Connec(n,2)=n+32;Connec(n,3)=n+49;Connec(n,4)=n+48;
        XG(n,1)=-7*h+(n-404)*h;XG(n,2)=-6*h+(n-404)*h;XG(n,3)=-6*h+(n-404)*h;XG(n,4)=-7*h+(n-404)*h;
        YG(n,1)=7*h;YG(n,2)=7*h;YG(n,3)=8*h;YG(n,4)=8*h;
    end
end
Connec;

figure
plot(XG,YG)


figure
scatter(XG,YG)



