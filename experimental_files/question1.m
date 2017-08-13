close all;clear;clc;
startup;
load question1.mat;
% plot(xtrain,ytrain);

meanFunc=@meanZero;
% kernel function from simple constructions
% 03 hyperparameters, MSE 46.5174, length 100
covFunc1={@covSum,{@covLIN,{@covPER,'iso',{@covSEiso}}}};
% 06 hyperparameters, MSE 46.5090, length 200
covFunc2={@covSum,{@covConst,{@covPoly,'eye',1},@covPeriodic}};

% kernel function from reference 2 & 3
% 12 hyperparameters, MSE 00.1733, length 110
covFunc3={@covSum,{{@covProd,{@covSEiso,@covLIN}},...
                  {@covProd,{@covSEiso,@covPeriodic}},...
                  {@covProd,{@covSEiso,@covRQiso}}}};
% 13 hyperparameters, MSE 00.1433, length 180
covFunc4={@covSum,{{@covProd,{@covSEiso,@covLIN}},...
                  {@covProd,{@covSEiso,@covPeriodic}},...
                  {@covProd,{@covSEiso,@covRQiso}},...
                  {@covNoise}}};
likFunc=@likGauss;

% use Gauss inference for Gauss likehood function
subplot(2,2,1);
hyp11=struct('mean',[],'cov',zeros(1,3),'lik',-1);
hyp21=minimize(hyp11,@gp,100,@infGaussLik,meanFunc,covFunc1,likFunc,xtrain,ytrain);
[ytest1,var1]=gp(hyp21,@infGaussLik,meanFunc,covFunc1,likFunc,xtrain,ytrain,xtest);
f=[ytest1+2*sqrt(var1); flip(ytest1-2*sqrt(var1),1)];
fill([xtest; flip(xtest,1)], f, [7/8,7/8,7/8], 'EdgeColor', [1,1,1])
hold on;plot(xtest,ytest1,'b');
plot(xtrain(length(xtrain)/9*7:end),ytrain(length(ytrain)/9*7:end),'r');
title({['Kernel: LIN+PER'];['MSE: ',num2str(MSE_question2(ytest1))]},'FontName','Times New Roman');

subplot(2,2,2);
hyp12=struct('mean',[],'cov',zeros(1,6),'lik',-1);
hyp22=minimize(hyp12,@gp,200,@infGaussLik,meanFunc,covFunc2,likFunc,xtrain,ytrain);
[ytest2,var2]=gp(hyp22,@infGaussLik,meanFunc,covFunc2,likFunc,xtrain,ytrain,xtest);
f=[ytest2+2*sqrt(var2); flip(ytest2-2*sqrt(var2),1)];
fill([xtest; flip(xtest,1)], f, [7/8,7/8,7/8], 'EdgeColor', [1,1,1])
hold on;plot(xtest,ytest2,'b');
plot(xtrain(length(xtrain)/9*7:end),ytrain(length(ytrain)/9*7:end),'r');
title({['Kernel: POLY+CONST+PER'];['MSE: ',num2str(MSE_question2(ytest2))]},'FontName','Times New Roman');

subplot(2,2,3);
hyp13=struct('mean',[],'cov',zeros(1,12),'lik',-1);
hyp23=minimize(hyp13,@gp,110,@infGaussLik,meanFunc,covFunc3,likFunc,xtrain,ytrain);
[ytest3,var3]=gp(hyp23,@infGaussLik,meanFunc,covFunc3,likFunc,xtrain,ytrain,xtest);
f=[ytest3+2*sqrt(var3); flip(ytest3-2*sqrt(var3),1)];
fill([xtest; flip(xtest,1)], f, [7/8,7/8,7/8], 'EdgeColor', [1,1,1])
hold on;plot(xtest,ytest3,'b');
plot(xtrain(length(xtrain)/9*7:end),ytrain(length(ytrain)/9*7:end),'r');
title({['Kernel: LIN\timesSE+SE\times(PE+RQ)'];['MSE: ',num2str(MSE_question2(ytest3))]},'FontName','Times New Roman');

subplot(2,2,4);
hyp14=struct('mean',[],'cov',zeros(1,13),'lik',-1);
hyp24=minimize(hyp14,@gp,180,@infGaussLik,meanFunc,covFunc4,likFunc,xtrain,ytrain);
[ytest4,var4]=gp(hyp24,@infGaussLik,meanFunc,covFunc4,likFunc,xtrain,ytrain,xtest);
f=[ytest4+2*sqrt(var4); flip(ytest4-2*sqrt(var4),1)];
fill([xtest; flip(xtest,1)], f, [7/8,7/8,7/8], 'EdgeColor', [1,1,1])
hold on;plot(xtest,ytest4,'b');
plot(xtrain(length(xtrain)/9*7:end),ytrain(length(ytrain)/9*7:end),'r');
title({['Kernel: LIN\timesSE+SE\times(PE+RQ)+WN'];['MSE: ',num2str(MSE_question2(ytest4))]},'FontName','Times New Roman');