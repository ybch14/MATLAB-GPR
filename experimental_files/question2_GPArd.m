close all;clear;clc;
startup;
load planecontrol.mat;
% results
% train size =  50, length = 100, MSE = 0.1644
% train size = 100, length = 100, MSE = 0.1639
% train size = 300, length = 100, MSE = 0.0310
% train size =1000, length = 100, MSE = 0.0280
% train size =1000, length = 200, MSE = 0.0270
% train size =1000, length = 300, MSE = 0.0272
% prepare process
[N,D]=size(xtrain);
x_train=xtrain(1:300,:);y_train=ytrain(1:300,:);

% define Gaussian process model parameters
meanFunc=@meanConst;hyp.mean=0;
covFunc=@covSEard;
hyp.cov=log(ones(1,D+1));
likFunc=@likGauss;hyp.lik=log(0.1);
inference=@infVB;

hyp2=minimize(hyp,@gp,-100,inference,meanFunc,covFunc,likFunc,x_train,y_train);
tic;
[ytest,var]=gp(hyp2,inference,meanFunc,covFunc,likFunc,x_train,y_train,xtest);
toc;
disp(MSE_plane_control(ytest));