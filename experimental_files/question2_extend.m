close all;clear;clc;
startup;
load planecontrol.mat;
[N,D]=size(xtrain);
x_train=xtrain(1:300,:);y_train=ytrain(1:300,:);

meanFunc=@meanConst;hyp.mean=0;
covFunc=@covSEard;
hyp.cov=log(ones(1,D+1));
likFunc={@likGaussWarp,'tanh3'};
hyp.lik=log(0.1)*ones(1,10);
inference=@infLaplace;

hyp2=minimize(hyp,@gp,-1000,inference,meanFunc,covFunc,likFunc,x_train,y_train);
tic;
[my_ytest,var]=gp(hyp2,inference,meanFunc,covFunc,likFunc,x_train,y_train,xtest);
toc;
disp(['MSE=',num2str(MSE_plane_control(my_ytest))]);
