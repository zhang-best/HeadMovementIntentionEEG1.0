%% 连接静息态和工作态的小波变换数据形成神经网络训练测试集
clear;
A = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\fww\fwwwave300control.mat');
B = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\fww\fwwwave300.mat');
a = size(A.coefs_channel_trial,1);
b = size(A.coefs_channel_trial,2);
c = size(A.coefs_channel_trial,3);
d = size(A.coefs_channel_trial,4);
coefs_channel_trial(:,:,:,1:d) = A.coefs_channel_trial(:,:,:,1:d);
coefs_channel_trial(:,:,:,d+1:2*d) = B.coefs_channel_trial(:,:,:,1:d);
label300(1:d,1) = 0;
label300(d+1:2*d,1) = 1;
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\fww\fwwwave300cs','coefs_channel_trial','label300');
