clear;
name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];
for namei = 1:12 
%% 对分类器一产生输入数据：进行小波变换和fuzzy+urhythm计算的图片
    pathA = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'wavefuzzy300_50s.mat');
    A = load(pathA);
    trials = size(A.coefs_channel_trial,4);
    channels = size(A.coefs_channel_trial,3);
    dim1 = size(A.coefs_channel_trial,1);
    coefs_channel_trial(:,:,1:19,:) = A.coefs_channel_trial;
    label300 = A.label300;
    fs=1000;dt=1/fs;
%% 计算u节律
    pathB = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'data300_50s.mat');
    B = load(pathB);
    signal = B.signal300;%19*300*208
    for i = 1:trials
        for j = 1:channels
            %小波分析时间频率图1-40HZ
            % 将尺度转换为频率后求得的时间-频率图,对scal和f绘图确实存在微小差异
            %采样频率
            %时间精度
            t=1/fs:0.001:0.3;
            L=length(t);
            z=signal(j,:,i);%取得信号
            wavename='db4'; %可变参数，也可以是haar的
            %举一个频率转尺度的例子
            fmin=8;
            fmax=13;
            df=1;%0.1
            f=fmax-df:-df:fmin;%预期的频率
            wcf=centfrq(wavename); %小波的中心频率
            scal=fs*wcf./f;%利用频率转换尺度
            coefs = cwt(z,scal,wavename);
            energys(:,:,j,i) = abs(coefs);
        end
    end
%% 合并二者
    for i = 1:trials
        for r = 1:8%空8行0
            for j = 1:19
                coefs_channel_trial(r+60,1:end,j,i) = 0;
            end
        end
    end
    for i = 1:trials
        for r = 1:size(energys,1)
            for j = 1:19
                coefs_channel_trial(r+68,:,j,i) = energys(r,:,j,i);
            end
        end
    end
%% 归一化20-38通道图的值【0，255】
    for i = 1:trials
        for j = 1:19
            Xmax = max(max(coefs_channel_trial(69:end,:,j,i)));
            Xmin = min(min(coefs_channel_trial(69:end,:,j,i)));
            coefs_channel_trial(69:end,:,j,i) = round((coefs_channel_trial(69:end,:,j,i)-Xmin)*255/(Xmax-Xmin));
        end
    end
    pathD = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'wavefuzzyUrhythm300_50s.mat');
    save(pathD,'coefs_channel_trial','label300');  
    clear;
    name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];
end

