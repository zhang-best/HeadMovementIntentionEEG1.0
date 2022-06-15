clear;
A = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\zzh\zzhdata300_50s.mat');
B = load('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\zzh\zzhdata300control.mat');
signal = A.signal300;%19*300*208
control = B.control300;
dim = 2;
n = 2;
factor = 10;
num = 0;
for i = 1:size(signal,3)
    for j = 1:size(signal,1)
        [mse_fuzzys,~] = fuzzymsentropy(signal(j,:,i),factor);
        [mse_fuzzyc,~] = fuzzymsentropy(control(j,:,i),factor);
%        mse_fuzzys = sort(mse_fuzzys);
%        mse_fuzzyc = sort(mse_fuzzyc);
        FuzzyEns(j,i) = sum(mse_fuzzys(1,1:factor));
        FuzzyEnc(j,i) = sum(mse_fuzzyc(1,1:factor));%取多尺度下最大的几个熵求和得到每次的通道熵
    end
end
for i =1:size(signal,3)
    FuzzyEns = sort(FuzzyEns);
    FuzzyEnc = sort(FuzzyEnc);
    FuzzyEns_total(1,i) = sum(FuzzyEns(1:19,i));
    FuzzyEnc_total(1,i) = sum(FuzzyEnc(1:19,i));%取19个通道中最大的几个熵求和得到每次的熵
end


FuzzyEn_all(1,:)=FuzzyEns_total(1,:);
FuzzyEn_all(2,:)=FuzzyEnc_total(1,:);
for i =1:size(signal,3)
    if(FuzzyEn_all(1,i)<FuzzyEn_all(2,i))
        num = num+1;
    end
end
num/size(signal,3)
%% 用单个比大小方法，不考虑值
% Fuzzy = FuzzyEnc - FuzzyEns;
% for i = 1:19
%     for j = 1:208
%         if(Fuzzy(i,j)>0)
%             Fuzzy(i,j)=1;
%         else
%             Fuzzy(i,j)=-1;
%         end
%     end
% end
% for i =1:208
%     if(sum(Fuzzy(1:15,i))>0)
%         num = num+1;
%     end
% end

%% 支持向量机
% for i =1:150
%     for j = 1:19
%         Fuzzy(j,i) = FuzzyEns(j,i);
%         Fuzzy(j,i+150) = FuzzyEnc(j,i);
%     end
% end
% for i =1:58
%     for j = 1:19
%         test(j,i) = FuzzyEns(j,i+150);
%         test(j,i+58) = FuzzyEnc(j,i+150);
%     end
% end
% for i = 1:150
%     label(i,1) = A.label300(i,1);
%     label(i+150,1) = B.label300(i,1);
% end
% 
% SVMStruct=fitcsvm(Fuzzy,label(1:300,1),'linear','showplot',true);
% predict_group=ClassificationSVM(SVMStruct,test,'showplot',true);

function FuzzyEn = FuzzyEn(series,dim,r,n)
%{
Function which computes the Fuzzy Entropy (FuzzyEn) of a time series. The
alogorithm presented by Chen et al. at "Charactirization of surface EMG
signal based on fuzzy entropy" (DOI: 10.1109/TNSRE.2007.897025) has been
followed.

INPUT:
        series: the time series.
        dim: the embedding dimesion employed in the SampEn algorithm.
        r: the width of the fuzzy exponential function.
        n: the step of the fuzzy exponential function.

OUTPUT:
        FuzzyEn: the FuzzyEn value. 

PROJECT: Research Master in signal theory and bioengineering - University of Valladolid

DATE: 11/10/2014

VERSION: 1�

AUTHOR: Jes鷖 Monge 羖varez
%}
%% Checking the ipunt parameters:
control = ~isempty(series);
assert(control,'The user must introduce a time series (first inpunt).');
control = ~isempty(dim);
assert(control,'The user must introduce a embbeding dimension (second inpunt).');
control = ~isempty(r);
assert(control,'The user must introduce a width for the fuzzy exponential function: r (third inpunt).');
control = ~isempty(n);
assert(control,'The user must introduce a step for the fuzzy exponential function: n (fourth inpunt).');

%% Processing:
% Normalization of the input time series:
% series = (series-mean(series))/std(series);
N = length(series);
phi = zeros(1,2);
% Value of 'r' in case of not normalized time series:
% r = r*std(series);

for j = 1:2
    m = dim+j-1; % 'm' is the embbeding dimension used each iteration
    % Pre-definition of the varialbes for computational efficiency:
    patterns = zeros(m,N-m+1);
    aux = zeros(1,N-m+1);
    
    % First, we compose the patterns
    % The columns of the matrix 'patterns' will be the (N-m+1) patterns of 'm' length:
    if m == 1 % If the embedding dimension is 1, each sample is a pattern
        patterns = series;
    else % Otherwise, we build the patterns of length 'm':
        for i = 1:m
            patterns(i,:) = series(i:N-m+i);
        end
    end
    % We substract the baseline of each pattern to itself:
    for i = 1:N-m+1
        patterns(:,i) = patterns(:,i) - (mean(patterns(:,i)));
    end

    % This loop goes over the columns of matrix 'patterns':
    for i = 1:N-m
        % Second, we compute the maximum absolut distance between the
        % scalar components of the current pattern and the rest:
        if m == 1 
            dist = abs(patterns - repmat(patterns(:,i),1,N-m+1));
        else
            dist = max(abs(patterns - repmat(patterns(:,i),1,N-m+1)));
        end
       % Third, we get the degree of similarity:
       simi = exp(((-1)*((dist).^n))/r);
       % We average all the degrees of similarity for the current pattern:
       aux(i) = (sum(simi)-1)/(N-m-1); % We substract 1 to the sum to avoid the self-comparison
    end

    % Finally, we get the 'phy' parameter as the as the mean of the first
    % 'N-m' averaged drgees of similarity:
    phi(j) = sum(aux)/(N-m);
end

FuzzyEn = log(phi(1)) - log(phi(2));

end %End of the 'FuzzyEn' function



% Function for calculating multiscale entropy
% input: signal
% m: match point(s)
% r: matching tolerance
% factor: number of scale factor
% sampenc is available at http://people.ece.cornell.edu/land/PROJECTS/Complexity/sampenc.m
%多尺度模糊熵的意思是在不同的时间尺度下进行熵计算，其中不同的时间尺度就是利用coarsegraining粗粒度，即取均值。
function [mse_fuzzy,sf] = fuzzymsentropy(input,factor)

y=input;
y=y-mean(y);
st=std(y);  
y=y/st;

for i=1:factor
   s=coarsegraining(y,i);
   sampe = FuzzyEn(s,2,0.15*st,2);
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
