syms s
N1(s) = (1-s)/2;
N2(s) = (1+s)/2;

n= 2 ; 
h= 1/n;

N11=diff(N1)/(h/2);
N21=diff(N2)/(h/2);



a = ((N11^2) + (N1^2))*(h/2);
b = (N11*N21 + N1*N2)*(h/2);
c = ((N21^2) + (N2^2))*(h/2);



K11 = int(a,-1,1)
K12 = int(b,-1,1)
K22 = int(c,-1,1)

A=[K11,K12;K12,K22]

F1=2*(int(N1,-1,1))*(h/2)
F2=2*(int(N2,-1,1))*(h/2)

B=[F1;F2];
Z=zeros(n+1,1);

for i=1:n
    for r=1:2
        Z(r+1*(i-1),1)=Z(r+1*(i-1),1)+B(r,1);
    end
end
Z(n+1,1)=Z(n+1,1)+2

K=zeros(n+1);

for i=1:n
        for r=1:2
            for c=1:2
                K(r+1*(i-1),c+1*(i-1))=A(r,c)+K(r+1*(i-1),c+1*(i-1));
            end

        end
    end
K

for i=1:n+1
    Z(i,1)=Z(i,1)-K(i,1)*3;
end
Z(1,1)=3;
Z
for i=1:n+1
    K(1,i)=0;
    K(i,1)=0;
end
K(1,1)=1;

d=inv(K)*Z
