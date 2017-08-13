close all;clear;clc;
startup;
load question1.mat;
load ../Question1_best_parameter_hyper_GaussLik_Gaussinf_GPSS_0.14243.mat hyp2
meanFunc=@meanZero;
covFunc={@covSum,{{@covProd,{@covSEiso,@covLIN}},...
                  {@covProd,{@covSEiso,@covPeriodic}},...
                  {@covProd,{@covSEiso,@covRQiso}},...
                  {@covNoise}}};
likFunc=@likGauss;
tic;
[ytest,var]=gp(hyp2,@infExact,meanFunc,covFunc,likFunc,xtrain,ytrain,xtest);
toc;
disp(['MSE=',num2str(MSE_question2(ytest))]);