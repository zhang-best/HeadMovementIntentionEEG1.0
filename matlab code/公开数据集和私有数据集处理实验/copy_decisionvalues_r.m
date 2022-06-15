tic
load ('E:\science research\ת����ͼʶ��\�������ݼ�\BCIcomp2002.mat');


 % %BCIcomp2002.mat�ļ�ת��
  X_train=x_train;  %ѵ����
  Y_train=y_train;  %ѵ������ǩ

for i = 1:size(x_test,3)
  X_test(1:1152-i*5,:,i)=x_test(1:1152-i*5,:,21);    %140-21
  X_test(1152-i*5+1:1152,:,i)=x_test(384+1:5*i+384,:,5); %97
end
  Y_test(1:140,1)=1;    %���Լ���ǩ

CSPm=3;     %����CSP-m����
sampleRate=128;%128
startTime= 3;
k=10;       %����Mutual Select K values
freq=[7 12 16 20 24 28 30]; %������Ƶ��Ƶ��
[FBtrainf,proj,classNum]=FBCSP(X_train(sampleRate*startTime:end,:,:),Y_train,sampleRate,CSPm,freq); %��ѵ�������ݽ���FBCSP
kmax=size(FBtrainf,2);      %k���ܳ���kmax
%%  ����ѡ��
rank=all_MuI(FBtrainf,Y_train);
selFeaTrain=FBtrainf(:,rank(1:k,2));                             %MuI selected train set features
%% ѵ��ģ��
model=fitcsvm(Y_train,selFeaTrain,'-c 2 -g 0.1250'); %ѵ��ģ��
tic
fbtestf=FBCSPOnline(X_test(sampleRate*startTime:end,:,:),proj,classNum,sampleRate,CSPm,freq);  %�Բ��Լ����ݽ���FBCSP
selFeaTest=fbtestf(:,rank(1:k,2));                               %MuI test set features
% predict=svmpredict(Y_test,selFeaTest,model);
[predictlabel,ac,decision_values]=svmpredict(Y_test,selFeaTest,model);
ac_1=ac(1);
disp(ac_1);
toc  

for i = 1:size(Y_test)
    h(i,1) = i;
end
plot(h,decision_values,'-*b');

%author:mao date:2020-10-8 
%programme:the Filter Bank Common Sptial Pattern algorithm
%input:train_data, 3ά EEG���ݡ����У���һά�ǲ����㣬�ڶ�ά��ͨ������������ά����trials��С
%      train_label,train_data��Ӧ�ı�ǩ
%      sampleRate,������
%               m,CSP��-m����
%output:features_train �ںϺ����Ƶ�������������
%       projMAll �ɸ���Ƶ���������õ�ͶӰ����
%       classNum ��������������
function [features_train,projM_All,classNum]=FBCSP(train_data,train_label,sampleRate,m,freq)
[q,p,k]=size(train_data);   %��ȡ�ܵ�trial����
%% acquire and combine feature of different frequency bands
features_train=[];          %����ѵ����csp�����ں�����
filter_data=zeros(size(train_data));
classNum=max(train_label);  %��ȡ�������
projM_All=zeros(p,p,max(train_label)*(size(freq,2)-1)); %����ͶӰ����ռ�
for i=1:size(freq,2)
    lower=freq(i);  %��ȡ��Ƶ
    if lower==freq(size(freq,2))
        break;
    end
    higher=freq(i+1);%��ȡ��Ƶ
    %�Ը���Ƶ�������˲�
    filter_tmp=[];
    for j=1:k   %��ÿ��trial����ѭ���˲�,filter()���������˲�3ά���ݣ�
        filter_tmp=filter_param(train_data(:,:,j),lower,higher,sampleRate,4);
        filter_data(:,:,j)=filter_tmp;
    end
    % ����csp�˲�������csp�˲�������������ȡ
    projM=cspProjMatrix(filter_data,train_label); %Ҫѭ������ͶӰ������������CSP�˲�
    projM_All(:,:,1+(i-1)*classNum:i*classNum)=projM;   %�洢��ǰƵ��ͶӰ����
    feature=[];  %��������Ƶ����������
    for b=1:k    %ѭ����ȡ����
        feature(b,:)=cspFeature(projM,filter_data(:,:,b),m); %����������m��Ҫ����ͨ������һ�룬��Ȼ������ظ�����
    end
    tmp_data=feature;
    features_train=[features_train,tmp_data]; %ƴ�Ӹ�Ƶ����������
end
end

%author:mao date:2020-10-8
%programme:the Filter Bank Common Sptial Pattern algorithm
%input:train_data,3ά EEG���ݡ����У���һά�ǲ����㣬�ڶ�ά��ͨ������������ά����trials��С
%                 2ά EEG���ݡ����У���һλ�ǲ����㣬�ڶ�ά��ͨ������
%      projMAll,  ��ѵ�����������ø���Ƶ��CSPͶӰ����
%      classNum,  ������������
%      sampleRate,������
%               m,CSP��m����
%output:features, �ںϺ����Ƶ�������������
function features_train=FBCSPOnline(train_data,projMAll,classNum,sampleRate,m,freq)
if ndims(train_data)==3 %����EEG����Ϊ3ά
    %% acquire and combine feature of different frequency bands
    [q,p,k]=size(train_data);%��ȡ�ܵ�trial����
    filter_data=zeros(size(train_data));
    features_train=[];      %����ѵ����csp�����ں�����
    for i=1:size(freq,2)
        lower=freq(i);  %��ȡ��Ƶ
        if lower==freq(size(freq,2))
            break;
        end
        higher=freq(i+1);%��ȡ��Ƶ
        %�Ը���Ƶ�������˲�
        filter_tmp=[];
        for j=1:k   %��ÿ��trial����ѭ���˲�,matlab�е�filter()���������˲�3ά���ݣ�
            filter_tmp=filter_param(train_data(:,:,j),lower,higher,sampleRate,4);
            filter_data(:,:,j)=filter_tmp;
        end
        feature=[];  %��������Ƶ����������
        for b=1:k    %ѭ����ȡ����
            feature(b,:)=cspFeature(projMAll(:,:,1+(i-1)*classNum:i*classNum),filter_data(:,:,b),m); %����������m��Ҫ����ͨ������һ�룬��Ȼ������ظ�����
        end
        tmp_data=feature;
        features_train=[features_train,tmp_data]; %ƴ�Ӹ���Ƶ����������
    end
else                  
    %% ����EEG����Ϊ2ά
    features_train=[];      %����ѵ����csp�����ں�����
    for i=1:size(freq,2)
        lower=freq(i);  %��ȡ��Ƶ
        if lower==freq(size(freq,2))
            break;
        end
        higher=freq(i+1);%��ȡ��Ƶ
        %�Ը���Ƶ�������˲�
        filter_data=filter_param(train_data,lower,higher,sampleRate,4);
        feature=[];  %��������Ƶ����������
        feature=cspFeature(projMAll(:,:,1+(i-1)*classNum:i*classNum),filter_data,m); %����������m��Ҫ����ͨ������һ�룬��Ȼ������ظ�����
        tmp_data=feature';
        features_train=[features_train,tmp_data]; %ƴ�Ӹ���Ƶ����������
    end
end
end


%% �����ݽ����˲�
%���룺data ���˲�EEG����
%   low        ��ͨ�˲���������
%   high       ��ͨ�˲���������
%   sampleRate          ������
%   filterorder  butterworth�˲�������
%���أ�filterdata       �˲���EEG����
function filterdata=filter_param(data,low,high,sampleRate,filterorder)
%% �����˲�����
 filtercutoff = [low*2/sampleRate high*2/sampleRate]; 
 [filterParamB, filterParamA] = butter(filterorder,filtercutoff);
 filterdata= filter( filterParamB, filterParamA, data);
end
 
 function projM=cspProjMatrix(x,y)
%���ڹ��ռ�ģʽ�㷨�����һ��ͶӰ����
%���������
%        x:3ά EEG���ݡ����У���һά�ǲ����㣬�ڶ�ά��ͨ������������ά����trials��С
%        y: һά��������ǩ ��Χ�Ǵ�1������������������x�ĵ���ά����һ��
%ע�⣺����y��ǩֻ�ܴ�1��ʼ�������ӣ�������-1 1���ֱ�ǩ��ʽ

trialNo=length(y); %��ȡ��ǩ����
classNo=max(y);    %��ȡ��ǩ�������
channelNo=length(x(1,:,1)); %��ȡͨ������

for k=1:classNo    %��ÿһ�����ѵ��
    N_a=sum(y==k); %number of trials for class k����ǰ���trials����
    N_b=trialNo-N_a;
    R_a=zeros(channelNo,channelNo); %����[ͨ������*ͨ������] �����С�Ŀռ�
    R_b=zeros(channelNo,channelNo);
    for i=1:trialNo
        R=x(:,:,i)'*x(:,:,i); 
        %R=cov(x(:,:,i)); 
        R=R/trace(R);
        if y(i)==k   %��ǰ��
            R_a=R_a+R;
        else         %������
            R_b=R_b+R;
        end
    end
    R_a=R_a/N_a;
    R_b=R_b/N_b;
    [V,D]=svd(R_a+R_b);  %��������ֵ�ֽ�
    W=D^(-0.5)*V';       %P�׻�����P���󷵻�ΪW
    S_a=W*R_a*W';
    [V,D]=svd(S_a);
    projM(:,:,k)=W'*V;  %ͶӰ���� ���ͶӰ����Ĵ�СΪ [ͨ������ ͨ������ �������] ���е���ά��Ϊÿ������˲���
end 
end

function feature=cspFeature(projM,x,m)
%%%%%%ͨ��ͶӰ�������������ȡ
% ���������
%      projM: cspͶӰ����
%          x: һ��ʱ�䴰�ڵ�2άEEG���ݡ����У���һά�ǲ����㣻�ڶ�ά��ͨ��
%          m: ͶӰ���ݾ���ĵ�һ�к����һ�еĸ�����
% ���������
%    feature: ������������ȡ��������


classNo=length(projM(1,1,:));  %��ȡ�������
channelNo=size(x,2);           %��ȡͨ������
feature=[];                    %������������
for k=1:classNo                %classNoΪ������
    Z=x*projM(:,:,k); %projected data matrix
    for j=1:m
        feature=[feature; var(Z(:,j)); var(Z(:,channelNo-j+1))];  %var(A) �����Aû�з����ʱĬ���ǳ�N-1
        %variances of the first and last m columns(��1�����m�еķ���)
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
%������������֮��Ļ���Ϣ
%u1��������������1
%u2��������������2
%wind_size��������ά��
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
    [occur,bin(:,i)] = histc(x(:,i),histcEdges,1); %ͨ��ֱ��ͼ��ʽ���㵥��������ֱ��ͼ�ֲ�
    pmf(:,i) = occur(1:n)./xrow;
end
%����u1��u2�����ϸ����ܶ�
jointOccur = accumarray(bin,1,[n,n]);  %��xi��yi����������ͬʱ����n*n�ȷַ����е�������Ϊ���ϸ����ܶ�
jointPmf = jointOccur./xrow;
Hx = -(pmf(:,1))'*log2(pmf(:,1)+eps);
Hy = -(pmf(:,2))'*log2(pmf(:,2)+eps);
Hxy = -(jointPmf(:))'*log2(jointPmf(:)+eps);
MI = Hx+Hy-Hxy;
mi = MI/sqrt(Hx*Hy);
end

