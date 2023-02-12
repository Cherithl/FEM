clc
N1=subs(N1,[L],1)
N2=subs(N2,[L],1)
N3=subs(N3,[L],1)

disp1=piecewise(0<=x<=1/2,d1(1)*N1+d1(2)*N2+d1(3)*N3, 1/2<=x<=1,subs(d1(3)*N1+d1(4)*N2+d1(5)*N3,x,x-1/2), 1<=x<=3/2,subs(d1(5)*N1+d1(6)*N2+d1(7)*N3,x,x-1) ,  3/2<=x<=2,subs(d1(7)*N1+d1(8)*N2+d1(9)*N3,x,x-3/2)  );
figure
fplot(disp1), xlim([0,2]), ylim([0,3.5]),title('Case(a) Displacement Profile'), xlabel('x/c'), ylabel('Non Dimensional Displacement') 
figure
fplot(diff(disp1))


disp2=piecewise(0<=x<=1/2,d2(1)*N1+d2(2)*N2+d2(3)*N3, 1/2<=x<=1,subs(d2(3)*N1+d2(4)*N2+d2(5)*N3,x,x-1/2), 1<=x<=3/2,subs(d2(5)*N1+d2(6)*N2+d2(7)*N3,x,x-1) ,  3/2<=x<=2,subs(d2(7)*N1+d2(8)*N2+d2(9)*N3,x,x-3/2)  );
figure
fplot(disp2), xlim([0,2]), ylim([0,3.5]),title('Case(b) Displacement Profile'), xlabel('x/c'), ylabel('Non Dimensional Displacement') 
figure
fplot(diff(disp2)), xlim([0,2]), ylim([-2,2])
