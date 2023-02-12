clear
clc
filename = 'r1080.dat';
A=importdata(filename);
X=A.data(:,1);
Y=A.data(:,2);

Xnew=zeros(1,118);
Ynew=zeros(1,118);
for i=1:60
    Xnew(i)=X(62-i);
    Ynew(i)=Y(62-i);
    for j=63:120
        Xnew(j-2)=X(j);
        Ynew(j-2)=Y(j);
    end ,clear i,clear j;
end
figure(1)
plot(Xnew, Ynew)   , axis image



%Circular cylinder example, radius 2, 35 panels
z=1*Xnew+1*i*Ynew;npanels=length(z);k=npanels;winf=exp(-i*7*pi/180);
a=[1:npanels];b=[2:npanels 1];c=[3:npanels 1 2];
dzds=(z(b)-z(a))./abs(z(b)-z(a));
eps=0.0001;
zc=(z(a)+z(b))/2-i*eps*(z(b)-z(a)); %control points
figure (2)
plot(real(zc),imag(zc)), axis image

cm=zeros(npanels);
for m=1:npanels
cm(:,m)=-i*(((zc(m)-z(a))./(z(b)-z(a)).*log((zc(m)-z(a))./(zc(m)-z(b)))-1)./dzds(a)/2/pi...
           -((zc(m)-z(c))./(z(b)-z(c)).*log((zc(m)-z(c))./(zc(m)-z(b)))-1)./dzds(b)/2/pi)*dzds(m);
end
res=imag(-winf*dzds);
cm1=imag(cm);cm1(:,end)=0;cm1(k,end)=1;
res(end)=0;
q=res/cm1;

ut=real(q*cm+winf*dzds);
cp=1-ut.^2/abs(winf).^2;
chordlength=max(real(zc))-min(real(zc));
figure
plot(real(zc)/chordlength,-cp,'.-'); ylim([-1 3]), ylabel('-cp'), xlabel('(x/c)')
%Cm=0;
%for i=1:length(zc)
%    Cm=(Cm+cp(i)*(real(zc(i))-1/4)*real(dzds(i))+cp(i)*(imag(zc(i)))*imag(dzds(i)))*abs(z(b(i))-z(a(i)));  
%end





