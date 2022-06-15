clear;
name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];
for namei = 1:12 
    %% 分别计算某人静息态和工作态各次数的19个通道*42个尺度的模糊熵
    pathA = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'data300_50s.mat');
    pathB = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'data300control.mat');
    A = load(pathA);
    B = load(pathB);
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
            end
        end    
    end
%% 加载静息态和工作态的小波变换图，一共为2*208次，前面是静息态，后面是工作态
    pathC = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'wave300cs.mat');
    C = load(pathC);
    trials = size(C.coefs_channel_trial,4);
    coefs_channel_trial(:,:,1:19,:) = C.coefs_channel_trial;
%% 合并二者
    for i = 1:trials/2
        for r = 1:8%空8行0
            for j = 1:19
                coefs_channel_trial(r+42,1:end,j,i) = 0;
                coefs_channel_trial(r+42,1:end,j,i + trials/2) = 0;
            end
        end
    end
    for i = 1:trials/2
        for r = 1:10
            for j = 1:19
                for q = 1:factor
                    coefs_channel_trial(r+50,q*10-9:q*10,j,i) = mse_fuzzyc(j,q,i);
                    coefs_channel_trial(r+50,q*10-9:q*10,j,i + trials/2) = mse_fuzzys(j,q,i);
                end
            end
        end
    end
%% 归一化20-38通道图的值【0，255】
    for i = 1:trials
        for j = 1:19
            Xmax = max(max(coefs_channel_trial(51:end,:,j,i)));
            Xmin = min(min(coefs_channel_trial(51:end,:,j,i)));
            coefs_channel_trial(51:end,:,j,i) = round((coefs_channel_trial(51:end,:,j,i)-Xmin)*255/(Xmax-Xmin));
        end
    end
    label300 = C.label300;
    pathD = strcat('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\',name(namei),'\',name(namei),'wavefuzzy300cs.mat');
    save(pathD,'coefs_channel_trial','label300');  
    clear;
    name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];
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