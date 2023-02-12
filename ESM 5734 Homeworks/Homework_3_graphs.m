c1=(1+2*exp(1))/(1+exp(2));
c2=(exp(2)-2*exp(1))/(1+exp(2));

syms a1(x) a2(x) a3(x) a4(x) a5(x) u_an(x)
a1(x) = piecewise(0<=x<= 0.25,(0.25-x)/(0.25),0.25<=x<=1,0);
a2(x) = piecewise(0<=x<=0.25,(x)/(0.25),0.25<x<=0.5,(0.5-x)/(0.25),0.5<=x<=1,0);
a3(x) = piecewise(0<=x<=0.25,0,0.25<=x<=0.50,(x-0.25)/(0.25),0.50<x<=0.75,(0.75-x)/(0.25),0.75<=x<=1,0);
a4(x) = piecewise(0<=x<=0.50,0,0.5<=x<=0.75,(x-0.50)/(0.25),0.75<x<=1.0,(1.0-x)/(0.25));
a5(x) = piecewise(0<=x<=0.75,0,0.75<=x<=1,(x-0.75)/(0.25));

u_an(x)=piecewise(0<=x<=1,c1*exp(x)+c2*exp(-x)+2);
u=3*a1+3.1652*a2+3.404*a3+3.7314*a4+4.1682*a5;

e=int(((u-u_an)^2+(diff(u-u_an))^2),0,1)/int((u_an^2+(diff(u_an))^2),0,1);
e=e^(0.5);
e=log(e);
vpa(e,4)


%figure(2)
%fplot(u)
%hold on
%fplot(u_an)
%title('Plots of Solutions')
%legend('Approximate','Analytical','Location','southeast')
%hold off



