%% 
clear 
clc
tic
%INPUTS
L=100;  %length of the bar
br=8.75/12;hei=27/12;
num=22;  %number of elements
E=(2*10^6)*12^2;
q=1500;
%processed quantities
h=L/num; %size of element
I=(br)*(hei^3)*(1/12);  %Second Moment of Inertia

%%  DERIVING SHAPE FUNCTIONS
syms s
N10(s)=(1/4)*(2-3*s+s^3);  N20(s)=(1/4)*(2+3*s-s^3);
N11(s)=(1/4)*(1-s-s^2+s^3);N21(s)=(1/4)*(-1-s+s^2+s^3);

N10_2=diff(diff(N10))/(h/2)^2;N20_2=diff(diff(N20))/(h/2)^2;
N11_2=diff(diff(N11))/(h/2)^2;N21_2=diff(diff(N21))/(h/2)^2;

a=(h/2)*(N10_2)^2, b=(h/2)*(N10_2)*(N20_2), c=(h/2)*(N20_2)^2

d=(h/2)*N10_2*N11_2; e=(h/2)*N10_2*N21_2;
f=(h/2)*N20_2*N11_2;g=(h/2)*N20_2*N21_2;

h1=(h/2)*N11_2*N10_2; i=(h/2)*N11_2*N20_2;
j=(h/2)*N21_2*N10_2; k=(h/2)*N21_2*N20_2;

l=(h/2)*N11_2^2; m=(h/2)*N11_2*N21_2 ; n=(h/2)*N21_2^2;

%% Element Matrices

K11_00=int(a,-1,1);K12_00=int(b,-1,1);   K11_01=int(d,-1,1);K12_01=int(e,-1,1); 
K21_00=K12_00;     K22_00=int(c,-1,1);   K21_01=int(f,-1,1);K22_01=int(g,-1,1);


K11_10=int(h1,-1,1);K12_10=int(i,-1,1);   K11_11=int(l,-1,1);K12_11=int(m,-1,1);
K21_10=int(j,-1,1);K22_10=int(k,-1,1);   K21_11=K12_11;     K22_11=int(n,-1,1);


A= [K11_00,K12_00;K21_00,K22_00];  B= [K11_01,K12_01;K21_01,K22_01];
C= [K11_10,K12_10;K21_10,K22_10];  D= [K11_11,K12_11;K21_11,K22_11];

%% Global Matrix

K00=zeros(num+1);K01=zeros(num+1);K10=zeros(num+1);K11=zeros(num+1);
for i=1:num
        for r=1:2
            for c=1:2
                K00(r+1*(i-1),c+1*(i-1))=A(r,c)+K00(r+1*(i-1),c+1*(i-1));
                K01(r+1*(i-1),c+1*(i-1))=B(r,c)+K01(r+1*(i-1),c+1*(i-1));
                K10(r+1*(i-1),c+1*(i-1))=C(r,c)+K10(r+1*(i-1),c+1*(i-1));
                K11(r+1*(i-1),c+1*(i-1))=D(r,c)+K11(r+1*(i-1),c+1*(i-1));
            end

        end
end
K_FH=cat(2,K00,K01); K_SH=cat(2,K10,K11);
K_G=cat(1,K_FH,K_SH)*(E*I);

%% LOAD VECTOR:
F10=-q*(int(N10,-1,1))*(h/2);F20=-q*(int(N20,-1,1))*(h/2);
F11=-q*(int(N11,-1,1))*(h/2);F21=-q*(int(N21,-1,1))*(h/2);
F_FH=zeros(num+1,1);F_SH=zeros(num+1,1);
  
    for i=1:num
      F_FH(i)=F_FH(i)+F10; F_SH(i)=F_SH(i)+F11;
      F_FH(i+1)=F20;       F_SH(i+1)=F21; 
    end

 F_G=cat(1,F_FH,F_SH) ;  
 %lamda=1e+10;%K_G(1,1)=K_G(1,1)+lamda;K_G(num+1,num+1)=K_G(num+1,num+1)+lamda;%F_G(1,1)=0;F_G(num+1,1)=0;
 for i=1:2*num+2
     K_G(1,i)=0;K_G(num+1,i)=0;
 end
 K_G(1,1)=1;K_G(num+1,num+1)=1;F_G(1,1)=0;F_G(num+1,1)=0;
 d=inv(K_G)*F_G;
      disp=zeros(num+1,1);
      for i=1:num+1
          disp(i)=d(i);
      end  
      slope=zeros(num+1,1);
      for i=1:num+1
          slope(i)=d(i+num+1);
      end 
 y=1:num+1; 
 x=0:h:L;
 disp=disp*12;
  
 syms s
 u_an(s)=piecewise(0<=s<=22,((-q/24)*s^4+(16500)*((s^3)/6)-(665500)*s)/(E*I));
 u_an=u_an*12;
 
 figure(1)
 plot(x,disp)
 hold on
 fplot(u_an)
 hold off , legend('Approximate','Analytical'),
 xlabel('distance from the left end'),ylabel('Displacement(in)')

%% moment
M=zeros(num,1);
for i=1:num
    M(i)=disp(i)*N10_2(0)+disp(i+1)*N20_2(0)+slope(i)*N11_2(0)+slope(i+1)*N21_2(0);
end
M=M*E*I;

figure(2)
z=h/2:h:(2*num-1)*h/2;
scatter(z,M)
title('Moment vs distance from left end')
ylabel('Moment (lb*ft)')
xlabel('distance(ft)')

%% ERROR FUNCTION
X=(0.5*(1-s)*x(i)+0.5*(1+s)*x(i+1));
disp=disp/12;u_an=u_an/12; 
Num=0;
for i=1:num
    Num=Num+int((disp(i)*N10+disp(i+1)*N20+slope(i)*N11+slope(i+1)*N21-((-q/24)*(0.5*(1-s)*x(i)+0.5*(1+s)*x(i+1))^4+(16500)*(((0.5*(1-s)*x(i)+0.5*(1+s)*x(i+1))^3)/6)-(665500)*(0.5*(1-s)*x(i)+0.5*(1+s)*x(i+1)))/(E*I))^2,-1,1)*(h/2);          
end

for i=1:num
    Num=Num+int((diff(disp(i)*N10+disp(i+1)*N20+slope(i)*N11+slope(i+1)*N21-((-q/24)*(0.5*(1-s)*x(i)+0.5*(1+s)*x(i+1))^4+(16500)*(((0.5*(1-s)*x(i)+0.5*(1+s)*x(i+1))^3)/6)-(665500)*(0.5*(1-s)*x(i)+0.5*(1+s)*x(i+1)))/(E*I)))^2,-1,1)*(2/h);
end

Den=int(u_an^2,0,22)+int((diff(u_an))^2,0,L);
Err=((Num)/(Den))^0.5;
Err=log(Err)
ErrVpa=vpa(Err,6)
toc

