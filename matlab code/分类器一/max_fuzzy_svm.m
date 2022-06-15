clear;
name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];
for namei = 1:12  
    pathA = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'data300_50s.mat');
    pathB = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'data300control.mat');
    A = load(pathA);
    B = load(pathB);
    signal = A.signal300;%19*300*208
    control = B.control300;
    dim = 2;
    n = 2;
    factor = 20;
    num = 0;
    fs=1000;dt=1/fs;
    for q = 1:factor
        for i = 1:size(signal,3)
            for j = 1:size(signal,1)
                [mse_fuzzys(j,q,i)] = fuzzymsentropy(signal(j,:,i),q);
                [mse_fuzzyc(j,q,i)] = fuzzymsentropy(control(j,:,i),q);
                FuzzyEns(j,i) = sum(mse_fuzzys(j,q,i));
                FuzzyEnc(j,i) = sum(mse_fuzzyc(j,q,i));%取多尺度下最大的几个熵求和得到每次的通道熵5:factor
            end
        end

%% 通过19个熵值和19个U节律来作为融合特征，计算同一次动和不动前后是否存在明显差值，发现确实具有明显差值变大，所有人都在99%以上，大部分100%
        result = zeros(19,208);
        num = 0;
        for i =1:size(signal,3)
            for j =1:size(signal,1)
                if(FuzzyEnc(j,i)<FuzzyEns(j,i))
                    result(j,i)=result(j,i)-1;
                end
                if(FuzzyEnc(j,i)>FuzzyEns(j,i))
                    result(j,i)=result(j,i)+1;
                end
            end
        end
        for i =1:size(signal,3)
            results(1,i) = sum(result(:,i));
        end
        for i =1:size(signal,3)
            if(results(1,i)>0)
                num = num+1;
            end
        end
        result = zeros(19,208);
        num = 0;
        for i =1:size(signal,3)
            for j =1:size(signal,1)
                if(FuzzyEnc(j,i)<FuzzyEns(j,i))
                    result(j,i)=result(j,i)+1;
                end
                if(FuzzyEnc(j,i)>FuzzyEns(j,i))
                    result(j,i)=result(j,i)-1;
                end
            end
        end
        for i =1:size(signal,3)
            results(1,i) = sum(result(:,i));
        end
        for i =1:size(signal,3)
            if(results(1,i)>0)
                num = num+1;
            end
        end
        for i =1:150%生成训练集300=150空闲+150工作
            for j = 1:19
                X(j,i) = mse_fuzzyc(j,q,i);
                X(j,i+150) = mse_fuzzys(j,q,i);
                classX(i,1) = 0;
                classX(i+150,1) = 1;
            end
        end
        X = X';
        t = size(signal,3)-150;
        for i =1:t%生成训练集114=57空闲+57工作
            for j = 1:19
                Y(j,i) = mse_fuzzyc(j,q,i+150);
                Y(j,i+t) = mse_fuzzys(j,q,i+150);
                classY(i,1) = 0;
                classY(i+t,1) = 1;
            end
        end
        Y = Y';
        Model = fitclinear(X,classX);
        preict = predict(Model,Y);
        num = 0;
        for i =1:2*t%生成训练集114=57空闲+57工作
            if(i<t+1 && preict(i,1)==0)
                num=num+1;
            end
            if(i>t && preict(i,1)==1)
                num=num+1;
            end
        end
        accuracy1 = num/(2*t);
        rate(q) = accuracy1;
        clear X Y classX classY;
    end
    [maxvalue,index] = max(rate)
end



function [COEFF,DIST,CLASS] = dclass(X1,X2,X)
%    dclass作为两个模式类的距离判别分析
%    语法[COFEE,DIST,CLASS]=dclass(X1,X2,X)
%    x1,x2——分别为类1、类2的训练样本“样品×变量”矩阵
%    x——为待判样品的“样品×变量”矩阵
%    COEFF——判别函数的系数向量
%    CLASS——待判样品的分类
[N1,~]=size(X1);
[N2,~]=size(X2);
[N,~]=size(X);
MEANX1=mean(X1);
MEANX2=mean(X2);
COVX1=(N1-1)*cov(X1);
COVX2=(N2-1)*cov(X2);
MEAN=(MEANX1+MEANX2)./2;
COV=(COVX1+COVX2)./(N1+N2-2);
COEFF=inv(COV)*(MEANX1-MEANX2)';
DIST=[];
CLASS=[];
for byk=1:N
    w=(X(byk,:)-MEAN)*COEFF;
    if w>0
        r=1;
    else
        r=2;
    end
    DIST=[DIST,w];
    CLASS=[CLASS,r];
end
COEFF=COEFF';
end

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
function [mse_fuzzy] = fuzzymsentropy(input,factor)

y=input;
y=y-mean(y);
st=std(y);  
y=y/st;

for i=factor
   s=coarsegraining(y,i);
   sampe = FuzzyEn(s,2,0.15*st,2);
   %sampe = fuzzyEn(s, m+1, r);
   %sampe=sampenc(s,m+1,r);
   mse_fuzzy=sampe;
   %e(2,i)=sampe(m+1);   
end
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
