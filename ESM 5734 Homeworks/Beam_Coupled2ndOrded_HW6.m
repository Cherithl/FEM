clear
clc
%INPUTS
n=22;
br=8.75;hei=27;L=22*12;
I=(br)*(hei^3)*(1/12);
E=2*10^6;
Mo=(hei*E*I/L^2);

%element size
h=1/n;
%% DERIVING SHAPE FUNCTIONS
syms s
N1(s) = ((9*s^3)-(9*s^2)-s+1)*(-1/16);N2(s) = ((3*s^3)-(s^2)-(3*s)+1)*(9/16);%SHAPE FUNCS
N3(s) = ((3*s^3)+(s^2)-(3*s)-1)*(-9/16);N4(s) = ((9*s^3)+(9*s^2)-s-1)*(1/16);

N11=diff(N1)/(h/2);N21=diff(N2)/(h/2); %Derivatives of SHAPE FUNCS
N31=diff(N3)/(h/2);N41=diff(N4)/(h/2);

int(N11^2,-1,1) %Trial

a = (h/2)*N11^2;          k=N1^2*(h/2);
b = (h/2)*N11*N21;        l=N1*N2*(h/2);
c = (h/2)*N11*N31;        m=N1*N3*(h/2);
d = (h/2)*N11*N41;        n2=N1*N4*(h/2);
e = (h/2)*N21^2;          o=N2*N2*(h/2);
f = (h/2)*N21*N31;        p=N2*N3*(h/2);
g = (h/2)*N21*N41;        q=N2*N4*(h/2);
h1 = (h/2)*N31^2;          r=N3^2*(h/2);
i = (h/2)*N31*N41;        s=N3*N4*(h/2);
j = (h/2)*N41^2;          t=N4^2*(h/2);


K11 = int(a,-1,1);K12 = int(b,-1,1);K13 = int(c,-1,1);K14 = int(d,-1,1);
K22 = int(e,-1,1);K23 = int(f,-1,1);K24 = int(g,-1,1);K33 = int(h1,-1,1);
K34 = int(i,-1,1);K44 = int(j,-1,1);

A11= int(k,-1,1);A12= int(l,-1,1);A13= int(m,-1,1);A14= int(n2,-1,1);
A22= int(o,-1,1);A23= int(p,-1,1);A24= int(q,-1,1);A33= int(r,-1,1);
A34= int(s,-1,1);A44= int(t,-1,1);

%ELEMENT STIFFNESS MATRIX
A=[K11,A11,K12,A12,K13,A13,K14,A14  ; 
   0  ,K11,  0,K12,  0,K13,  0,K14  ;
   K12,A12,K22,A22,K23,A23,K24,A24  ;
   0  ,K12,  0,K22,  0,K23,  0,K24  ;
   K13,A13,K23,A23,K33,A33,K34,A34  ;
   0  ,K13,0  ,K23,  0,K33,  0,K34  ;
   K14,A14,K24,A24,K34,A34,K44,A44  ;
   0  ,K14,  0,K24,  0,K34,0  ,K44]
%% GLOBAL STIFFNESS MATRIX AND GLOBAL LOAD VECTOR

   %GLOBAL STIFFNESS MATRIX
          K=zeros(6*n+2);     
         for i=1:n
             for r=1:8
                 for c=1:8
                     K(r+6*(i-1),c+6*(i-1))=A(r,c)+K(r+6*(i-1),c+6*(i-1));
                 end
             end 
         end
         K;

%LOAD VECTOR
q=-(1500/12)*(L^2)/Mo
%P=(12000/12)*(L^2)/Mo
P=0;
F1=-q*(int(N1,-1,1))*(h/2);
F2=-q*(int(N2,-1,1))*(h/2);
F3=-q*(int(N3,-1,1))*(h/2);
F4=-q*(int(N4,-1,1))*(h/2);
B=[0;F1;0;F2;0;F3;0;F4];

%GLOBAL LOAD VECTOR
          Z=zeros((3*n+1)*2,1);
          for i=1:n
              for r=1:8
                  Z(r+6*(i-1))=Z(r+6*(i-1))+B(r,1);
              end
          end
%% IMPLEMENTING BOUNDARY CONDITIONS

 %BOUNDARY CONDITIONS          
     Z(6*n+1,1)=0;
     Z(6*n+2,1)=0;
     Z(2,1)=0;
     Z(56,1)=Z(56,1)+P;%**POINT LOAD CONDITION**
     %for i=1:6*n+2
      %   K(1,i)=0;
       %  K(6*n+1,i)=0;
        % K(6*n+2,i)=0;
         %K(2,i)=0;
     %end
     K(1,1)=1e+10;
     K(2,2)=1e+10;
     K(6*n+1,6*n+1)=1e+10;
     K(6*n+2,6*n+2)=1e+10;
 K;
 Z;
%% 

 %SOLUTION
d=K\Z;
X=0:h/3:1; %X Coordinates of Nodes
y=1:3*n+1; %NODES NUMBERED
     %Dipslacement Solution 
      disp=zeros(3*n+1,1);
      for i=1:3*n+1
          disp(i)=d(2*i-1);
      end      
%Moment Solution
      mom=zeros(3*n+1,1);
      for i=1:3*n+1
          mom(i)=d(2*i);
      end
      %disp=disp*27;
      mom=mom*Mo/12;

      c1=21145521/4840000;c3=(-431955567)/937024000;d1=(-12981803)/4840000;d2=2864511/1663750;d3=(-954837)/9150625;d4=-2182/15625;
      syms disp_an(x)
      disp_an(x)=piecewise(0<=x<=9/22,(-0.7835/24)*x^4+(c1/6)*x^3+(c3)*x,9/22<=x<=1,(-0.7835/24)*(x-9/22)^4+(d1/6)*(x-9/22)^3+(d2/2)*(x-9/22)^2+d3*(x-9/22)+d4);
      %disp_an=disp_an*27/12;
           
figure(1)
plot(X,disp)
hold on
fplot(disp_an)
hold off

legend('Approximate','Analytical')

figure(2)
plot(X,mom)

%%  ERROR FUNCTION
 %X=X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4;
 Num=0;
for i=1:n
    if i<=9
        Num= Num+int(((disp(3*(i-1)+1)*N1+disp(3*(i-1)+2)*N2+disp(3*(i-1)+3)*N3+disp(3*(i-1)+4)*N4-((-0.7835/24)*(X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)^4+(c1/6)*(X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)^3+(c3)*(X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4))))^2,-1`,1)*(h/2);
    else
        Num= Num+int(((disp(3*(i-1)+1)*N1+disp(3*(i-1)+2)*N2+disp(3*(i-1)+3)*N3+disp(3*(i-1)+4)*N4-((-0.7835/24)*((X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)-9/22)^4+(d1/6)*((X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)-9/22)^3+(d2/2)*((X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)-9/22)^2+d3*((X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)-9/22)+d4)))^2,-1,1)*(h/2);
    end
end

for i=1:n
    if i<=9
        Num= Num+int(diff(((disp(3*(i-1)+1)*N1+disp(3*(i-1)+2)*N2+disp(3*(i-1)+3)*N3+disp(3*(i-1)+4)*N4-((-0.7835/24)*(X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)^4+(c1/6)*(X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)^3+(c3)*(X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)))))^2,0,1);
    else
        Num= Num+int(diff(((disp(3*(i-1)+1)*N1+disp(3*(i-1)+2)*N2+disp(3*(i-1)+3)*N3+disp(3*(i-1)+4)*N4-((-0.7835/24)*((X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)-9/22)^4+(d1/6)*((X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)-9/22)^3+(d2/2)*((X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)-9/22)^2+d3*((X(3*(i-1)+1)*N1+X(3*(i-1)+2)*N2+X(3*(i-1)+3)*N3+X(3*(i-1)+4)*N4)-9/22)+d4))))^2,-1,1)*(2/h);
    end
end

Den=int(disp_an^2,0,1)+int(diff((disp_an)^2),0,1);
Err=((Num)/(Den))^0.5;
Err=log(Err)
ErrVpa=vpa(Err,6)
   




