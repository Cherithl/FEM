clc
syms x y
u=piecewise(-2<=x<=2&-1<=y<=1&(1-x^2/4-y^2/1)>=0,2/5*(1-x^2/4-y^2/1));
fsurf(u)

