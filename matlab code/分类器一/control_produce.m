load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\zzh\zzhdata.mat');
%提取段落前200ms
import_time = 300;
num = 0;
control300(1:19,1:300,:) = signal(3:21,201:500,:);
label300 = label;
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\zzh\zzhdata300control','control300','label300');

fs=1000;    %采样频率
dt=1/fs;    %时间精度
t=1/fs:1/fs:0.3;
channel = size(control300,1);
timeline = size(control300,2);
trial = size(control300,3);
for i = 1:trial
    for j = 1:channel
        z=control300(j,:,i);
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
        temp = abs(coefs);
        ymax=255;ymin=0;%归一化并取整[0,255]
        xmax = max(max(temp)); %求得temp中的最大值
        xmin = min(min(temp)); %求得temp中的最小值
        Out = round((ymax-ymin)*(temp-xmin)/(xmax-xmin) + ymin); %归一化并取整
        coefs_channel_trial(:,:,j,i) = Out;
        %figure(2);
        %pcolor(t,f,abs(coefs));shading interp  
    end
end
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\zzh\zzhwave300control.mat','coefs_channel_trial','label300');