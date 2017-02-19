function [v,w,nv,nw,Ep,Oo]=neural(data,nv,nw,v,w,l,m,flag)
n=1;
ne=0.9;
alp=0.2;
Ii(1:l,1)=0;
Oi(1:l,1)=0;
[a b]=size(v');
Ih(1:a,1)=0;
Ii(:,1)=data(:,2:12);


data(:,11);
Oi(:,1)=Ii(:,1);
Ih(:,1)=v'*Oi(:,1); 
Oh=sigmf(Ih,[1 0]);

Io(:,1)=w'*Oh(:,1);
Oo=sigmf(Io,[1 0]);
Ep=1/2*(data(1,13)-Oo)^2; % error at a point = (target value-obtained value)2


d=(data(1,13)-Oo).*Oo.*(1-Oo); % delta

y=Oh*d'; 
nw=alp*nw+ne*y; % new weight
e=w*d; 
dstar=e.*Oh.*(1-Oh);

X=Oi*dstar';

nv=alp*nv+ne*X;
w=w+nw;

v=v+nv;




