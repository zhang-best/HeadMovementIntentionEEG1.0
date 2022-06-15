%% 改变数据格式方便进行3D-CNNconfusion
clear;
name = ["fww" "lc" "lhy" "lyb" "wy" "wyh" "xy" "yyb" "zc" "zxj" "zy" "zzh"];% 
for namei = 1:12
    pathA = 'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\'+name(namei)+'wave300_50s.mat';
    A = load(pathA);
    FREQ = size(A.coefs_channel_trial,1);
    TIME = size(A.coefs_channel_trial,2);
    CHANNEL = size(A.coefs_channel_trial,3);
    TRIAL = size(A.coefs_channel_trial,4);
    label300 = A.label300;
    coefs_channel_trial = zeros(TRIAL,19,10,TIME,FREQ);
    for i = 1:TRIAL
            for t = 1:TIME
                for f = 1:FREQ
                    for r = 1:CHANNEL-9
                        for c = r:CHANNEL
                            temp1 = (A.coefs_channel_trial(f,t,r,i)+A.coefs_channel_trial(f,t,c,i))/2;
                            temp2 = abs(A.coefs_channel_trial(f,t,r,i)-A.coefs_channel_trial(f,t,c,i))/2;
                            coefs_channel_trial(i,2*c-1,r,t,f) = temp1;
                            coefs_channel_trial(i,2*c,r,t,f) = temp2;
                        end
                    end      
                end
            end
    end
    for i = 1:TRIAL
        for t = 1:TIME
            for f = 1:FREQ
                for r = 2:CHANNEL-9
                    for c = 1:r-1
                        temp1 = (A.coefs_channel_trial(f,t,r+2*(11-r)-1,i)+A.coefs_channel_trial(f,t,c+20-r,i))/2;
                        temp2 = abs(A.coefs_channel_trial(f,t,r+2*(11-r)-1,i)-A.coefs_channel_trial(f,t,c+20-r,i))/2;
                        coefs_channel_trial(i,2*c-1,r,t,f) = temp1;
                        coefs_channel_trial(i,2*c,r,t,f) = temp2;
                    end
                end      
            end
        end
    end
    coefs_channel_trial = permute(coefs_channel_trial,[5 4 3 2 1]);%反转
    pathB = 'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\'+name(namei)+'waveconfusion3DCNN_s.mat';
    save(pathB,'coefs_channel_trial','label300');
end
