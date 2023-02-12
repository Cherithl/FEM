tic
clear 
clc
%INPUTS
num=4;
L=1;
gamma=0.25;
f=12*10^3;
E=2*10^9;
I=500*(0.01)^4;

h=L/num;
alpha=E*I;
X=0:h:L;
%% SHAPE FUNCTIONS
syms s
N10=(1/16)*(8-15*s+10*s^3-3*s^5); 
N20=(1/16)*(8+15*s-10*s^3+3*s^5);
N11=(1/16)*(5-7*s-6*s^2+10*s^3+s^4-3*s^5)*(h/2);
N21=(1/16)*(-5-7*s+6*s^2+10*s^3-s^4-3*s^5)*(h/2);
N12=(1/16)*(1-s-2*s^2+2*s^3+s^4-s^5)*(h/2)^2;
N22=(1/16)*(1+s-2*s^2-2*s^3+s^4+s^5)*(h/2)^2;
figure(1) 
subplot(3,1,1),fplot(N10,[-1,1]); hold on ,fplot(N20,[-1,1]); hold off, legend('N0_1,N0_2') 
subplot(3,1,2),fplot(N11,[-1,1]); hold on ,fplot(N21,[-1,1]); hold off, legend('N1_1 N1_2')
subplot(3,1,3),fplot(N12,[-1,1]); hold on ,fplot(N22,[-1,1]); hold off, legend('N2_1 N2_2')
%% BASIS FUNCTIONS
syms x
psi_0(x)=piecewise(0<=x<=X(2),0,X(2)<x<=X(3),subs(N20,s,(x-X(2))/(X(3)-X(2))+(x-X(3))/(X(3)-X(2))),X(3)<=x<=X(4),subs(N10,s,(x-X(3))/(X(4)-X(3))+(x-X(4))/(X(4)-X(3))),X(4)<=x<=X(5),0);
psi_1(x)=piecewise(0<=x<=X(2),0,X(2)<x<=X(3),subs(N21,s,(x-X(2))/(X(3)-X(2))+(x-X(3))/(X(3)-X(2))),X(3)<=x<=X(4),subs(N11,s,(x-X(3))/(X(4)-X(3))+(x-X(4))/(X(4)-X(3))),X(4)<=x<=X(5),0);
psi_2(x)=piecewise(0<=x<=X(2),0,X(2)<x<=X(3),subs(N22,s,(x-X(2))/(X(3)-X(2))+(x-X(3))/(X(3)-X(2))),X(3)<=x<=X(4),subs(N12,s,(x-X(3))/(X(4)-X(3))+(x-X(4))/(X(4)-X(3))),X(4)<=x<=X(5),0);
figure(2)

subplot(3,1,1)
fplot(psi_0) ,xlim([0 1]), ylim([-0.5 1.1]), xticks(0:0.25:1), grid on , ylabel(['\psi0_',num2str(3)]), title('\psi0 BASIS FUNCTION AT NODE 3') 
subplot(3,1,2)
fplot(psi_1) ,xlim([0 1]) , ylim([-0.1 0.1]),xticks(0:0.25:1), grid on ,  ylabel(['\psi1_',num2str(3)]),title('\psi1 BASIS FUNCTIONS AT NODE 3') 
subplot(3,1,3)
fplot(psi_2) ,xlim([0 1]) ,ylim([-0.001 0.002]), xticks(0:0.25:1), grid on ,  ylabel(['\psi2_',num2str(3)]),title('\psi2 BASIS FUNCTION AT NODE 3')


%% ELEMENT STIFFNESS MATRICES
N10_3=diff(N10,3)/(h/2)^3; N10_2=diff(N10,2)/(h/2)^2;   
N20_3=diff(N20,3)/(h/2)^3; N20_2=diff(N20,2)/(h/2)^2;%%
N11_3=diff(N11,3)/(h/2)^3; N11_2=diff(N11,2)/(h/2)^2;
N21_3=diff(N21,3)/(h/2)^3; N21_2=diff(N21,2)/(h/2)^2;%%
N12_3=diff(N12,3)/(h/2)^3; N12_2=diff(N12,2)/(h/2)^2;
N22_3=diff(N22,3)/(h/2)^3; N22_2=diff(N22,2)/(h/2)^2;%% 

a1=((gamma)^2*(N10_3)^2+(N10_2)^2)*(h/2);          d1=((gamma)^2*(N10_3*N11_3)+(N10_2*N11_2))*(h/2); h1=((gamma)^2*(N10_3*N12_3)+(N10_2*N12_2))*(h/2);
b1=((gamma)^2*(N10_3*N20_3)+(N10_2*N20_2))*(h/2);  e1=((gamma)^2*(N10_3*N21_3)+(N10_2*N21_2))*(h/2); i1=((gamma)^2*(N10_3*N22_3)+(N10_2*N22_2))*(h/2);
c1=((gamma)^2*(N20_3)^2+(N20_2)^2)*(h/2);          f1=((gamma)^2*(N20_3*N11_3)+(N20_2*N11_2))*(h/2); j1=((gamma)^2*(N20_3*N12_3)+(N20_2*N12_2))*(h/2);
                                                   g1=((gamma)^2*(N20_3*N21_3)+(N20_2*N21_2))*(h/2); k1=((gamma)^2*(N20_3*N22_3)+(N20_2*N22_2))*(h/2);

 d2=((gamma)^2*(N11_3*N10_3)+(N11_2*N10_2))*(h/2); a2=((gamma)^2*(N11_3)^2+(N11_2)^2)*(h/2);         l2=((gamma)^2*(N11_3*N12_3)+(N11_2*N12_2))*(h/2);
 e2=((gamma)^2*(N11_3*N20_3)+(N11_2*N20_2))*(h/2); b2=((gamma)^2*(N11_3*N21_3)+(N11_2*N21_2))*(h/2); m2=((gamma)^2*(N11_3*N22_3)+(N11_2*N22_2))*(h/2);
 f2=((gamma)^2*(N21_3*N10_3)+(N21_2*N10_2))*(h/2); c2=((gamma)^2*(N21_3)^2+(N21_2)^2)*(h/2);         n2=((gamma)^2*(N21_3*N12_3)+(N21_2*N12_2))*(h/2);
 g2=((gamma)^2*(N21_3*N20_3)+(N21_2*N20_2))*(h/2);                                                   o2=((gamma)^2*(N21_3*N22_3)+(N21_2*N22_2))*(h/2);

 h3=((gamma)^2*(N12_3*N10_3)+(N12_2*N10_2))*(h/2); l3=((gamma)^2*(N12_3*N11_3)+(N12_2*N11_2))*(h/2); a3=((gamma)^2*(N12_3)^2+(N12_2)^2)*(h/2);
 i3=((gamma)^2*(N12_3*N20_3)+(N12_2*N20_2))*(h/2); m3=((gamma)^2*(N12_3*N21_3)+(N12_2*N21_2))*(h/2); b3=((gamma)^2*(N12_3*N22_3)+(N12_2*N22_2))*(h/2);
 j3=((gamma)^2*(N22_3*N10_3)+(N22_2*N10_2))*(h/2); n3=((gamma)^2*(N22_3*N11_3)+(N22_2*N11_2))*(h/2); c3=((gamma)^2*(N22_3)^2+(N22_2)^2)*(h/2);
 k3=((gamma)^2*(N22_3*N20_3)+(N22_2*N20_2))*(h/2); o3=((gamma)^2*(N22_3*N21_3)+(N22_2*N21_2))*(h/2);


K11_00=int(a1,-1,1);K12_00=int(b1,-1,1);   K11_01=int(d1,-1,1);K12_01=int(e1,-1,1); K11_02=int(h1,-1,1);K12_02=int(i1,-1,1);
K21_00=K12_00      ;K22_00=int(c1,-1,1);   K21_01=int(f1,-1,1);K22_01=int(g1,-1,1); K21_02=int(j1,-1,1);K22_02=int(k1,-1,1);

K11_10=int(d2,-1,1);K12_10=int(e2,-1,1);   K11_11=int(a2,-1,1);K12_11=int(b2,-1,1);  K11_12=int(l2,-1,1);K12_12=int(m2,-1,1); 
K21_10=int(f2,-1,1);K22_10=int(g2,-1,1);   K21_11=K12_11      ;K22_11=int(c2,-1,1);  K21_12=int(n2,-1,1);K22_12=int(o2,-1,1);

K11_20=int(h3,-1,1);K12_20=int(i3,-1,1);   K11_21=int(l3,-1,1);K12_21=int(m3,-1,1); K11_22=int(a3,-1,1);K12_22=int(b3,-1,1);  
K21_20=int(j3,-1,1);K22_20=int(k3,-1,1);   K21_21=int(n3,-1,1);K22_21=int(o3,-1,1); K21_22=K12_22      ;K22_22=int(c3,-1,1);          

K00=vpa([K11_00,K12_00;K21_00,K22_00],3), K01=vpa([K11_01,K12_01;K21_01,K22_01],3), K02=vpa([K11_02,K12_02;K21_02,K22_02],3)
K10=vpa([K11_10,K12_10;K21_10,K22_10],3), K11=vpa([K11_11,K12_11;K21_11,K22_11],3), K12=vpa([K11_12,K12_12;K21_12,K22_12],3)
K20=vpa([K11_20,K12_20;K21_20,K22_20],3), K21=vpa([K11_21,K12_21;K21_21,K22_21],3), K22=vpa([K11_22,K12_22;K21_22,K22_22],3)

K=[K00 K01 K02;K10 K11 K12;K20 K21 K22];
K=vpa(K,3)

%% LOAD VECTOR

F3_0=vpa(-(f/alpha)*int(N10,-1,1)*(h/2)-(f/alpha)*int(N20,-1,1)*(h/2) )
F3_1=vpa(-(f/alpha)*int(N11,-1,1)*(h/2)-(f/alpha)*int(N21,-1,1)*(h/2))
F3_2=vpa(-(f/alpha)*int(N12,-1,1)*(h/2)-(f/alpha)*int(N22,-1,1)*(h/2))
toc
