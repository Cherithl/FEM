clear all 
clc
tic;
NELM=416;

%% MESH AND CONNECTIVITY MATRIX
h=1/8;

XG=zeros(NELM,4); 
YG=zeros(NELM,4);
Connec=zeros(NELM,4);
for n=1:NELM     %FIX THE CONNECTIVITY ARRAY YOU DIDNT CHANGE AFTER PASTING 
 1;   if n<=12
        Connec(n,1)=n;Connec(n,2)=n+1;Connec(n,3)=18+n;Connec(n,4)=17+n;        
        XG(n,1)=-7*h+n*h;XG(n,2)=-6*h+n*h;XG(n,3)=-6*h+n*h;XG(n,4)=-7*h+n*h; 
        YG(n,1)=-8*h;YG(n,2)=-8*h;YG(n,3)=-7*h;YG(n,4)=-7*h;
 2;   elseif n<=32
        Connec(n,1)=n+1;Connec(n,2)=n+2;Connec(n,3)=25+n;Connec(n,4)=24+n;
        XG(n,1)=-11*h+(n-12)*h;XG(n,2)=-10*h+(n-12)*h;XG(n,3)=-10*h+(n-12)*h;XG(n,4)=-11*h+(n-12)*h;
        YG(n,1)=-7*h;YG(n,2)=-7*h;YG(n,3)=-6*h;YG(n,4)=-6*h;
 3;   elseif n<=56
        Connec(n,1)=n+2;Connec(n,2)=n+3;Connec(n,3)=n+30;Connec(n,4)=n+29;
        XG(n,1)=-13*h+(n-32)*h;XG(n,2)=-12*h+(n-32)*h;XG(n,3)=-12*h+(n-32)*h;XG(n,4)=-13*h+(n-32)*h;
        YG(n,1)=-6*h;YG(n,2)=-6*h;YG(n,3)=-5*h;YG(n,4)=-5*h;
 4;   elseif n<=84
        Connec(n,1)=n+3;Connec(n,2)=n+4;Connec(n,3)=n+34;Connec(n,4)=n+33;
        XG(n,1)=-15*h+(n-56)*h;XG(n,2)=-14*h+(n-56)*h;XG(n,3)=-14*h+(n-56)*h;XG(n,4)=-15*h+(n-56)*h;
        YG(n,1)=-5*h;YG(n,2)=-5*h;YG(n,3)=-4*h;YG(n,4)=-4*h;
 5;   elseif n<=114
        Connec(n,1)=n+4;Connec(n,2)=n+5;Connec(n,3)=n+36;Connec(n,4)=n+35;
        XG(n,1)=-16*h+(n-84)*h;XG(n,2)=-15*h+(n-84)*h;XG(n,3)=-15*h+(n-84)*h;XG(n,4)=-16*h+(n-84)*h;
        YG(n,1)=-4*h;YG(n,2)=-4*h;YG(n,3)=-3*h;YG(n,4)=-3*h;
 6;   elseif n<=144
        Connec(n,1)=n+5;Connec(n,2)=n+6;Connec(n,3)=n+38;Connec(n,4)=n+37;
        XG(n,1)=-16*h+(n-114)*h;XG(n,2)=-15*h+(n-114)*h;XG(n,3)=-15*h+(n-114)*h;XG(n,4)=-16*h+(n-114)*h;
        YG(n,1)=-3*h;YG(n,2)=-3*h;YG(n,3)=-2*h;YG(n,4)=-2*h;
 7;   elseif n<=176
        Connec(n,1)=n+6;Connec(n,2)=n+7;Connec(n,3)=n+40;Connec(n,4)=n+39;
        XG(n,1)=-17*h+(n-144)*h;XG(n,2)=-16*h+(n-144)*h;XG(n,3)=-16*h+(n-144)*h;XG(n,4)=-17*h+(n-144)*h;
        YG(n,1)=-2*h;YG(n,2)=-2*h;YG(n,3)=-h;YG(n,4)=-h;
 8;   elseif n<=208
        Connec(n,1)=n+7;Connec(n,2)=n+8;Connec(n,3)=n+41;Connec(n,4)=40+n;
        XG(n,1)=-17*h+(n-176)*h;XG(n,2)=-16*h+(n-176)*h;XG(n,3)=-16*h+(n-176)*h;XG(n,4)=-17*h+(n-176)*h;
        YG(n,1)=-h;YG(n,2)=-h;YG(n,3)=0;YG(n,4)=0;
 9;   elseif n<=240
        Connec(n,1)=n+8;Connec(n,2)=n+9;Connec(n,3)=n+42;Connec(n,4)=n+41;
        XG(n,1)=-17*h+(n-208)*h;XG(n,2)=-16*h+(n-208)*h;XG(n,3)=-16*h+(n-208)*h;XG(n,4)=-17*h+(n-208)*h;
        YG(n,1)=0;YG(n,2)=0;YG(n,3)=h;YG(n,4)=h;
 10;   elseif n<=272
        Connec(n,1)=n+9;Connec(n,2)=n+10;Connec(n,3)=n+43;Connec(n,4)=n+42;
        XG(n,1)=-17*h+(n-240)*h;XG(n,2)=-16*h+(n-240)*h;XG(n,3)=-16*h+(n-240)*h;XG(n,4)=-17*h+(n-240)*h;
        YG(n,1)=h;YG(n,2)=h;YG(n,3)=2*h;YG(n,4)=2*h;
  11;  elseif n<=302
        Connec(n,1)=n+11;Connec(n,2)=n+12;Connec(n,3)=n+44;Connec(n,4)=n+43;
        XG(n,1)=-16*h+(n-272)*h;XG(n,2)=-15*h+(n-272)*h;XG(n,3)=-15*h+(n-272)*h;XG(n,4)=-16*h+(n-272)*h;
        YG(n,1)=2*h;YG(n,2)=2*h;YG(n,3)=3*h;YG(n,4)=3*h;
  12;  elseif n<=332
        Connec(n,1)=n+13;Connec(n,2)=n+14;Connec(n,3)=n+45;Connec(n,4)=n+44;
        XG(n,1)=-16*h+(n-302)*h;XG(n,2)=-15*h+(n-302)*h;XG(n,3)=-15*h+(n-302)*h;XG(n,4)=-16*h+(n-302)*h;
        YG(n,1)=3*h;YG(n,2)=3*h;YG(n,3)=4*h;YG(n,4)=4*h;
  13;    elseif n<=360
        Connec(n,1)=n+15;Connec(n,2)=n+16;Connec(n,3)=n+46;Connec(n,4)=n+45;
        XG(n,1)=-15*h+(n-332)*h;XG(n,2)=-14*h+(n-332)*h;XG(n,3)=-14*h+(n-332)*h;XG(n,4)=-15*h+(n-332)*h;
        YG(n,1)=4*h;YG(n,2)=4*h;YG(n,3)=5*h;YG(n,4)=5*h;
  14;     elseif n<=384
        Connec(n,1)=n+19;Connec(n,2)=n+20;Connec(n,3)=n+47;Connec(n,4)=n+46;
        XG(n,1)=-13*h+(n-360)*h;XG(n,2)=-12*h+(n-360)*h;XG(n,3)=-12*h+(n-360)*h;XG(n,4)=-13*h+(n-360)*h;
        YG(n,1)=5*h;YG(n,2)=5*h;YG(n,3)=6*h;YG(n,4)=6*h;
   15; elseif n<=404
        Connec(n,1)=n+24;Connec(n,2)=n+25;Connec(n,3)=n+48;Connec(n,4)=n+47;
        XG(n,1)=-11*h+(n-384)*h;XG(n,2)=-10*h+(n-384)*h;XG(n,3)=-10*h+(n-384)*h;XG(n,4)=-11*h+(n-384)*h;
        YG(n,1)=6*h;YG(n,2)=6*h;YG(n,3)=7*h;YG(n,4)=7*h;
   16; else 
        Connec(n,1)=n+31;Connec(n,2)=n+32;Connec(n,3)=n+49;Connec(n,4)=n+48;
        XG(n,1)=-7*h+(n-404)*h;XG(n,2)=-6*h+(n-404)*h;XG(n,3)=-6*h+(n-404)*h;XG(n,4)=-7*h+(n-404)*h;
        YG(n,1)=7*h;YG(n,2)=7*h;YG(n,3)=8*h;YG(n,4)=8*h;
    end
end
Connec;

figure
plot(XG,YG)


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
K=zeros(465);

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
F=zeros(465,1);
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

BNodes=[1:18 30:37 57:62 86:90 118:120 150:152 182:184 216,217 249,250 282:284 314:316 346:348 376:380 404:409 429:436 448:465];
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
Xnodes=zeros(465,1);
Ynodes=zeros(465,1);
for i=1:NELM
    for j=1:4
        global_node=Connec(i,j);
        Xnodes(global_node)=XG(i,j);
        Ynodes(global_node)=YG(i,j);
    end
end





%%  POST PROCESSING
% figure
% scatter(Xnodes,Ynodes)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Set plot stuff:
set(0,'DefaultLineLineWidth',1.5)
set(0,'DefaultLineColor',[1,1,1])
set(0,'DefaultLineMarkerSize',15)
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultFigureColor',[1,1,1])
set(0,'DefaultTextFontSize',26)
set(0,'DefaultTextInterpreter','latex')
set(0,'DefaultTextFontName','Arial')%Times-Roman')
set(0,'DefaultAxesFontName','Arial')%Times-Roman')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 n1=200;n2=100;
 [X,Y] = meshgrid(linspace(min(Xnodes),max(Xnodes),n1), linspace(min(Ynodes),max(Ynodes),n2));
 Z = griddata(Xnodes,Ynodes,d,X,Y);
% % Plot a graph.
 figure
 fig=contourf(X,Y,Z,30,'LineColor', 'none');
 %set(fig,'EdgeColor','none')


 xv = linspace(min(Xnodes), max(Xnodes), numel(Xnodes));
 yv = linspace(min(Ynodes), max(Ynodes), numel(Ynodes));
 [Xm,Ym] = ndgrid(xv, yv);
 Zm = griddata(Xnodes, Ynodes, d, Xm, Ym);
 figure
 fig=surf(Xm, Ym, Zm)
 set(fig,'EdgeColor','none')



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
%      Num_1=Num_1+Num_0IntDone+Num_1IntDone;
%      Den_1=Den_1+Den_0IntDone+Den_1IntDone;
% end
% 
% Err_0=vpa(Num_0/Den_0,3);
% Err_0=sqrt(Err_0)
% 
% Err_1=vpa(Num_1/Den_1,3);
% Err_1=sqrt(Err_1)

%% PARTIAL DERIVATIVE CALCULATION

% first element for dudx 208 nodes are 215 216 249 248
%Second element for dudx 240 nodes are 248 249 282 281

% first element for dudy 410 nodes are 441 442 459 458
%Second element for dudy 411 nodes are 442 443 460 459
clc

x=XG(208,1)*N1+XG(208,2)*N2+XG(208,3)*N3+XG(208,4)*N4; 
y=YG(208,1)*N1+YG(208,2)*N2+YG(208,3)*N3+YG(208,4)*N4;
dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
               drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES

U1=d(215)*N1+d(216)*N2+d(249)*N3+d(248)*N4;

DU1DX=vpa(subs(diff(U1,r)*drdx+diff(U1,s)*dsdx,[r,s],[1,1]),3)

x=XG(240,1)*N1+XG(240,2)*N2+XG(240,3)*N3+XG(240,4)*N4; 
y=YG(240,1)*N1+YG(240,2)*N2+YG(240,3)*N3+YG(240,4)*N4;
dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
               drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES


U2=d(248)*N1+d(249)*N2+d(282)*N3+d(281)*N4;

DU2DX=vpa(subs(diff(U2,r)*drdx+diff(U2,s)*dsdx,[r,s],[1,-1]),3)

x=XG(410,1)*N1+XG(410,2)*N2+XG(410,3)*N3+XG(410,4)*N4; 
y=YG(410,1)*N1+YG(410,2)*N2+YG(410,3)*N3+YG(410,4)*N4;
dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
               drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES

U1=d(441)*N1+d(442)*N2+d(459)*N3+d(458)*N4;

DU1DY=vpa(subs(diff(U1,r)*drdy+diff(U1,s)*dsdy,[r,s],[1,1]),3)

x=XG(411,1)*N1+XG(411,2)*N2+XG(411,3)*N3+XG(411,4)*N4; 
y=YG(411,1)*N1+YG(411,2)*N2+YG(411,3)*N3+YG(411,4)*N4;
dxdr=diff(x,r);dxds=diff(x,s);dydr=diff(y,r);dyds=diff(y,s);  % partial derivatives of x and y               
              Mat=[dxdr,dxds;   dydr,dyds];                                 % matrix with derivatives              
              J=det(Mat);                                                   %JACOBIAN
               drdx=(1/J)*dyds ; dsdx=-(1/J)*dydr; drdy=(-1/J)*dxds; dsdy=(1/J)*dxdr;    %INVERSE DERIVATIVES


U2=d(442)*N1+d(443)*N2+d(460)*N3+d(449)*N4;

DU2DY=vpa(subs(diff(U2,r)*drdy+diff(U2,s)*dsdy,[r,s],[-1,1]),3)





