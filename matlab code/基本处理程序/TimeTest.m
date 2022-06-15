clear;
name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];
for namei = 1:12 
    %% 分别计算某人静息态和工作态各次数的19个通道*42个尺度的模糊熵
    pathA = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'data300_50s.mat');
    load(pathA);
    %对300ms的数据进行小波分析并输出coefs_channel_trial
    % 将尺度转换为频率后求得的时间-频率图
    fs=1000;    %采样频率
    dt=1/fs;    %时间精度
    t=1/fs:1/fs:0.3;
    channel = size(signal300,1);
    timeline = size(signal300,2);
    trial = size(signal300,3);
    coefs_channel_trial = zeros(42,300,19,trial);
    coefs = zeros(42,300);
    list = [4,7,8];
    for i = 1:trial
        tic;
        for j = 1:1:3
            z=signal300(list(j),:,i);
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
            coefs_channel_trial(:,:,j,i) = round((ymax-ymin)*(temp-xmin)/(xmax-xmin) + ymin);
        end
        toc;
        time3(namei,i) = toc;
    end
    timename3(namei) = mean(time3(namei,:));

    for i = 1:trial
        tic;
        for j = 1:1:channel
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
            temp = abs(coefs);
            ymax=255;ymin=0;%归一化并取整[0,255]
            xmax = max(max(temp)); %求得temp中的最大值
            xmin = min(min(temp)); %求得temp中的最小值
            coefs_channel_trial(:,:,j,i) = round((ymax-ymin)*(temp-xmin)/(xmax-xmin) + ymin);
            
        end
        toc;
        time19(namei,i) = toc;
    end
    timename19(namei) = mean(time19(namei,:));
end



