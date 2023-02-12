%plots of both approximate and Analytical Sollutions
figure(1)
fplot(@(x) 0.7119+0.9967*(3*x-1)-1.0772*(x)^2+0.3719*(x)^3,[0,1],'b')
hold on
fplot(@(x) (3/(1+exp(2)))*exp(x)-(3*exp(2)/(1+exp(2)))*exp(-x)+2,[0,1],'r')
legend('approximate','Analytical')
hold off

%Plots of derivaties of approximate and Analtical Solutions
figure(2)
fplot(@(x) (0.9967*3)-(2*1.0772*(x))+(3*0.3719*(x)^2),[0,1],'b')
hold on
fplot(@(x) (3/(1+exp(2)))*exp(x)+(3*exp(2)/(1+exp(2)))*exp(-x),[0,1],'r')
legend('approximate','Analytical')
hold off

figure(1)
fplot(a1)
figure(2)
fplot(a2)
figure(3)
fplot(a3)
figure(4)
fplot(a4)
figure(5)
fplot(a5)
