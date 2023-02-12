tic
clear
clc
syms x y
psi_19(x,y)=piecewise(0<=x<=1&2<=y<=3,2*x+y-x*y-2,1<x<=5&0<=y<=3|0<=x<=1&0<=y<2,0);
toc 
fprintf('psi_19 formulation done')
figure(1)
fsurf(psi_19,[0 5 0 3]),zlim([0 1]), xlabel('x'), ylabel('y') ,title('\psi_1_9') ,
toc 
fprintf('psi_19 plotting done')
%% 
syms x y
psi_17(x,y)=piecewise(3<=x<=4&1<=y<=2,x*y-3*y-x+3,4<=x<=5&1<=y<=2,x+5*y-5-x*y,4<=x<=5&2<=y<=3,x*y-3*x-5*y+15,3<=x<=4&2<=y<=3,3*x+3*y-x*y-9,0<=x<3&0<=y<=3 |3<=x<=5&0<=y<1,0);
toc 
fprintf('psi_17 formulation done')
figure(2)
fsurf(psi_17), xlabel('x'), ylabel('y'), title('\psi_1_7')
toc 
fprintf('psi_17 plotting done')

%% 
syms x y
psi_9(x,y)=piecewise(1<=x<=2&1/2<=y<=1&x+y-2>=0&x-y-1<=0,x+y-2,3/2<=x<=2&0<=y<=1&x-y-1>=0&x+y-2>=0,x+y-2,2<=x<=5/2&0<=y<=1&x+y-3<=0&x-y-2<=0,y-x+2,2<=x<=3&1/2<=y<=1&x+y-3>=0&x-y-2<=0,y-x+2,2<=x<=3&1<=y<=2,x*y-2*x-3*y+6,1<=x<=2&1<=y<=2,y+2*x-x*y-2,0<=x<=5&2<y<=3|0<=x<1&1<=y<=2|3<x<=5&1<=y<=2|0<=x<=2&0<=y<=1&x+y-2<0|2<=x<=5&0<=y<=1&x-y-2>0,0);     
toc 
fprintf('psi_9 formulation done')                     
figure(3)
fsurf(psi_9), xlabel('x') , ylabel('y'), title('\psi_9')
toc 
fprintf('psi_9 plotting done')