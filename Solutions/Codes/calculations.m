a=[1,1/2,1/3,1/4,-1;1/2,10,41/12,67/20,-2;1/3,41/12,23/15,5/3,-1;1/4,67/20,5/3,68/35,-1;1,2,1,1,0]
b=[-1;4;2/3;1/2;2]
c=inv(a)
d=c*b


derivative=(0.9967*3)-(1.0772*2)+(0.3719*3)
x=1;
derivative2=(0.9967*3)-(2*1.0772*(x))+(3*0.3719*(x)^2)