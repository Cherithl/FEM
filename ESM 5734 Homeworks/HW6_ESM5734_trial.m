
E=2*10^6 ; I=(8.75/12)*((27/12)^3)/12 ; h=27/12 ;
c1=259500/11
c3=(-11415500)/11
d1=(-21000)/11
d2=1667250/11
d3=(-2910500)/11
d4=(-151441875)/22
syms disp(x)
disp(x)=piecewise(0<=x<=9,(-1500/24)*x^4+(c1/6)*x^3+(c3)*x,9<=x<=22,(-1500/24)*(x-9)^4+(d1/6)*(x-9)^3+(d2/2)*(x-9)^2+d3*(x-9)+d4);
disp(x)=disp(x)/((E*I))
fplot(disp)