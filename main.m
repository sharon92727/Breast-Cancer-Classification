
clc;
clear all;
format long;

%loading the dataset

dataset=xlsread('train.xls');
[n,m]=size(dataset);


%11 input neurons
%5  hidden neurons




dataset;
dataset1=normc(dataset(:,2:m));
[x,y]=size(dataset1);
dataset(:,2:m)=dataset1;
[v,w]=neurocall(dataset);






