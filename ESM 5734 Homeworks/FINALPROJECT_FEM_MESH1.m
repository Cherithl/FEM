clear all 
clc
tic;
%% INPUTS
NELM=100;

%% MESH AND CONNECTIVITY MATRIX
h=1/4;

XG=zeros(NELM,4); 
YG=zeros(NELM,4);
Connec=zeros(NELM,4);
for n=1:NELM
    if n<=8
        Connec(n,1)=n;Connec(n,2)=n+1;Connec(n,3)=12+n;Connec(n,4)=11+n;        
        XG(n,1)=-5*h+n*h;XG(n,2)=-4*h+n*h;XG(n,3)=-4*h+n*h;XG(n,4)=-5*h+n*h; 
        YG(n,1)=-4*h;YG(n,2)=-4*h;YG(n,3)=-3*h;YG(n,4)=-3*h;
    elseif n<=20
        Connec(n,1)=n+1;Connec(n,2)=n+2;Connec(n,3)=16+n;Connec(n,4)=15+n;
        XG(n,1)=-7*h+(n-8)*h;XG(n,2)=-6*h+(n-8)*h;XG(n,3)=-6*h+(n-8)*h;XG(n,4)=-7*h+(n-8)*h;
        YG(n,1)=-3*h;YG(n,2)=-3*h;YG(n,3)=-2*h;YG(n,4)=-2*h;
    elseif n<=34
        Connec(n,1)=n+2;Connec(n,2)=n+3;Connec(n,3)=n+19;Connec(n,4)=n+18;
        XG(n,1)=-8*h+(n-20)*h;XG(n,2)=-7*h+(n-20)*h;XG(n,3)=-7*h+(n-20)*h;XG(n,4)=-8*h+(n-20)*h;
        YG(n,1)=-2*h;YG(n,2)=-2*h;YG(n,3)=-h;YG(n,4)=-h;
    elseif n<=50
        Connec(n,1)=n+3;Connec(n,2)=n+4;Connec(n,3)=n+21;Connec(n,4)=n+20;
        XG(n,1)=-9*h+(n-34)*h;XG(n,2)=-8*h+(n-34)*h;XG(n,3)=-8*h+(n-34)*h;XG(n,4)=-9*h+(n-34)*h;
        YG(n,1)=-h;YG(n,2)=-h;YG(n,3)=0;YG(n,4)=0;
    elseif n<=66
        Connec(n,1)=n+4;Connec(n,2)=n+5;Connec(n,3)=n+22;Connec(n,4)=n+21;
        XG(n,1)=-9*h+(n-50)*h;XG(n,2)=-8*h+(n-50)*h;XG(n,3)=-8*h+(n-50)*h;XG(n,4)=-9*h+(n-50)*h;
        YG(n,1)=0;YG(n,2)=0;YG(n,3)=h;YG(n,4)=h;
    elseif n<=80
        Connec(n,1)=n+6;Connec(n,2)=n+7;Connec(n,3)=n+23;Connec(n,4)=n+22;
        XG(n,1)=-8*h+(n-66)*h;XG(n,2)=-7*h+(n-66)*h;XG(n,3)=-7*h+(n-66)*h;XG(n,4)=-8*h+(n-66)*h;
        YG(n,1)=h;YG(n,2)=h;YG(n,3)=2*h;YG(n,4)=2*h;
    elseif n<=92
        Connec(n,1)=n+9;Connec(n,2)=n+10;Connec(n,3)=n+24;Connec(n,4)=n+23;
        XG(n,1)=-7*h+(n-80)*h;XG(n,2)=-6*h+(n-80)*h;XG(n,3)=-6*h+(n-80)*h;XG(n,4)=-7*h+(n-80)*h;
        YG(n,1)=2*h;YG(n,2)=2*h;YG(n,3)=3*h;YG(n,4)=3*h;
    else 
        Connec(n,1)=n+13;Connec(n,2)=n+14;Connec(n,3)=n+25;Connec(n,4)=n+24;
        XG(n,1)=-5*h+(n-92)*h;XG(n,2)=-4*h+(n-92)*h;XG(n,3)=-4*h+(n-92)*h;XG(n,4)=-5*h+(n-92)*h;
        YG(n,1)=3*h;YG(n,2)=3*h;YG(n,3)=4*h;YG(n,4)=4*h;
    end
end
Connec;
figure
scatter(XG,YG)

%fprintf('Connectivity Matrix and Meshing Done\n')
%toc;

%%  SHAPE FUNCTIONS   Partial wrt r      Partial wrt s
syms r s
N1=(1/4)*(1-r)*(1-s);  N1_r=diff(N1,r);  N1_s=diff(N1,s); 
N2=(1/4)*(1+r)*(1-s);  N2_r=diff(N2,r);  N2_s=diff(N2,s);
N3=(1/4)*(1+r)*(1+s);  N3_r=diff(N3,r);  N3_s=diff(N3,s);
N4=(1/4)*(1-r)*(1+s);  N4_r=diff(N4,r);  N4_s=diff(N4,s);
N_r=[N1_r,N2_r,N3_r,N4_r];  N_s=[N1_s,N2_s,N3_s,N4_s];  % Array of derivaties for easy access and reduced computational time
%% STIFFNESS MATRIX
K=zeros(125);

for n=1:NELM         %Del(phi)*Del(u) and PHI*U Two Integrands       
    for i=1:4
          for j=1:4
              x=XG(n,1)*N1+XG(n,2)*N2+XG(n,3)*N3+XG(n,4)*N4; y=YG(n,1)*N1+YG(n,2)*N2+YG(n,3)*N3+YG(n,4)*N4; %x and  y interms of r and s            
              dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
           
              drdx=(1/J)*dyds;dsdx=-(1/J)*dydr;          drdy=(-1/J)*dxds;dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES
              Integrand1=((N_r(i)*drdx+N_s(i)*dsdx)*(N_r(j)*drdx+N_s(j)*dsdx)+(N_r(i)*drdy+N_s(i)*dsdy)*(N_r(j)*drdy+N_s(j)*dsdy))*J;                        
              dum=(subs(Integrand1,[r,s],[-1/sqrt(3),-1/sqrt(3)])+subs(Integrand1,[r,s],[1/sqrt(3),-1/sqrt(3)])+subs(Integrand1,[r,s],[1/sqrt(3),1/sqrt(3)])+subs(Integrand1,[r,s],[-1/sqrt(3),1/sqrt(3)]));              
              K(Connec(n,i),Connec(n,j))=K(Connec(n,i),Connec(n,j))+dum;
               
          end 
    end 
end
    fprintf('\nGlobal Stiffness Matrix Done\n')
    toc
%% LOAD VECTOR
F=zeros(125,1);
for n=1:NELM
        x=XG(n,1)*N1+XG(n,2)*N2+XG(n,3)*N3+XG(n,4)*N4; y=YG(n,1)*N1+YG(n,2)*N2+YG(n,3)*N3+YG(n,4)*N4;
        dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y      
        Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives    
        J=det(Mat);                                                   %JACOBIAN     
        drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES
            
        FIntegrand_1=1000*N1*J;  dum1=(subs(FIntegrand_1,[r,s],[-1/sqrt(3),-1/sqrt(3)])+subs(FIntegrand_1,[r,s],[1/sqrt(3),-1/sqrt(3)])+subs(FIntegrand_1,[r,s],[1/sqrt(3),1/sqrt(3)])+subs(FIntegrand_1,[r,s],[-1/sqrt(3),1/sqrt(3)]));
        FIntegrand_2=1000*N2*J;  dum2=(subs(FIntegrand_2,[r,s],[-1/sqrt(3),-1/sqrt(3)])+subs(FIntegrand_2,[r,s],[1/sqrt(3),-1/sqrt(3)])+subs(FIntegrand_2,[r,s],[1/sqrt(3),1/sqrt(3)])+subs(FIntegrand_2,[r,s],[-1/sqrt(3),1/sqrt(3)]));
        FIntegrand_3=1000*N3*J;  dum3=(subs(FIntegrand_3,[r,s],[-1/sqrt(3),-1/sqrt(3)])+subs(FIntegrand_3,[r,s],[1/sqrt(3),-1/sqrt(3)])+subs(FIntegrand_3,[r,s],[1/sqrt(3),1/sqrt(3)])+subs(FIntegrand_3,[r,s],[-1/sqrt(3),1/sqrt(3)]));
        FIntegrand_4=1000*N4*J;  dum4=(subs(FIntegrand_4,[r,s],[-1/sqrt(3),-1/sqrt(3)])+subs(FIntegrand_4,[r,s],[1/sqrt(3),-1/sqrt(3)])+subs(FIntegrand_4,[r,s],[1/sqrt(3),1/sqrt(3)])+subs(FIntegrand_4,[r,s],[-1/sqrt(3),1/sqrt(3)]));
    F(Connec(n,1),1)=F(Connec(n,1),1)+dum1;
    F(Connec(n,2),1)=F(Connec(n,2),1)+dum2;
    F(Connec(n,3),1)=F(Connec(n,3),1)+dum3;
    F(Connec(n,4),1)=F(Connec(n,4),1)+dum4;
end
    fprintf('\nLoad Vector Done\n')
    toc

%% ESSENTIAL BOUNDARY CONDITIONS

BNodes=[1:12 20:24 36:39 53:55 71:73 87:90 102:106 114:125];
for i=1:size(BNodes,2)
    F(BNodes(i))=0;
    K(BNodes(i),:)=0;
    K(BNodes(i),BNodes(i))=1;
end
fprintf('\nBoundary Conditions Done\n')
toc
%% SOLVING THE EQUATIONS
d=inv(K)*F;
fprintf('\nInversion of Matrix Done\n')
toc



%% COORDINATES OF NODES
Xnodes=[XG(1:8,1)' XG(8,2) XG(9:20,1)' XG(20,2) XG(21:34,1)' XG(34,2) XG(35:50,1)' XG(50,2) XG(51:66,1)' XG(66,2) XG(51:66,4)' XG(66,3) XG(67:80,4)' XG(80,3) XG(81:92,4)' XG(92,3) XG(93:100,4)' XG(100,3)];
Ynodes=[YG(1:8,1)' YG(8,2) YG(9:20,1)' YG(20,2) YG(21:34,1)' YG(34,2) YG(35:50,1)' YG(50,2) YG(51:66,1)' YG(66,2) YG(51:66,4)' YG(66,3) YG(67:80,4)' YG(80,3) YG(81:92,4)' YG(92,3) YG(93:100,4)' YG(100,3)];





%%  POST PROCESSING
% figure
% scatter(Xnodes,Ynodes)


 n1=200;n2=100;
 [X,Y] = meshgrid(linspace(min(Xnodes),max(Xnodes),n1), linspace(min(Ynodes),max(Ynodes),n2));
 Z = griddata(Xnodes,Ynodes,d,X,Y);
% % Plot a graph.
 figure
 contourf(X,Y,Z,30,'LineColor', 'none');



 xv = linspace(min(Xnodes), max(Xnodes), numel(Xnodes));
 yv = linspace(min(Ynodes), max(Ynodes), numel(Ynodes));
 [Xm,Ym] = ndgrid(xv, yv);
 Zm = griddata(Xnodes, Ynodes, d, Xm, Ym);
 figure
 surf(Xm, Ym, Zm)
 grid


%% ERROR FUNCTION

syms r s
N1=(1/4)*(1-r)*(1-s);
N2=(1/4)*(1+r)*(1-s);
N3=(1/4)*(1+r)*(1+s);
N4=(1/4)*(1-r)*(1+s);

% Num_0=0;Den_0=0; Num_1=0;Den_1=0;
% for n=1:NELM
%    x=XG(n,1)*N1+XG(n,2)*N2+XG(n,3)*N3+XG(n,4)*N4; 
%    y=YG(n,1)*N1+YG(n,2)*N2+YG(n,3)*N3+YG(n,4)*N4; %x and  y interms of r and s
%    dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y 
%     Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives
%     J=det(Mat);                                                   %JACOBIAN
%    t_an=400*(1-x^2/4-y^2);                                                   
%    temp=d(Connec(n,1))*N1+d(Connec(n,2))*N2+d(Connec(n,3))*N3+d(Connec(n,4))*N4;
%      
%    tan_1=diff(t_an,r)*drdx+diff(t_an,s)*dsdx+diff(t_an,r)*drdy+diff(t_an,s)*dsdy;
%    temp_1=diff(temp,r)*drdx+diff(temp,s)*dsdx+diff(temp,r)*drdy+diff(temp,s)*dsdy;
% 
%     Num_0Int=((temp-t_an)^2)*J;  Num_1Int=((temp_1-tan_1)^2)*J;
%     Den_0Int=((t_an)^2)*J;       Den_1Int=(tan_1^2)*J;
%     
%     
% 
%     Num_0IntDone=subs(Num_0Int,[r,s],[-sqrt(1/3),-sqrt(1/3)])+subs(Num_0Int,[r,s],[sqrt(1/3),-sqrt(1/3)])+subs(Num_0Int,[r,s],[sqrt(1/3),sqrt(1/3)])+subs(Num_0Int,[r,s],[-sqrt(1/3),sqrt(1/3)]);
%     Den_0IntDone=subs(Den_0Int,[r,s],[-sqrt(1/3),-sqrt(1/3)])+subs(Den_0Int,[r,s],[sqrt(1/3),-sqrt(1/3)])+subs(Den_0Int,[r,s],[sqrt(1/3),sqrt(1/3)])+subs(Den_0Int,[r,s],[-sqrt(1/3),sqrt(1/3)]);
%     
%    Num_1IntDone=subs(Num_1Int,[r,s],[-sqrt(1/3),-sqrt(1/3)])+subs(Num_1Int,[r,s],[sqrt(1/3),-sqrt(1/3)])+subs(Num_1Int,[r,s],[sqrt(1/3),sqrt(1/3)])+subs(Num_1Int,[r,s],[-sqrt(1/3),sqrt(1/3)]);
%    Den_1IntDone=subs(Den_1Int,[r,s],[-sqrt(1/3),-sqrt(1/3)])+subs(Den_1Int,[r,s],[sqrt(1/3),-sqrt(1/3)])+subs(Den_1Int,[r,s],[sqrt(1/3),sqrt(1/3)])+subs(Den_1Int,[r,s],[-sqrt(1/3),sqrt(1/3)]);
% 
%    Num_0=Num_0+Num_0IntDone;
%    Den_0=Den_0+Den_0IntDone;
% 
%     Num_1=Num_1+Num_0IntDone+Num_1IntDone;
%     Den_1=Den_1+Den_0IntDone+Den_1IntDone;
% end
% 
% Err_0=vpa(Num_0/Den_0,3);
% Err_0=sqrt(Err_0)
% 
% Err_1=vpa(Num_1/Den_1,3);
% Err_1=sqrt(Err_1)

%% Partial Derivative
clc
%X derivatives
x=XG(50,1)*N1+XG(50,2)*N2+XG(50,3)*N3+XG(50,4)*N4; 
y=YG(50,1)*N1+YG(50,2)*N2+YG(50,3)*N3+YG(50,4)*N4;
dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
               drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES

U1=d(53)*N1+d(54)*N2+d(71)*N3+d(70)*N4;

DU1DX=vpa(subs(diff(U1,r)*drdx+diff(U1,s)*dsdx,[r,s],[1,1]),3)

x=XG(66,1)*N1+XG(66,2)*N2+XG(66,3)*N3+XG(66,4)*N4; 
y=YG(66,1)*N1+YG(66,2)*N2+YG(66,3)*N3+YG(66,4)*N4;
dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
               drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES


U2=d(70)*N1+d(71)*N2+d(88)*N3+d(87)*N4;

DU2DX=vpa(subs(diff(U2,r)*drdx+diff(U2,s)*dsdx,[r,s],[1,-1]),3)


%Y derivatives starts
x=XG(96,1)*N1+XG(96,2)*N2+XG(96,3)*N3+XG(96,4)*N4; 
y=YG(96,1)*N1+YG(96,2)*N2+YG(96,3)*N3+YG(96,4)*N4;
dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
               drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES

U1=d(109)*N1+d(110)*N2+d(120)*N3+d(119)*N4;

DU1DY=vpa(subs(diff(U1,r)*drdy+diff(U1,s)*dsdy,[r,s],[1,1]),3)

x=XG(97,1)*N1+XG(97,2)*N2+XG(97,3)*N3+XG(97,4)*N4; 
y=YG(97,1)*N1+YG(97,2)*N2+YG(97,3)*N3+YG(97,4)*N4;
dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
               drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES


U2=d(110)*N1+d(111)*N2+d(121)*N3+d(120)*N4;

DU2DY=vpa(subs(diff(U2,r)*drdy+diff(U2,s)*dsdy,[r,s],[-1,1]),3)



