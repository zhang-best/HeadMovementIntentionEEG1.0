% EEGLAB history file generated on the 14-May-2021
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','wyhICA8(-50-100).set','filepath','E:\\science research\\转动意图识别\\laboratory_data&result\\data\\转头21_mat\\王宇航\\ICA(-50-100)\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;
save('E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\王宇航\ICA(-50-100)\wyhICA8(-50-100).mat','EEG');%改文件名称