clear
%% ����1
clear;
load('question1.mat');
% ����д��������1�Ĵ���
startup;
load Question1_best_hyperparameter_GaussLik_GaussInf_GPSS_0.14243.mat hyp2
meanFunc=@meanZero;
covFunc={@covSum,{{@covProd,{@covSEiso,@covLIN}},...
                  {@covProd,{@covSEiso,@covPeriodic}},...
                  {@covProd,{@covSEiso,@covRQiso}},...
                  {@covNoise}}};
likFunc=@likGauss;
[ytest,var]=gp(hyp2,@infExact,meanFunc,covFunc,likFunc,xtrain,ytrain,xtest);

%  ����MSE
% ytest  = zeros(size(xtest, 1), 1);
mse = MSE_question2(ytest);

%% ����2
clear;
load('planecontrol.mat');
% ����д��������2�Ĵ���
startup;
load Question2_best_hyperparameter_GaussWarpLik_LaplaceInf_GPArd_0.026362.mat hyp2
[N,D]=size(xtrain);
x_train=xtrain(1:1000,:);y_train=ytrain(1:1000,:);R=5;
meanFunc=@meanConst;
covFunc=@covSEard;
hyp.cov=log(ones(1,D+1));
likFunc={@likGaussWarp,'tanh10'};
hyp.lik=log(0.1)*ones(1,31);
inference=@infLaplace;
[ytest,var]=gp(hyp2,inference,meanFunc,covFunc,likFunc,x_train,y_train,xtest);
%  ����MSE
%ytest  = zeros(size(xtest, 1), 1);
mse = MSE_plane_control(ytest);
