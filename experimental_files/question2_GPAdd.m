close all;clear;clc;
startup;
load planecontrol.mat;
% results
% R =  5, train_size =  50, length = 100, MSE = 0.0888
% R =  5, train_size = 100, length = 100, MSE = 0.0682
% R =  5, train_size = 300, length = 100, MSE = 0.0508
% R =  5, train_size =1000, length = 100, MSE = 0.0437
% R =  1, train_size =  50, length = 100, MSE = 0.0431
% R =  1, train_size = 100, length = 100, MSE = 0.0469
% R =  1, train_size = 300, length = 100, MSE = 0.0354
% R =  1, train_size =1000, length = 100, MSE = 0.0317
% prepare process
x_train=xtrain(1:300,:);y_train=ytrain(1:300,:);
[N,D]=size(x_train);R=1;
% define gaussian processes model parameters
meanFunc=@meanConst;hyp.mean=0;
% Additive Gaussian Processes Kernel
covFunc={@covADD,{1:R,'covSEiso'}};
hyp.cov = [log(ones(1,2*D)),log(ones(1,R))];
likFunc=@likT;hyp.lik = [log(0.1),log(0.1)];
inference=@infMCMC;

hyp2=minimize(hyp,@gp,-100,inference,meanFunc,covFunc,likFunc,x_train,y_train);
tic;
[ytest,var]=gp(hyp2,inference,meanFunc,covFunc,likFunc,x_train,y_train,xtest);
toc;
disp(MSE_plane_control(ytest));