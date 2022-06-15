files_path='E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\冯万玮';
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
%save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\wyh\wyhdata','signal','label');
%提取段落前200ms
import_time = 300;
num = 0;
signal300(1:19,1:300,:) = signal(3:21,551:850,:);
label300 = label;
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\fww\fwwdata300_50s','signal300','label300');

%进行头动点的确定，利用小波分析法检测异常发生
% m = 0;
% for i = 1:size(signal,1)-2
%     signal_delete(i,:,:) =  signal(i+2,:,:);
% end
% channel = size(signal_delete,1);
% timeline = size(signal_delete,2);
% trial = size(signal_delete,3);
% %时间尺度图
% for i = 1:trial
%     for j = 1:channel
%         z=signal_delete(j,:,i);
%         %figure(1)
%         %plot(z);
%         wavename='db1'; %可变参数，分别为db1的
%         %举一个频率转尺度的例子
%         scal= 100:150;%尺度100-150对应频率范围可能为
%         coefs = cwt(z,scal,wavename);
%         coefs_channel_trial(:,:,j,i) = coefs;
%         %figure(2);
%         %pcolor(t,scal,abs(coefs));shading interp  
%     end
% end
% start = zeros(1,trial)+3500;
% for i = 1:trial
%     for k = 500:timeline-1800
%             col_coefs(k,i) = sum(sum(abs(coefs_channel_trial(:,k,:,i))));
%             average = sum(col_coefs(500:k,i))/(k-499);
%             if( col_coefs(k,i) > 1.9*average )
%                start(1,i) = k;
%                break;
%             end        
%     end
% end
% histogram(start,300);
% 
% %提取前200ms
% import_time = 200;
% num = 0;
% for i = 1:trial
%     if(start(1,i)>700&&start(1,i)<1500)%在700-1500ms之间，反应时间在200-1000ms之间
%         num = num+1;
%         signal_delete200(1:channel,:,num) = signal_delete(1:channel,:,i);
%         label200(num,1) = label(i,1);
%         start_trial200(num,1) = start(1,i); 
%     end
% end
% 
% for i = 1:size(label200,1)
%     first = start_trial200(i,1) - import_time;
%     last = start_trial200(i,1);
%     signal200(1:channel,1:import_time,i) = signal_delete200(1:channel,first:last-1,i);
% end
% save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\fww\fwwdata200','signal200','label200');
% clear coefs_channel_trial;

%对200ms的数据进行小波分析并输出coefs_channel_trial
% 将尺度转换为频率后求得的时间-频率图
fs=1000;    %采样频率
dt=1/fs;    %时间精度
t=1/fs:1/fs:0.3;
channel = size(signal300,1);
timeline = size(signal300,2);
trial = size(signal300,3);
for i = 1:trial
    for j = 1:channel
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
        Out = round((ymax-ymin)*(temp-xmin)/(xmax-xmin) + ymin); %归一化并取整
        coefs_channel_trial(:,:,j,i) = Out;
        %figure(2);
        %pcolor(t,f,abs(coefs));shading interp  
    end
end
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\fww\fwwwave300_50s.mat','coefs_channel_trial','label300');
% for i = 1:8
%    figure(i)
%    m = num2str(label300(i,1));
%    pcolor(t,f,abs(coefs_channel_trial(:,:,9,i)));shading interp 
%    title(m);
% end