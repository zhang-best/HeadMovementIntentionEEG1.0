clear;
A = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\yyb\yybdata300_50s.mat');
B = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\yyb\yybdata300control.mat');
signal = A.signal300;%19*300*208
control = B.control300;
dim = 2;
n = 2;
factor = 30;
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
    rate(1,q) = num/size(signal,3);
    
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
    rate(2,q) = num/size(signal,3);
end
[maxvalue,index] = max(rate(1,:))

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