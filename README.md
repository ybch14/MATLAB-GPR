- ./experimental_files/: 仿真时用到的实验文件目录
- ./gpml-matlab/: GPML库函数目录
- ./data_read_and_MSE.m: 可以一键运行的脚本
- ./MSE_plane_control.p & ./MSE_question2.p: 计算MSE的代码
- ./Question1_best_hyperparameter_GaussLik_GaussInf_GPSS_0.14243.mat: 
    对应问题1的经过训练的最优超参数
- ./Question2_best_hyperparameter_GaussWarpLik_LaplaceInf_GPArd_0.026362.mat：
    对应问题2的经过训练的最优超参数
（由于训练过程需要调整优化步数，而优化步数在不同机器上需要的值不同，所以为了一次性得出最好结果，我将训练得到的最好结果对应的超参数保存了下来，在运行时直接load并进行预测。具体训练过程可以参见./experimental_files 目录下的代码，具体使用的核函数等参见data_read_and_MSE.m及实验报告）
- ./startup.m: GPML库的初始化函数，在./data_read_and_MSE.m 中调用了此脚本。
- ./高斯过程回归实验报告.pdf: 本次大作业的实验报告。