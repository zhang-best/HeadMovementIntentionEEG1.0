tic
load ('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\lhy\lhydata200_ICA.mat');

%BCICIV_3_mat\S1文件识别转换，训练样本转换
%   m = EEGSignals.training_data{2};
%   n = EEGSignals.training_data{4};
%   v = EEGSignals.training_data{1};%掺杂其他成分看影响
%   for j = 1:10
%       for k = 1:24
%           for i = 1:400         
%              EEGSignalsx(i,j,k)=m(k,i,j);
%               EEGSignalsx(i,j,k+24)=n(k,i,j);
%           end
%       end
%   end
%   for k = 1:24
%       EEGSignalsy(k,1)=1;
%       EEGSignalsy(k+24,1)=2;
%   end
%BCICIV_3_mat\S1文件识别转换，测试样本转换
%    for j = 1:10
%       for k = 1:16
%           for i = 1:400
%               EEGSignalsxT(i,j,k)=m(k+24,i,j);
%               EEGSignalsxT(i,j,k+16)=n(k+24,i,j);
%           end
%       end
%   end
%   for k = 1:16
%       EEGSignalsyT(k,1)=1;
%       EEGSignalsyT(k+16,1)=2;
%   end
% X_train=EEGSignalsx;  %训练集
% Y_train=EEGSignalsy;  %训练集标签
% X_test=EEGSignalsxT;    %测试集
% Y_test=EEGSignalsyT;    %测试集标签

 % %BCIcomp2002.mat文件转换
 for i = 1:19
     for j = 1:200
         signal(j,i,:) = signal200(i,j,:);
     end
 end
  X_train=signal(:,:,1:150);  %训练集
  X_test=signal(:,:,151:208);  %训练集标签
  Y_train=label200(1:150,:);    %测试集
  Y_test=label200(151:208,:);    %测试集标签

CSPm=3;     %定义CSP-m参数
sampleRate=1000;%128
startTime= 0;
k=10;       %定义Mutual Select K values
freq=[7 12 16 20 24 28 30]; %设置子频带频率
[FBtrainf,proj,classNum]=FBCSP(X_train(sampleRate*startTime+1:end,:,:),Y_train,sampleRate,CSPm,freq); %对训练集数据进行FBCSP
kmax=size(FBtrainf,2);      %k不能超过kmax
%%  特征选择
rank=all_MuI(FBtrainf,Y_train);
selFeaTrain=FBtrainf(:,rank(1:k,2));                             %MuI selected train set features
%% 训练模型
model=fitcsvm(selFeaTrain,Y_train); %训练模型,'-c 2 -g 0.1250'
fbtestf=FBCSPOnline(X_test(sampleRate*startTime+1:end,:,:),proj,classNum,sampleRate,CSPm,freq);  %对测试集数据进行FBCSP
selFeaTest=fbtestf(:,rank(1:k,2));                               %MuI test set features
% predict=svmpredict(Y_test,selFeaTest,model);
[predictlabel,ac] = predict(model,selFeaTest);
ac_1=ac(1);
disp(ac_1);
toc  

e = 0;
for i =1:50
    if (Y_test(i,1)==predictlabel(i,1))
        e = e+1;
    end
end
%author:mao date:2020-10-8 
%programme:the Filter Bank Common Sptial Pattern algorithm
%input:train_data, 3维 EEG数据。其中，第一维是采样点，第二维是通道数量，第三维度是trials大小
%      train_label,train_data对应的标签
%      sampleRate,采样率
%               m,CSP的-m参数
%output:features_train 融合后各子频带后的特征数组
%       projMAll 由各子频带计算所得的投影矩阵
%       classNum 待分类的类别数量
function [features_train,projM_All,classNum]=FBCSP(train_data,train_label,sampleRate,m,freq)
[q,p,k]=size(train_data);   %获取总的trial次数
%% acquire and combine feature of different frequency bands
features_train=[];          %声明训练集csp特征融合数组
filter_data=zeros(size(train_data));
classNum=max(train_label);  %获取类别数量
projM_All=zeros(p,p,max(train_label)*(size(freq,2)-1)); %申请投影矩阵空间
for i=1:size(freq,2)
    lower=freq(i);  %获取低频
    if lower==freq(size(freq,2))
        break;
    end
    higher=freq(i+1);%获取高频
    %对各子频带进行滤波
    filter_tmp=[];
    for j=1:k   %对每个trial进行循环滤波,filter()函数可以滤波3维数据？
        filter_tmp=filter_param(train_data(:,:,j),lower,higher,sampleRate,4);
        filter_data(:,:,j)=filter_tmp;
    end
    % 计算csp滤波器，用csp滤波器进行特征提取
    projM=cspProjMatrix(filter_data,train_label); %要循环保存投影矩阵用于在线CSP滤波
    projM_All(:,:,1+(i-1)*classNum:i*classNum)=projM;   %存储当前频带投影矩阵
    feature=[];  %声明本子频带特征矩阵
    for b=1:k    %循环提取特征
        feature(b,:)=cspFeature(projM,filter_data(:,:,b),m); %第三个参数m不要超过通道数的一半，不然会出现重复特征
    end
    tmp_data=feature;
    features_train=[features_train,tmp_data]; %拼接各频带特征矩阵
end
end

%author:mao date:2020-10-8
%programme:the Filter Bank Common Sptial Pattern algorithm
%input:train_data,3维 EEG数据。其中，第一维是采样点，第二维是通道数量，第三维度是trials大小
%                 2维 EEG数据。其中，第一位是采样点，第二维是通道数量
%      projMAll,  由训练集计算所得个子频带CSP投影矩阵
%      classNum,  待分类的类别数
%      sampleRate,采样率
%               m,CSP的m参数
%output:features, 融合后各子频带后的特征数组
function features_train=FBCSPOnline(train_data,projMAll,classNum,sampleRate,m,freq)
if ndims(train_data)==3 %输入EEG数据为3维
    %% acquire and combine feature of different frequency bands
    [q,p,k]=size(train_data);%获取总的trial次数
    filter_data=zeros(size(train_data));
    features_train=[];      %声明训练集csp特征融合数组
    for i=1:size(freq,2)
        lower=freq(i);  %获取低频
        if lower==freq(size(freq,2))
            break;
        end
        higher=freq(i+1);%获取高频
        %对各子频带进行滤波
        filter_tmp=[];
        for j=1:k   %对每个trial进行循环滤波,matlab中的filter()函数可以滤波3维数据？
            filter_tmp=filter_param(train_data(:,:,j),lower,higher,sampleRate,4);
            filter_data(:,:,j)=filter_tmp;
        end
        feature=[];  %声明本子频带特征矩阵
        for b=1:k    %循环提取特征
            feature(b,:)=cspFeature(projMAll(:,:,1+(i-1)*classNum:i*classNum),filter_data(:,:,b),m); %第三个参数m不要超过通道数的一半，不然会出现重复特征
        end
        tmp_data=feature;
        features_train=[features_train,tmp_data]; %拼接个自频带特征矩阵
    end
else                  
    %% 输入EEG数据为2维
    features_train=[];      %声明训练集csp特征融合数组
    for i=1:size(freq,2)
        lower=freq(i);  %获取低频
        if lower==freq(size(freq,2))
            break;
        end
        higher=freq(i+1);%获取高频
        %对各子频带进行滤波
        filter_data=filter_param(train_data,lower,higher,sampleRate,4);
        feature=[];  %声明本子频带特征矩阵
        feature=cspFeature(projMAll(:,:,1+(i-1)*classNum:i*classNum),filter_data,m); %第三个参数m不要超过通道数的一半，不然会出现重复特征
        tmp_data=feature';
        features_train=[features_train,tmp_data]; %拼接个自频带特征矩阵
    end
end
end


%% 对数据进行滤波
%输入：data 待滤波EEG数据
%   low        高通滤波参数设置
%   high       低通滤波参数设置
%   sampleRate          采样率
%   filterorder  butterworth滤波器阶数
%返回：filterdata       滤波后EEG数据
function filterdata=filter_param(data,low,high,sampleRate,filterorder)
%% 设置滤波参数
 filtercutoff = [low*2/sampleRate high*2/sampleRate]; 
 [filterParamB, filterParamA] = butter(filterorder,filtercutoff);
 filterdata= filter( filterParamB, filterParamA, data);
end
 
 function projM=cspProjMatrix(x,y)
%基于共空间模式算法计算出一个投影矩阵
%输入参数：
%        x:3维 EEG数据。其中，第一维是采样点，第二维是通道数量，第三维度是trials大小
%        y: 一维列向量标签 范围是从1到分类数量，长度与x的第三维保持一致
%注意：这里y标签只能从1开始，往后延，不能用-1 1这种标签格式

trialNo=length(y); %获取标签长度
classNo=max(y);    %获取标签类别数量
channelNo=length(x(1,:,1)); %获取通道数量

for k=1:classNo    %对每一类进行训练
    N_a=sum(y==k); %number of trials for class k，当前类的trials数量
    N_b=trialNo-N_a;
    R_a=zeros(channelNo,channelNo); %申请[通道数量*通道数量] 方阵大小的空间
    R_b=zeros(channelNo,channelNo);
    for i=1:trialNo
        R=x(:,:,i)'*x(:,:,i); 
        %R=cov(x(:,:,i)); 
        R=R/trace(R);
        if y(i)==k   %当前类
            R_a=R_a+R;
        else         %其他类
            R_b=R_b+R;
        end
    end
    R_a=R_a/N_a;
    R_b=R_b/N_b;
    [V,D]=svd(R_a+R_b);  %矩阵奇异值分解
    W=D^(-0.5)*V';       %P白化矩阵，P矩阵返回为W
    S_a=W*R_a*W';
    [V,D]=svd(S_a);
    projM(:,:,k)=W'*V;  %投影矩阵， 最后投影矩阵的大小为 [通道数量 通道数量 类别数量] 其中第三维度为每个类的滤波器
end 
end

function feature=cspFeature(projM,x,m)
%%%%%%通过投影矩阵进行特征提取
% 输入参数：
%      projM: csp投影矩阵
%          x: 一个时间窗口的2维EEG数据。其中，第一维是采样点；第二维是通道
%          m: 投影数据矩阵的第一列和最后一列的个数。
% 输出参数：
%    feature: 从列向量中提取到的特征


classNo=length(projM(1,1,:));  %获取类别数量
channelNo=size(x,2);           %获取通道数量
feature=[];                    %声明特征矩阵
for k=1:classNo                %classNo为类数量
    Z=x*projM(:,:,k); %projected data matrix
    for j=1:m
        feature=[feature; var(Z(:,j)); var(Z(:,channelNo-j+1))];  %var(A) 算矩阵A没列方差，此时默认是除N-1
        %variances of the first and last m columns(第1和最后m列的方差)
    end
end
feature=log(feature/sum(feature)); 

end

%author:mao date:2020-1203 
%function:Mutual Information
%   input:fea_train(m*n), features that needs to culculate MI.
%         label_train(m*1),label that conresponds the features
%
%  output:rank(n*2),the first dimension includes the Mutual information 
%                   values,and the second dimension incoude the index
function sort_tmp=all_MuI(fea_train,label_train)
n=size(fea_train,1);               
tmp=[];
for i=1:size(fea_train,2)
    MuI=calc_MuI(fea_train(:,i),label_train,n);
    tmp=[tmp;MuI i];                  
end
sort_tmp=sortrows(tmp);
m=size(sort_tmp,1);
for i=1:m
    sort_tmp(i,:)=sort_tmp(m+1-i,:);
end
end
%计算两列向量之间的互信息
%u1：输入计算的向量1
%u2：输入计算的向量2
%wind_size：向量的维度
function mi = calc_MuI(u1, u2, wind_size)
x = [u1, u2];
n = wind_size;
[xrow, xcol] = size(x);
bin = zeros(xrow,xcol);
pmf = zeros(n, 2);
for i = 1:2
    minx = min(x(:,i));
    maxx = max(x(:,i));
    binwidth = (maxx - minx) / n;
    edges = minx + binwidth*(0:n);
    histcEdges = [-Inf edges(2:end-1) Inf];
    [occur,bin(:,i)] = histc(x(:,i),histcEdges,1); %通过直方图方式计算单个向量的直方图分布
    pmf(:,i) = occur(1:n)./xrow;
end
%计算u1和u2的联合概率密度
jointOccur = accumarray(bin,1,[n,n]);  %（xi，yi）两个数据同时落入n*n等分方格中的数量即为联合概率密度
jointPmf = jointOccur./xrow;
Hx = -(pmf(:,1))'*log2(pmf(:,1)+eps);
Hy = -(pmf(:,2))'*log2(pmf(:,2)+eps);
Hxy = -(jointPmf(:))'*log2(jointPmf(:)+eps);
MI = Hx+Hy-Hxy;
mi = MI/sqrt(Hx*Hy);
end