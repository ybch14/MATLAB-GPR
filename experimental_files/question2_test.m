close all;clear;clc;
startup;
load planecontrol.mat;
load ../Question2_best_parameter_hyper_GaussWarpLik_Laplaceinf_GPArd_0.026362.mat hyp2
[N,D]=size(xtrain);
x_train=xtrain(1:1000,:);y_train=ytrain(1:1000,:);R=5;
meanFunc=@meanConst;
covFunc=@covSEard;
hyp.cov=log(ones(1,D+1));
likFunc={@likGaussWarp,'tanh10'};
hyp.lik=log(0.1)*ones(1,31);
inference=@infLaplace;
tic;
[ytest,var]=gp(hyp2,inference,meanFunc,covFunc,likFunc,x_train,y_train,xtest);
toc;
disp(['MSE=',num2str(MSE_plane_control(ytest))]);