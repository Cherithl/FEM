NELM=16;
n=1:sqrt(NELM):NELM-sqrt(NELM)+1;
NN=36;
i=sqrt(NN):sqrt(NN):NN;

syms x y
T_an(x,y)=piecewise(0<=x<=3 & 0<=y<=2,(10.420*sin(x/2*sqrt(12-pi^2))-2.6048*cos(x/2*sqrt(12-pi^2)))*sin(pi*y/2));
fsurf(T_an);

