clear all 
clc
tic;
%% INPUTS
NELM=25  ;  %Number of Elements
NN=(sqrt(NELM)+1)^2   ;   %Number of Nodes
%NNE=4;    %Number of Nodes per Element
%NI=4;     %Number of Integration Points

%% MESH AND CONNECTIVITY MATRIX
x=0:3/sqrt(NELM):3;
y=0:2/sqrt(NELM):2;

XG=zeros(NELM,4);
YG=zeros(NELM,4);
Connec=zeros(NELM,4);
x=0:3/sqrt(NELM):3;
y=0:2/sqrt(NELM):2;
Last=sqrt(NELM)+1;
cntr=0;
for r=1:sqrt(NELM)
    for c=1:sqrt(NELM)
        cntr=cntr+1;    
        Connec(cntr,1)=(sqrt(NELM)+1)*(r-1)+c;              XG(cntr,1)=x(c);  YG(cntr,1)=y(r);
        Connec(cntr,2)=(sqrt(NELM)+1)*(r-1)+c+1;            XG(cntr,2)=x(c+1);YG(cntr,2)=y(r);
        Connec(cntr,3)=(sqrt(NELM)+1)*(r-1)+c+sqrt(NELM)+2; XG(cntr,3)=x(c+1);YG(cntr,3)=y(r+1);
        Connec(cntr,4)=(sqrt(NELM)+1)*(r-1)+c+sqrt(NELM)+1; XG(cntr,4)=x(c);  YG(cntr,4)=y(r+1);
    end
end
Connec;

%%  SHAPE FUNCTIONS
syms r s
N1=(1/4)*(1-r)*(1-s);
N2=(1/4)*(1+r)*(1-s);
N3=(1/4)*(1+r)*(1+s);
N4=(1/4)*(1-r)*(1+s);
N=[N1,N2,N3,N4];
%% STIFFNESS MATRIX
K=zeros(NN);
for n=1:NELM         %Del(phi)*Del(u) and PHI*U Two Integrands 
      for i=1:4
          for j=1:4
              x=XG(n,1)*N1+XG(n,2)*N2+XG(n,3)*N3+XG(n,4)*N4; y=YG(n,1)*N1+YG(n,2)*N2+YG(n,3)*N3+YG(n,4)*N4; %x and  y interms of r and s
              dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y 
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives
              J=det(Mat);                                                   %JACOBIAN
              drdx=(1/J)*dyds;dsdx=-(1/J)*dydr;          drdy=(-1/J)*dxds;dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES
              Integrand1=((diff(N(i),r)*drdx+diff(N(i),s)*dsdx)*(diff(N(j),r)*drdx+diff(N(j),s)*dsdx)+(diff(N(i),r)*drdy+diff(N(i),s)*dsdy)*(diff(N(j),r)*drdy+diff(N(j),s)*dsdy))*J;
              Integrand2=-3*N(i)*N(j)*J;
              dum1=(subs(Integrand1,[r,s],[-1/sqrt(3),-1/sqrt(3)])+subs(Integrand1,[r,s],[1/sqrt(3),-1/sqrt(3)])+subs(Integrand1,[r,s],[1/sqrt(3),1/sqrt(3)])+subs(Integrand1,[r,s],[-1/sqrt(3),1/sqrt(3)]));
              dum2=(subs(Integrand2,[r,s],[-1/sqrt(3),-1/sqrt(3)])+subs(Integrand2,[r,s],[1/sqrt(3),-1/sqrt(3)])+subs(Integrand2,[r,s],[1/sqrt(3),1/sqrt(3)])+subs(Integrand2,[r,s],[-1/sqrt(3),1/sqrt(3)]));
              K(Connec(n,i),Connec(n,j))=K(Connec(n,i),Connec(n,j))+dum1+dum2;
          end
      end
end

for n=1:sqrt(NELM):NELM-sqrt(NELM)+1   % THIRD INTEGRAND CAME FROM FLUX TERM ON THE LEFT
    for i=1:3:4
        for j=1:3:4
            x=XG(n,1)*N1+XG(n,2)*N2+XG(n,3)*N3+XG(n,4)*N4; y=YG(n,1)*N1+YG(n,2)*N2+YG(n,3)*N3+YG(n,4)*N4;
            dyds=diff(y,s);
            Integrand=-N(i)*N(j)*dyds;Integrand=subs(Integrand,r,-1);
            dum=int(Integrand,s,-1,1);
            K(Connec(n,i),Connec(n,j))=K(Connec(n,i),Connec(n,j))+dum;
        end
    end
end
    
%% LOAD VECTOR
F=zeros(NN,1);
for n=1:sqrt(NELM):NELM-sqrt(NELM)+1
        x=XG(n,1)*N1+XG(n,2)*N2+XG(n,3)*N3+XG(n,4)*N4; y=YG(n,1)*N1+YG(n,2)*N2+YG(n,3)*N3+YG(n,4)*N4;
        dyds=diff(y,s);
        FIntegrand_1=-5*N1*dyds*sin(pi*y/2);FIntegrand_1=subs(FIntegrand_1,r,-1);
        FIntegrand_2=-5*N4*dyds*sin(pi*y/2);FIntegrand_2=subs(FIntegrand_2,r,-1);
    F(Connec(n,1),1)=F(Connec(n,1),1)+int(FIntegrand_1,s,-1,1);
    F(Connec(n,4),1)=F(Connec(n,4),1)+int(FIntegrand_1,s,-1,1);
end

%% ESSENTIAL BOUNDARY CONDITIONS

for i=1:sqrt(NN)    %LOWER BOUNDARY TEMPERATURE BOUNDARY CONDITIONS
    K(i,:)=0;
    K(i,i)=1;
end
cntr=0;
for i=sqrt(NN):sqrt(NN):NN  %RIGHT BOUNDARY TEMPERATURE FUCNTION
    F(i)=10*sin(pi*(cntr*2/sqrt(NELM))/2);
    K(i,:)=0;
    K(i,i)=1;
    cntr=cntr+1;
end
for i=NN-sqrt(NN)+1:NN %UPPER BOUNDARY CONDITIONs
    K(i,:)=0;
    K(i,i)=1;
end
F(1,1)=0;
F(NN-sqrt(NN)+1,1)=0;F(NN,1)=0;
%% SOLVING THE EQUATIONS
d=inv(K)*F;

X=0:3/sqrt(NELM):3;
Y=0:2/sqrt(NELM):2;


for row=1:sqrt(NN)
    for i=1:sqrt(NN)
        Xnode((row-1)*sqrt(NN)+i)=X(i);
        Ynode((row-1)*sqrt(NN)+i)=Y(row);
    end
end
for row=1:sqrt(NN)
    for c=1:sqrt(NN)
        Temp(row,c)=d((row-1)*sqrt(NN)+c);
        Xnew(row,c)=Xnode((row-1)*sqrt(NN)+c);
        Ynew(row,c)=Ynode((row-1)*sqrt(NN)+c);
    end
end
%%  POST PROCESSING
%[Xnew,Ynew]=meshgrid(x,y);

%figure
%scatter3(Xnode,Ynode,d)

%[xGrid, yGrid] = meshgrid(0:3/sqrt(NELM):3, 0:2/sqrt(NELM):2);
%figure
%surf(xGrid, yGrid, Temp)
%xlabel("X", "FontSize", 12)
%ylabel("Y", "FontSize", 12)
%zlabel("T", "FontSize", 12)

%% ERROR FUNCTION

syms r s
N1=(1/4)*(1-r)*(1-s);
N2=(1/4)*(1+r)*(1-s);
N3=(1/4)*(1+r)*(1+s);
N4=(1/4)*(1-r)*(1+s);

Num_0=0;Den_0=0; Num_1=0;Den_1=0;
%for n=1:NELM
 %   x=XG(n,1)*N1+XG(n,2)*N2+XG(n,3)*N3+XG(n,4)*N4; 
  %  y=YG(n,1)*N1+YG(n,2)*N2+YG(n,3)*N3+YG(n,4)*N4; %x and  y interms of r and s
   % dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y 
    %Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives
                                                       %JACOBIAN
   % t_an=(10.420*sin(x/2*sqrt(12-pi^2))-2.6048*cos(x/2*sqrt(12-pi^2)))*sin(pi*y/2);                                                   
   % temp=d(Connec(n,1))*N1+d(Connec(n,2))*N2+d(Connec(n,3))*N3+d(Connec(n,4))*N4;
     
   % tan_1=diff(t_an,r)*drdx+diff(t_an,s)*dsdx+diff(t_an,r)*drdy+diff(t_an,s)*dsdy;
   % temp_1=diff(temp,r)*drdx+diff(temp,s)*dsdx+diff(temp,r)*drdy+diff(temp,s)*dsdy;

    %Num_0Int=((temp-t_an)^2)*J;  Num_1Int=((temp_1-tan_1)^2)*J;
    %Den_0Int=((t_an)^2)*J;       Den_1Int=(tan_1^2)*J;
    
    

    %Num_0IntDone=subs(Num_0Int,[r,s],[-sqrt(1/3),-sqrt(1/3)])+subs(Num_0Int,[r,s],[sqrt(1/3),-sqrt(1/3)])+subs(Num_0Int,[r,s],[sqrt(1/3),sqrt(1/3)])+subs(Num_0Int,[r,s],[-sqrt(1/3),sqrt(1/3)]);
    %Den_0IntDone=subs(Den_0Int,[r,s],[-sqrt(1/3),-sqrt(1/3)])+subs(Den_0Int,[r,s],[sqrt(1/3),-sqrt(1/3)])+subs(Den_0Int,[r,s],[sqrt(1/3),sqrt(1/3)])+subs(Den_0Int,[r,s],[-sqrt(1/3),sqrt(1/3)]);
    
  %  Num_1IntDone=subs(Num_1Int,[r,s],[-sqrt(1/3),-sqrt(1/3)])+subs(Num_1Int,[r,s],[sqrt(1/3),-sqrt(1/3)])+subs(Num_1Int,[r,s],[sqrt(1/3),sqrt(1/3)])+subs(Num_1Int,[r,s],[-sqrt(1/3),sqrt(1/3)]);
  %  Den_1IntDone=subs(Den_1Int,[r,s],[-sqrt(1/3),-sqrt(1/3)])+subs(Den_1Int,[r,s],[sqrt(1/3),-sqrt(1/3)])+subs(Den_1Int,[r,s],[sqrt(1/3),sqrt(1/3)])+subs(Den_1Int,[r,s],[-sqrt(1/3),sqrt(1/3)]);

  %  Num_0=Num_0+Num_0IntDone;
   % Den_0=Den_0+Den_0IntDone;

    %Num_1=Num_1+Num_0IntDone+Num_1IntDone;
    %Den_1=Den_1+Den_0IntDone+Den_1IntDone;
%end

%Err_0=vpa(Num_0/Den_0,3);
%Err_0=sqrt(Err_0)

%Err_1=vpa(Num_1/Den_1,3);
%Err_1=sqrt(Err_1)

toc;





