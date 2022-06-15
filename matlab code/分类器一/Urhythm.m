clear;
A = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\wyh\wyhdata300_50s.mat');
B = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\wyh\wyhdata300control.mat');
signal = A.signal300;%19*300*208
control = B.control300;
fs=1000;dt=1/fs;
num = 0;
for i = 1:size(signal,3)
    for j = 1:size(signal,1)
        %%
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
        fmax=12;
        df=1;%0.1
        f=fmax-df:-df:fmin;%预期的频率
        wcf=centfrq(wavename); %小波的中心频率
        scal=fs*wcf./f;%利用频率转换尺度
        coefs = cwt(z,scal,wavename);
        coefs = abs((coefs));
        energys(j,i) = sum(sum(coefs));
        z=control(j,:,i);%取得信号
        coefs = cwt(z,scal,wavename);
        energyc(j,i) = sum(sum(abs(coefs)));
    end
end
for i = 1:size(signal,3)
    energyc_total(1,i) = sum(energyc(:,i));
    energys_total(1,i) = sum(energys(:,i));
end
for i =1:size(signal,3)
    if(energyc_total(1,i)<energys_total(1,i))
        num = num+1;
    end
end
num/size(signal,3)
ee = energys-energyc;
for i =1:size(signal,3)
    for j = 1:size(signal,1)
        if(ee(j,i)<0)
           ee(j,i)=-1;
        else
            ee(j,i)=0;
        end
    end
end




