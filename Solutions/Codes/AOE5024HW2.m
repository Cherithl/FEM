syms a1(x) b1(x)
a1(x) =piecewise(0<=x<=1,-0.5*x^2+2.5*x,1<=x<=2,-0.5*(x-1)^2+2*(x-1)+2);
b1(x)= piecewise(0<=x<=1,-x+2.5,1<=x<=2,-(x-1)+2);

figure(1)
xticks(0:0.25:2)
fplot(a1)
title('u vs x')

figure(2)
xticks([0 0.5 1 1.5 2])
fplot(b1)
title('σ as vs x')
%Second Problem
syms a2(x) b2(x)
a2(x) =piecewise(0<=x<=1,-0.5*x^2+(4*x/3),1<=x<=2,-0.5*(x-1)^2-((x-1)/3)+(5/6));
b2(x)= piecewise(0<=x<=1,(4/3)-x,1<=x<=2,-(x-1)-(1/3));

figure(3)
xticks(0:0.25:2)
fplot(a2)
title('u vs x')

figure(4)
xticks([0 0.5 1 1.5 2])
fplot(b2)
title('σ as vs x')

%Third Problem
syms a3(x) b3(x)
a3(x) =piecewise(0<=x<=1/2,9/4*x,1/2<=x<=1,9/8+(7/4)*(x-0.5),1<=x<=3/2,2+(7/4)*(x-1),3/2<=x<=2,23/8+(5/4)*(x-3/2));
b3(x)= piecewise(0<=x<=1/2,9/4,1/2<=x<=1,7/4,1<=x<=3/2,7/4,3/2<=x<=2,5/4);

figure(5)
xticks(0:0.25:2)
fplot(a3)
title('u vs x')

figure(6)
xticks([0 0.5 1 1.5 2])
fplot(b3)
title('σ as vs x')