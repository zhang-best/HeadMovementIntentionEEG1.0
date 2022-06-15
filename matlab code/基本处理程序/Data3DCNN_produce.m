%% 改变数据格式方便进行3D-CNN
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
    coefs_channel_trial = zeros(TRIAL,8,14,TIME,FREQ);
    for i = 1:TRIAL
            for t = 1:TIME
                for f = 1:FREQ
%                   coefs_channel_trial(i,9,5,t,j) = A.coefs_channel_trial(f,t,18,i);
%                   coefs_channel_trial(i,9,7,t,j) = A.coefs_channel_trial(f,t,16,i);
%                   coefs_channel_trial(i,9,9,t,j) = A.coefs_channel_trial(f,t,17,i);
%                   coefs_channel_trial(i,9,11,t,j) = A.coefs_channel_trial(f,t,19,i);
                    for r = 1:2
                        for c = 3:4
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,2,i);
                        end
                        for c = 7:8
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,1,i);
                        end
                        for c = 11:12
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,3,i);
                        end
                    end
                    for r = 3:4
                        for c = 3:4
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,7,i);
                        end
                        for c = 5:6
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,5,i);
                        end
                        for c = 7:8
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,4,i);
                        end
                        for c = 9:10
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,6,i);
                        end
                        for c = 11:12
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,8,i);
                        end
                    end
                    for r = 5:6
                        for c = 1:2
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,14,i);
                        end
                        for c = 3:4
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,12,i);
                        end
                        for c = 5:6
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,10,i);
                        end
                        for c = 7:8
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,9,i);
                        end
                        for c = 9:10
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,11,i);
                        end
                        for c = 11:12
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,13,i);
                        end
                        for c = 13:14
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,15,i);
                        end
                    end
                    for r = 7:8
                        for c = 3:4
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,18,i);
                        end
                        for c = 5:6
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,16,i);
                        end
                        for c = 9:10
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,17,i);
                        end
                        for c = 11:12
                            coefs_channel_trial(i,r,c,t,f) = A.coefs_channel_trial(f,t,19,i);
                        end
                    end
                end
            end
    end
    coefs_channel_trial = permute(coefs_channel_trial,[5 4 3 2 1]);
    pathB = 'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\'+name(namei)+'\'+name(namei)+'wave3DCNN_s.mat';
    save(pathB,'coefs_channel_trial','label300');
end
