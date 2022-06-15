%%
%拼接所有mat文件获得总数据data和event
files_path='E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\总计1（人工去除一些坏段和人）';
filenames = dir([files_path, filesep, '*.mat']);
filenum = length(filenames);
num = 0;
lnum = 0;
%label = zeros(1643,1);
for i=1:filenum
    fn = [files_path, filesep, filenames(i).name];
    A = load(fn);
    B = A.EEG.data;
    C = A.EEG.event;  
    signal(:,:,num+1:num+size(B,3)) = B(:,:,1:size(B,3));
    for j = 1 : size(C,2) 
        t = C(j).type;
        if(t =='1')
            lnum = lnum + 1;
            label(lnum,1) = 1;            
        end
        if(t =='2')
            lnum = lnum + 1;
            label(lnum,1) = 2;           
        end
    end
    num = num + size(B,3);
end
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\总计1（人工去除一些坏段和人）\alldata','signal','label');

%%
%进行头动点的确定，利用3西格玛方法检测异常发生，这里的稳定状态下认为没有飘移
m = 0;
load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\总计1（人工去除一些坏段和人）\alldata');
for i = 1:size(signal,1)-2
    signal_delete(i,:,:) =  signal(i+2,:,:);
end

channel = size(signal_delete,1);
timeline = size(signal_delete,2);
trial = size(signal_delete,3);

for i = 1:trial
    for j = 1:channel%计算每次每个通道的平均值和方差
        average(j,i) = sum(signal_delete(j,1:500,i))/500;
        var(j,i) = sum((signal_delete(j,1:500,i)-average(j,i)).*(signal_delete(j,1:500,i)-average(j,i)))/500;
        std(j,i) = var(j,i)^0.5;
    end
end
for i = 1:trial%求标准差、方差的和，融合方差和均值
    sumaverage(1,i) = sum(average(1:channel,i));
    sumstd(1,i) = sum(std(1:channel,i))-0.98*(std(1,i)+std(4,i)+std(9,i));%在求和的基础上减少中间电极的权重-0.5*(std(1,i)+std(4,i)+std(9,i))
end
%对每10个数据均值进行判断是否落在3西格玛区间外，其中要对融合标准差进行归一适当处理，因为他利用了500个数据，而我们要检测10个
timewin = 6;%确定时间窗
slider_step = 3;
for i = 1:trial
    sumaverage_win(1,i) = sumaverage(1,i);%平均值和数目无关
    sumstd_win(1,i) = sumstd(1,i);%方差、标准差与数目无关
end%%正确
trigger = zeros(1,trial);
start = zeros(1,trial)+3500;
differ_average = zeros(channel,(timeline-500-timewin)/slider_step,trial);
for i = 1:trial%计算每次每个时间窗每个通道的平均值和方差
    for j = 1:(timeline-500-timewin)/slider_step%滑动5个点
        for k = 1:channel
            start_average(k,j,i) = sum(signal_delete(k,(j-1)*slider_step+500:(j-1)*slider_step+500+timewin-1,i))/timewin;
            %start_var(k,j,i) = sum((signal_delete(k,(j-1)*slider_step+500:(j-1)*slider_step+500+timewin-1,i)-start_average(k,j,i)).*(signal_delete(k,(j-1)*slider_step+500:(j-1)*slider_step+500+timewin-1,i)-start_average(k,j,i)))/timewin;
            %start_std() =
            %(start_var(k,j,i))^0.5;%%不需要进行样本标准差的计算，我们只需要将每一个通道的平均值作为一个样本来进行偏差
            differ_average(k,j,i) = abs(start_average(k,j,i)-average(k,i));
        end
        sum_differ_average(j,i) = sum(differ_average(1:channel,j,i))-0.98*(differ_average(1,j,i)+differ_average(4,j,i)+differ_average(9,j,i));%求样本融合偏差
        if( sum_differ_average(j,i) > 3*sumstd_win(1,i)  &&  trigger(1,i) == 0 )%比较融合偏差和3西格玛准则
            start(1,i) = (j-1)*slider_step;%动作开始时的时间点,以500ms为开始点0
            m=m+1;
            trigger(1,i) = 1;
            break;
        end   
    end
end
histogram(start,300);

%%
%进行头动点的确定，利用四分位法检测异常发生，这里的稳定状态下认为没有飘移
m = 0;
load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\总计1（人工去除一些坏段和人）\alldata');
for i = 1:size(signal,1)-2
    signal_delete(i,:,:) =  signal(i+2,:,:);
end

channel = size(signal_delete,1);
timeline = size(signal_delete,2);
trial = size(signal_delete,3);

for i = 1:trial
    for j = 1:channel%计算每次每个通道分位数
        q1(j,i) = quantile(signal_delete(j,1:500,i),0.25);
        q3(j,i) = quantile(signal_delete(j,1:500,i),0.75); 
    end
end

%对每10个数据均值进行判断是否落在四分位数区间外，其中要对融合标准差进行归一适当处理，因为他利用了500个数据，而我们要检测10个
timewin = 4;%确定时间窗
slider_step = 2;
start = zeros(channel,trial);
start_trial = zeros(trial,1);
for i = 1:trial%计算每次每个时间窗每个通道的平均值和方差
    for k = 1:channel
        for j = 1:(timeline-500-timewin-1000)/slider_step%滑动5个点   
            start_average(k,j,i) = sum(signal_delete(k,(j-1)*slider_step+500:(j-1)*slider_step+500+timewin-1,i))/timewin;
           if( start_average(k,j,i) > q3(k,i)+1.5*(q3(k,i)-q1(k,i)) || start_average(k,j,i) < q1(k,i)-1.5*(q3(k,i)-q1(k,i)))%比较区间落在哪里
               start(k,i) = (j-1)*slider_step;%动作开始时的时间点,以500ms为开始点0
               m=m+1;
            break;
           end   
        end     
    end
    
    start_trial(i,1) = (sum(start(1:channel,i))-start(1,i)-start(4,i)-start(9,i))/(channel-3);
end
histogram(start,300);



%%
%进行头动点的确定，利用拐点检测异常发生，这里认为500-存在飘移,但是对于异常飘移情况检测出错和飘移值过大无法检测的问题（由于采用了极大极小值判断拐点导致）
m = 0;
load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\总计1（人工去除一些坏段和人）\alldata');
for i = 1:size(signal,1)-2
    signal_delete(i,:,:) =  signal(i+2,:,:);
end

channel = size(signal_delete,1);
timeline = size(signal_delete,2);
trial = size(signal_delete,3);

for i = 1:trial
    for j = 1:channel%计算每次每个通道的平均值和方差
        average(j,i) = sum(signal_delete(j,1:500,i))/500;
        var(j,i) = sum((signal_delete(j,1:500,i)-average(j,i)).*(signal_delete(j,1:500,i)-average(j,i)))/500;
        std(j,i) = var(j,i)^0.5;
    end
end
for i = 1:trial%求标准差、方差的和，融合方差和均值
    sumaverage(1,i) = sum(average(1:channel,i));%各通道平均值的和
    sumaverage_m(1,i) = sumaverage(1,i)-1*(average(1,i)+average(4,i)+average(9,i))-2*(average(3,i)+average(6,i)+average(8,i)+average(11,i)+average(13,i)+average(15,i)+average(17,i)+average(19,i));
end
%对每10个数据均值进行判断是否落在3西格玛区间外，其中要对融合标准差进行归一适当处理，因为他利用了500个数据，而我们要检测10个
timewin = 20;%确定时间窗
for i = 1:trial
    sumaverage_win(1,i) = sumaverage(1,i);%平均值和数目无关
    sumaverage_m_win(1,i) = sumaverage_m(1,i);
end%%正确
trigger = zeros(1,trial);
start = zeros(1,trial)+3500;
for i = 1:trial%计算每次每个时间窗每个通道的平均值和方差
    for j = 1:(timeline-2600)%marker后1.5s内
        start_average_m(j,i) = sum(signal_delete(1:19,j+500,i)) -1*(signal_delete(1,j+500,i)+signal_delete(4,j+500,i)+signal_delete(9,j+500,i))-2*(signal_delete(3,j+500,i)+signal_delete(6,j+500,i)+signal_delete(8,j+500,i)+signal_delete(11,j+500,i)+signal_delete(13,j+500,i)+signal_delete(15,j+500,i)+signal_delete(17,j+500,i)+signal_delete(19,j+500,i));        
    end
    t = smooth(start_average_m(1:(timeline-2600),i),timewin,'moving');
    if( label(i,1) == 1  &&  trigger(1,i) == 0 )%
            [value(1,i),start(1,i)] = min(t(1:(timeline-2600),1));%动作开始时的时间点,以500ms为开始点0
            m=m+1;
            trigger(1,i) = 1;
    end 
    if( label(i,1) == 2  &&  trigger(1,i) == 0 )%比较融合偏差和3西格玛准则
            [value(1,i),start(1,i)] = max(t(1:(timeline-2600),1));%动作开始时的时间点,以500ms为开始点0
            m=m+1;
            trigger(1,i) = 1;
    end 
end
histogram(start,300);


%%
%进行头动点的确定，利用小波分析法检测异常发生
m = 0;
load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\wyh\wyhdata');
for i = 1:size(signal,1)-2
    signal_delete(i,:,:) =  signal(i+2,:,:);
end
channel = size(signal_delete,1);
timeline = size(signal_delete,2);
trial = size(signal_delete,3);
%时间尺度图
for i = 1:trial
    for j = 1:channel
        z=signal_delete(j,:,i);
        %figure(1)
        %plot(z);
        wavename='db1'; %可变参数，分别为db1的
        %举一个频率转尺度的例子
        scal= 100:150;%尺度100-150对应频率范围可能为
        coefs = cwt(z,scal,wavename);
        coefs_channel_trial(:,:,j,i) = coefs;
        %figure(2);
        %pcolor(t,scal,abs(coefs));shading interp  
    end
end
start = zeros(1,trial)+3500;
for i = 1:trial
    for k = 500:timeline-1800
            col_coefs(k,i) = sum(sum(abs(coefs_channel_trial(:,k,:,i))));
            average = sum(col_coefs(500:k,i))/(k-499);
            if( col_coefs(k,i) > 4*average )
               start(1,i) = k;
               break;
            end        
    end
end
histogram(start,300);

%%
%小波分析时间尺度图100-150较明显，fa = fc/(Ts*a),fa为真实频率，a为scale，Ts为采样周期，fc为中心频率
fs=1000;    %采样频率
dt=1/fs;    %时间精度
t=1/fs:1/fs:3.5/1000*fs;
L=length(t);
channel = size(signal_delete,1);
timeline = size(signal_delete,2);
trial = size(signal_delete,3);
z=signal_delete(2,:,1);
figure(1)
plot(z);
wavename='db1'; %可变参数，分别为db1的
wcf=centfrq(wavename); %小波的中心频率
%举一个频率转尺度的例子
scal= 100:150;%尺度100-150对应频率范围可能为24-1000对应1-40Hz（db1中心频率为0.9961hz）
coefs = cwt(z,scal,wavename);
figure(2);
pcolor(t,scal,abs(coefs));shading interp  

%%
%小波分析时间频率图1-40HZ
% 将尺度转换为频率后求得的时间-频率图,对scal和f绘图确实存在微小差异
fs=1000;    %采样频率
dt=1/fs;    %时间精度
t=1/fs:0.001:3.5;
L=length(t);
z=signal_delete(3,:,2);%取得信号
figure(1)
plot(z);
wavename='db4'; %可变参数，也可以是haar的
%举一个频率转尺度的例子
fmin=0.1;
fmax=40;
df=0.01;%0.1
f=fmax-df:-df:fmin;%预期的频率
wcf=centfrq(wavename); %小波的中心频率
scal=fs*wcf./f;%利用频率转换尺度
coefs = cwt(z,scal,wavename);
figure(2)
pcolor(t,f,abs(coefs));shading interp

%%
%提取段落前200ms
import_time = 200;
num = 0;
for i = 1:trial
    if(start(1,i)>700&&start(1,i)<1500)%在700-1500ms之间，反应时间在200-1000ms之间
        num = num+1;
        signal_delete200(1:channel,:,num) = signal_delete(1:channel,:,i);
        label200(num,1) = label(i,1);
        start_trial200(num,1) = start(1,i); 
    end
end

for i = 1:size(label200,1)
    first = start_trial200(i,1) - import_time;
    last = start_trial200(i,1);
    signal200(1:channel,1:import_time,i) = signal_delete200(1:channel,first:last-1,i);
end
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\wyh\wyhdata200','signal200','label200');



%%
%对200ms的数据进行小波分析并输出coefs_channel_trial
% 将尺度转换为频率后求得的时间-频率图
fs=1000;    %采样频率
dt=1/fs;    %时间精度
t=1/fs:1/fs:0.2;
channel = size(signal200,1);
timeline = size(signal200,2);
trial = size(signal200,3);
for i = 1:trial
    for j = 1:channel
        z=signal200(j,:,i);
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
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\wyh\wyhwave200.mat','coefs_channel_trial');

%%
%批量储存小波图并且可以改名字，未写完改名字段落
for i = 1:10
   figure(1)
   pcolor(t,scal,abs(coefs_channel_trial(:,:,1,4)));
   shading interp
   f=getframe(gca);
   imwrite(f.cdata,'E:\science research\转动意图识别\laboratory_data&result\data\200ms小波图像\wyh1_1.png');
   new = strcat('wyh', int2str(i));
   
end

%%
%验证小波分析以尺度或者频率为等差数列所产生的不同，结果是选择尺度或者频率为等差数列没有太多不同
%但是以尺度为纵轴或者以频率为纵轴得到的结果存在明显不同
%另外一点是pcolor和imagesc两种绘图方式没有明显区别
fs=1000;    %采样频率
dt=1/fs;    %时间精度
t=0:0.001:0.2-0.001;
L=length(t);
z=signal200(1,:,1);%取得信号
figure(1)
plot(z);
wavename='db4'; %可变参数，也可以是haar的
%举一个频率转尺度的例子
scal=64:-1:18;%预期的频率
wcf=centfrq(wavename); %小波的中心频率
f=fs*wcf./scal;%利用频率转换尺度
coefs = cwt(z,scal,wavename);
figure(2)
pcolor(t,f,abs(coefs));shading interp  %尺度为等差数列，第一种绘图方式
f=40:-0.5:11;%预期的频率
wcf=centfrq(wavename); %小波的中心频率
scal=fs*wcf./f;%利用频率转换尺度
coefs = cwt(z,scal,wavename);
figure(3)
pcolor(t,f,abs(coefs));shading interp  %频率为等差数列，对f进行第一种绘图方式
figure(4)
pcolor(t,scal,abs(coefs));shading interp  %频率为等差数列，对scal进行第一种绘图方式
figure(5)
imagesc(t,f,abs(coefs));%频率为等差数列，对f进行第二种绘图方式



%%
%寻找劣质信号
for i = 1:trial
    if(start(1,i)<51&&start(1,i)>45)
        i
        start(1,i)       
    end   
end

for i = 1:2000
    if(start(1,i)<1034&&start(1,i)>1026)
        i
        start(1,i)       
    end   
end