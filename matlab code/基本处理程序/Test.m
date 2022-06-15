%% 实验通道间的时间变化是否蕴含信息
% clear;
% name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];
% list1 = [2 16 17 5 7 10 12 14 2 3 1 5 7 6 8 4 16 17 18 19];
% list2 = [3 18 19 6 8 11 13 15 7 8 4 10 12 11 13 9 10 11 12 13];
% for namei = 1:12
%     A = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\'+name(namei)+'wave300_50s.mat');
%     channel = size(A.coefs_channel_trial,3);
%     trials = size(A.coefs_channel_trial,4);
%     chanum = channel;
%     coefs_channel_trial(:,:,1:19,:) = A.coefs_channel_trial;
%     for num = 1:size(list1,2)
%         chanum = chanum+1;
%         TEMP = A.coefs_channel_trial(:,:,list1(num),:) - A.coefs_channel_trial(:,:,list2(num),:);
%         MINX = min(min(TEMP));
%         MAXX = max(max(TEMP));
%         for i = 1:trials
%             coefs_channel_trial(:,:,chanum,i) = (TEMP(:,:,1,i)-MINX(1,1,1,i))./(MAXX(1,1,1,i) -MINX(1,1,1,i))*255;
%         end   
%         clear TEMP MINX MAXX;
%     end
%     label300 = A.label300;
%     path = 'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\cross\'+name(namei)+'wave300_50s_cross.mat';
%     save(path,'coefs_channel_trial','label300');
%     clear A channel trials chanum coefs_channel_trial num; 
% end
% %% 改变数据格式方便进行3D-CNN
% clear;
% name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];% 
% for namei = 1:12
%     pathA = 'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\'+name(namei)+'wave300_50s.mat';
%     A = load(pathA);
%     FREQ = size(A.coefs_channel_trial,1);
%     TIME = size(A.coefs_channel_trial,2);
%     CHANNEL = size(A.coefs_channel_trial,3);
%     TRIAL = size(A.coefs_channel_trial,4);
%     label300 = A.label300;
%     coefs_channel_trial = zeros(TRIAL,8,14,TIME,FREQ);
%     for i = 1:TRIAL
%             for t = 1:TIME
%                 for f = 1:FREQ
% %                   coefs_channel_trial(i,9,5,t,j) = A.coefs_channel_trial(f,t,18,i);
% %                   coefs_channel_trial(i,9,7,t,j) = A.coefs_channel_trial(f,t,16,i);
% %                   coefs_channel_trial(i,9,9,t,j) = A.coefs_channel_trial(f,t,17,i);
% %                   coefs_channel_trial(i,9,11,t,j) = A.coefs_channel_trial(f,t,19,i);
%                     for r = 1:2
%                         for c = 3:4
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,2,i);
%                         end
%                         for c = 7:8
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,1,i);
%                         end
%                         for c = 11:12
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,3,i);
%                         end
%                     end
%                     for r = 3:4
%                         for c = 3:4
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,7,i);
%                         end
%                         for c = 5:6
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,5,i);
%                         end
%                         for c = 7:8
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,4,i);
%                         end
%                         for c = 9:10
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,6,i);
%                         end
%                         for c = 11:12
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,8,i);
%                         end
%                     end
%                     for r = 5:6
%                         for c = 1:2
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,14,i);
%                         end
%                         for c = 3:4
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,12,i);
%                         end
%                         for c = 5:6
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,10,i);
%                         end
%                         for c = 7:8
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,9,i);
%                         end
%                         for c = 9:10
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,11,i);
%                         end
%                         for c = 11:12
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,13,i);
%                         end
%                         for c = 13:14
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,15,i);
%                         end
%                     end
%                     for r = 7:8
%                         for c = 3:4
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,18,i);
%                         end
%                         for c = 5:6
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,16,i);
%                         end
%                         for c = 9:10
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,17,i);
%                         end
%                         for c = 11:12
%                             coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,19,i);
%                         end
%                     end
%                 end
%             end
%     end
%     coefs_channel_trial = permute(coefs_channel_trial,[5 4 3 2 1]);
%     pathB = 'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\'+name(namei)+'wave3DCNN_s.mat';
%     save(pathB,'coefs_channel_trial','label300');
% end
% 
% 
% %% 改变数据格式方便进行3D-CNNconfusion
% clear;
% name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];% 
% for namei = 1:12
%     pathA = 'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\'+name(namei)+'wave300_50s.mat';
%     A = load(pathA);
%     FREQ = size(A.coefs_channel_trial,1);
%     TIME = size(A.coefs_channel_trial,2);
%     CHANNEL = size(A.coefs_channel_trial,3);
%     TRIAL = size(A.coefs_channel_trial,4);
%     label300 = A.label300;
%     coefs_channel_trial = zeros(TRIAL,19,19,TIME,FREQ);
%     for i = 1:TRIAL
%             for t = 1:TIME
%                 for f = 1:FREQ
%                     for r = 1:CHANNEL
%                         for c = 1:CHANNEL
%                             coefs_channel_trial(i,r,c,t,f) = (A.coefs_channel_trial(f,t,r,i)+A.coefs_channel_trial(f,t,c,i))/(2*exp(abs(A.coefs_channel_trial(f,t,r,i)-A.coefs_channel_trial(f,t,c,i))));
%                         end
%                     end      
%                 end
%             end
%     end
%     coefs_channel_trial = permute(coefs_channel_trial,[5 4 3 2 1]);
%     pathB = 'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\'+name(namei)+'waveconfusion3DCNN_s.mat';
%     save(pathB,'coefs_channel_trial','label300');
% end

%%
%对200ms的数据进行小波分析并输出coefs_channel_trial
% 将尺度转换为频率后求得的时间-频率图
fs=1000;    %采样频率
dt=1/fs;    %时间精度
t=1/fs:1/fs:0.3;
load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\zc\zcdata300_50s.mat')
channel = size(signal300,1);
timeline = size(signal300,2);
trial = size(signal300,3);
n =0;
for i = 4
    for j = 1:channel
        n=n+1;
        z=signal300(j,:,i);
        %figure(1)
        %plot(z);
        wavename='db4'; %可变参数，分别为db1的
        %举一个频率转尺度的例子
        fmin=1;
        fmax=43;
        df=1;%0.1
        f=fmax-df:-df:fmin;%预期的频率
        wcf=centfrq(wavename); %小波的中心频率
        scal=fs*wcf./f;%利用频率转换尺度
        coefs = cwt(z,scal,wavename);
        figure(n);
        pcolor(t,f,coefs);shading interp    
    end
end