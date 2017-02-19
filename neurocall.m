function [a1,a2]=neurocall(data)

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('TOLERANCE VALUE = 0.0001');

[nset l]=size(data);
l=11;
n=1;        
tol=0.0005;
error=Inf;
a=-1;b=1;
m=11;

v=xlsread('v.xls');
w=xlsread('w.xls');
a1=v;
a2=w;
flag=0;
nv=zeros(11,11);
nw=zeros(11,1);
epochs=0;
disp('');
disp('Processing............');


while error>=tol
    
    for k=1:nset
         %disp(sprintf('CALCULATION FOR %d TRAINING SET',k));
        [v,w,nv,nw,Ep(k),temp]=neural(data(k,:),nv,nw,v,w,l,m,flag); 
    end

    sum_error=sum(Ep);
       
    error=sum_error/nset;
    error;
    epochs=epochs+1;
    
end

disp(sprintf('Number of epochs: %d',epochs));

disp('FINAL WEIGHTS:');

%v
%w

disp('');
%testing
testset=xlsread('test.xls');
[p,q]=size(testset);
p;
q;


dat1(:,1)=testset(:,13);
 
 testset1=normc(testset(:,2:q));
 testset(:,2:q)=testset1;
 testset;
 [n,l]=size(testset); 
 l=11;
 m=5;

%Accuracy calculation 
 
tp=0;tn=0;fp=0;fn=0;

for i=1:n
        Ii(1:l,1)=0;
        Oi(1:l,1)=0;
        [a b]=size(v');
        Ih(1:a,1)=0;
        Ii(:,1)=testset(i,2:12)';
        Oi(:,1)=Ii(:,1);
        Ih(:,1)=v'*Oi(:,1);
        Oh=sigmf(Ih,[1 0]);
        Io(:,1)=w'*Oh(:,1);
        Oo=sigmf(Io,[1 0]);
        Oo;
        testset(i,14)=Oo;
 end    
    
pop=testset(:,13:14);
pop(:,3)=dat1(:,1);


for i=1:1:n
    
    if(pop(i,2)>=0.1)
        pop(i,4)=2;
        else
        pop(i,4)=4;
    end
    
    if(pop(i,4)==2)
        disp(sprintf('Curable Breast Cancer'));
    
        else
            disp(sprintf('Severe Breast Cancer'));
     end
end

 
pop;

tp=0;tn=0;fp=0;fn=0;
for i=1:n
     if(pop(i,3)==2 && pop(i,4)==2)
         tp=tp+1;
     end
     if((pop(i,3)==2 && pop(i,4)==4)|(pop(i,3)==4 && pop(i,4)==2))
         tn=tn+1;
     end
     if(pop(i,3)==2 && (pop(i,4)==4 | pop(i,4)==2))
         fp=fp+1;
     end
     if((pop(i,3)==4 | pop(i,3)==2) && pop(i,4)==2)
         fn=fn+1;
     end
end
 Acc = ((tp + tn) / (tp + tn + fp + fn))*100;                                                                                                                                                                                                                                                                                                                                                                                      
 disp('Accuracy:');
 disp(Acc);        