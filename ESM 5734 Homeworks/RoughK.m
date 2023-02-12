%INPUTS
n= 10;
%alpha=0.99;

alpha=4;
%SHAPE FUNCTIONS
syms s
N1(s) = (1-s)/2;
N2(s) = (1+s)/2;

%length of the element 
h= 1/n;
%constatnt on the right side
p= pi^2/alpha;


N11=diff(N1)/(h/2);
N21=diff(N2)/(h/2);


%KMATRIX
a = ((N11^2) - (p)*(N1^2))*(h/2);
b = (N11*N21 - (p)*(N1*N2))*(h/2);
c = ((N21^2) - (p)*(N2^2))*(h/2);
K11 = int(a,-1,1);
K12 = int(b,-1,1);
K22 = int(c,-1,1);
A=[K11,K12;K12,K22];A;
K=zeros(n+1);
for i=1:n
        for r=1:2
            for c=1:2
                K(r+1*(i-1),c+1*(i-1))=A(r,c)+K(r+1*(i-1),c+1*(i-1));
            end

        end
    end
K;


X=linspace(0,1,n+1);
Z=zeros(n+1,1);
for i=1:n
      Z(i)=Z(i)+int((1-(s*h/2)-(X(i)+X(i+1))/2)*N1,-1,1)*(h/2)*0.01;
      Z(i+1)=int((1-(s*h/2)-(X(i)+X(i+1))/2)*N2,-1,1)*(h/2);
end
Z




Z(1,1)=0;
Z(n+1,1)=0;
for i=1:n
    K(1,i)=0;
    K(n+1,i)=0;
end
K(1,1)=1;
K(n+1,1)=1;

%Replacing values before solving
%for i=1:n+1
%   Z(i,1)=Z(i,1)-K(i,1)*3;
%end
%Z(1,1)=3;
%Z
%for i=1:n+1
%    K(1,i)=0;
%    K(i,1)=0;
%end
%K(1,1)=1;

%Inversion of matrix
d=inv(K)*Z;
plot(X,d)
hold on


%Error Calculation
%syms u_an(x)
%u_an(x)=piecewise(0<=x<=1,(0.01*cos(sqrt(p)*(x))-0.01*cot(sqrt(p))*sin(sqrt(p)*(x))+0.01*(x)-0.01))/p;
%plot(X,d)
%hold on
%fplot(u_an)
hold off