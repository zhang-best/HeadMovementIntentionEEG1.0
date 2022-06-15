clear;
A = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\fww\fwwdata300_50s.mat');
B = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\fww\fwwdata300control.mat');
signal = A.signal300;%19*300*208
control = B.control300;
dim = 2;
n = 2;
factor = 10;
num = 0;
fs=1000;dt=1/fs;
for i = 1:size(signal,3)
    for j = 1:size(signal,1)
        [mse_fuzzys,~] = fuzzymsentropy(signal(j,:,i),factor);
        [mse_fuzzyc,~] = fuzzymsentropy(control(j,:,i),factor);
        mse_fuzzys = sort(mse_fuzzys);
        mse_fuzzyc = sort(mse_fuzzyc);
        FuzzyEns(j,i) = sum(mse_fuzzys(1,5:factor));
        FuzzyEnc(j,i) = sum(mse_fuzzyc(1,5:factor));%取多尺度下最大的几个熵求和得到每次的通道熵5:factor
    end
end
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
        energys(j,i) = sum(sum(abs(coefs)));
        z=control(j,:,i);%取得信号
        coefs = cwt(z,scal,wavename);
        energyc(j,i) = sum(sum(abs(coefs)));%min(sum(abs(coefs),2))
    end
end
%% 直接进行前向融合
% for i =1:size(signal,3)
%     for j =1:size(signal,1)
%         allc(j,i) = FuzzyEnc(j,i)-1.5*energyc(j,i)/max(energyc(:,i))*max(FuzzyEnc(:,i));
%         alls(j,i) = FuzzyEns(j,i)-1.5*energys(j,i)/max(energys(:,i))*max(FuzzyEns(:,i));%可以修改耦合关系
%     end
% end
% allc = sort(allc,1);
% alls = sort(alls,1);
% for i =1:size(signal,3)
%     s_total(1,i) = sum(alls(5:19,i));
%     c_total(1,i) = sum(allc(5:19,i));%取19个通道中最大的几个熵求和得到每次的熵
% end
% total(1,:)=s_total(1,:);
% total(2,:)=c_total(1,:);
% for i =1:size(signal,3)
%     if(total(1,i)<total(2,i))
%         num = num+1;
%     end
% end
% num/size(signal,3)

%% 提取g*2个特征
energy = energyc-energys;
Fuzzy = FuzzyEns-FuzzyEnc;
esum = sum(energy,2);
esum = (esum);
Fsum = sum(Fuzzy,2);
Fsum = (Fsum);
[se,indexe] = sort(esum,'descend');
[sF,indexF] = sort(Fsum,'descend');
g =19;
%生成SVM所需的数据集
for i =1:150%生成训练集300=150空闲+150工作
    for j = 1:g
        X(j,i) = FuzzyEns(indexF(j),i);
        X(j+g,i) = energys(indexe(j),i)/1000;
        X(j,i+150) = FuzzyEnc(indexF(j),i);
        X(j+g,i+150) = energyc(indexe(j),i)/1000;
        classX(i,1) = 0;
        classX(i+150,1) = 1;
    end
end
X = X';
t = size(signal,3)-150;
for i =1:t%生成训练集114=57空闲+57工作
    for j = 1:g
        Y(j,i) = FuzzyEns(indexF(j),i+150);
        Y(j+g,i) = energys(indexe(j),i+150)/1000;
        Y(j,i+t) = FuzzyEnc(indexF(j),i+150);
        Y(j+g,i+t) = energyc(indexe(j),i+150)/1000;
        classY(i,1) = 0;
        classY(i+t,1) = 1;
    end
end
Y = Y';
Model = fitclinear(X,classX);
preict = predict(Model,Y);
for i =1:2*t%生成训练集114=57空闲+57工作
    if(i<t && preict(i,1)==0)
        num=num+1;
    end
    if(i==t && preict(i,1)==0)
        num=num+1;
    end
    if(i>t && preict(i,1)==1)
        num=num+1;
    end
end
accuracy = num/(2*t)
%% 通过19个熵值和19个U节律来作为融合特征，计算同一次动和不动前后是否存在明显差值，发现确实具有明显差值变大，所有人都在99%以上，大部分100%
% result = zeros(19,208);
% for i =1:size(signal,3)
%     for j =1:size(signal,1)
%         if(FuzzyEnc(j,i)>FuzzyEns(j,i))
%             result(j,i)=result(j,i)+1;
%         end
%         if(FuzzyEnc(j,i)<FuzzyEns(j,i))
%             result(j,i)=result(j,i)-1;
%         end
%         if(energyc(j,i)<energys(j,i))
%             result(j,i)=result(j,i)+1;
%         end
%         if(energyc(j,i)>energys(j,i))
%             result(j,i)=result(j,i)-1;
%         end
%     end
% end
% for i =1:size(signal,3)
%     results(1,i) = sum(result(:,i));
% end
% for i =1:size(signal,3)
%     if(results(1,i)>0)
%         num = num+1;
%     end
% end
% num/size(signal,3)

function FuzzyEn = FuzzyEn(series,dim,r,n)
%% Checking the ipunt parameters:
control = ~isempty(series);
assert(control,'The user must introduce a time series (first inpunt).');
control = ~isempty(dim);
assert(control,'The user must introduce a embbeding dimension (second inpunt).');
control = ~isempty(r);
assert(control,'The user must introduce a width for the fuzzy exponential function: r (third inpunt).');
control = ~isempty(n);
assert(control,'The user must introduce a step for the fuzzy exponential function: n (fourth inpunt).');

N = length(series);
phi = zeros(1,2);
% Value of 'r' in case of not normalized time series:
% r = r*std(series);

for j = 1:2
    m = dim+j-1; % 'm' is the embbeding dimension used each iteration
    % Pre-definition of the varialbes for computational efficiency:
    patterns = zeros(m,N-m+1);
    aux = zeros(1,N-m+1);
    
    if m == 1 % If the embedding dimension is 1, each sample is a pattern
        patterns = series;
    else % Otherwise, we build the patterns of length 'm':
        for i = 1:m
            patterns(i,:) = series(i:N-m+i);
        end
    end
    for i = 1:N-m+1
        patterns(:,i) = patterns(:,i) - (mean(patterns(:,i)));
    end

    for i = 1:N-m
        if m == 1 
            dist = abs(patterns - repmat(patterns(:,i),1,N-m+1));
        else
            dist = max(abs(patterns - repmat(patterns(:,i),1,N-m+1)));
        end
       simi = exp(((-1)*((dist).^n))/r);
       aux(i) = (sum(simi)-1)/(N-m-1); % We substract 1 to the sum to avoid the self-comparison
    end

    phi(j) = sum(aux)/(N-m);
end

FuzzyEn = log(phi(1)) - log(phi(2));

end %End of the 'FuzzyEn' function


%% 多尺度模糊熵的意思是在不同的时间尺度下进行熵计算，其中不同的时间尺度就是利用coarsegraining粗粒度，即取均值。
function [mse_fuzzy,sf] = fuzzymsentropy(input,factor)

y=input;
y=y-mean(y);
st=std(y);  
y=y/st;

for i=1:factor
   s=coarsegraining(y,i);
   sampe = FuzzyEn(s,2,0.2*st,2);
   %sampe = fuzzyEn(s, m+1, r);
   %sampe=sampenc(s,m+1,r);
   mse_fuzzy(i)=sampe;
   %e(2,i)=sampe(m+1);   
end
sf=1:factor;
% e=e';
end

function output = coarsegraining(input,factor);

n=length(input);
blk=fix(n/factor);
for i=1:blk
   s(i)=0; 
   for j=1:factor
      s(i)=s(i)+input(j+(i-1)*factor);
   end    
   s(i)=s(i)/factor;
end
output=s';
end

