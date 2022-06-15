% %% pref
% clear;
% name = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
% files_path='E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME';
% filenames = dir([files_path, filesep, '*.gdf']);
% filenum = length(filenames);
% namei =0;
% for n = 1:filenum
%     EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
%     fn = [files_path, filesep, filenames(n).name];
%     EEG = pop_biosig(fn);
%     EEG = eeg_checkset( EEG );
%     EEG = eeg_checkset( EEG );
%     EEG = pop_reref( EEG, []);
%     EEG = eeg_checkset( EEG );
%     EEG = eeg_checkset( EEG );
%     EEG = pop_eegfiltnew(EEG, [],0.6,2816,1,[],1);
%     EEG = eeg_checkset( EEG );
%     EEG = eeg_checkset( EEG );
%     EEG = pop_eegfiltnew(EEG, [],45,152,0,[],1);
%     EEG = eeg_checkset( EEG );
%     EEG = eeg_checkset( EEG );
%     EEG = pop_epoch( EEG, {  '0x600'  '0x603'  }, [-1  4], 'newname', 'GDF file epochs', 'epochinfo', 'yes');
%     EEG = eeg_checkset( EEG );
%     EEG = pop_rmbase( EEG, [-1000     0]);
%     EEG = eeg_checkset( EEG );
%     EEG = eeg_checkset( EEG );
%     EEG = pop_select( EEG,'channel',{'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'handPosX'});
%     EEG = eeg_checkset( EEG );
%     labsig = EEG.data(end,:,:);
%     for i = 1:12
%         for j = 1:2560
%             if(labsig(1,j,i) -3 > 0 || labsig(1,j,i) +3 < 0) 
%                 time(1,i) = j;
%                 j = 2560;
%             end
%         end
%     end
%     list = [1 2 3 4 5 12 13 14 15 16 17 18 27 28 29 30 31 32 33 42 43 44 45 46 47 48 55 56 57 58 59];
%     for i = 1:12
%         for j = 1:size(list,2)
%             starttime = time(1,i)-511;
%             endtime = time(1,i);
%             data(j,:,i) = EEG.data(list(j),starttime:endtime,i);
%         end
%     end
%     label_temp = struct2table(EEG.event);
%     label = label_temp.type;
%     namei = namei+1;
%     path = strcat('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_pref\pref',name(namei),'.mat');
%     save(path,'data','label');
%     clear EEG pathA label label_temp data starttime endtime;
% end
% 
% clear;
% files_path='E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_pref';
% filenames = dir([files_path, filesep, '*.mat']);
% filenum = length(filenames);
% num = 0;
% lnum = 0;
% %label = zeros(1643,1);
% for i=1:filenum
%     fn = [files_path, filesep, filenames(i).name];
%     A = load(fn);
%     B = A.data;
%     C = A.label;  
%     signal(:,:,num+1:num+size(B,3)) = B(:,:,1:size(B,3));
%     for j = 1 : size(C,1) 
%         t = C(j);
%         if(t == 1536)
%             lnum = lnum + 1;
%             label(lnum,1) = 1;            
%         end
%         if(t == 1539)
%             lnum = lnum + 1;
%             label(lnum,1) = 0;           
%         end
%     end
%     num = num + size(B,3);
% end
% save('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_pref\pref\prefdata','signal','label');

%% hcho
clear;
name = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
files_path='E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME';
filenames = dir([files_path, filesep, '*.gdf']);
filenum = length(filenames);
namei =0;
for n = 1:filenum
    EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
    fn = [files_path, filesep, filenames(n).name];
    EEG = pop_biosig(fn);
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    EEG = pop_reref( EEG, []);
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    EEG = pop_eegfiltnew(EEG, [],0.6,2816,1,[],1);
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    EEG = pop_eegfiltnew(EEG, [],45,152,0,[],1);
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, {  '0x604'  '0x605'  }, [-1  4], 'newname', 'GDF file epochs', 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-1000     0]);
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    EEG = pop_select( EEG,'channel',{'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'eeg' 'gesture'});
    EEG = eeg_checkset( EEG );
    labsig = EEG.data(end,:,:);
    for i = 1:12
        for j = 1:2560
            if(labsig(1,j,i)~= 0) 
                time(1,i) = j;
                j = 2560;
            end
        end
    end
    list = [1 2 3 4 5 12 13 14 15 16 17 18 27 28 29 30 31 32 33 42 43 44 45 46 47 48];
    for i = 1:12
        for j = 1:size(list,2)
            starttime = time(1,i)-511;
            endtime = time(1,i);
            data(j,:,i) = EEG.data(list(j),starttime:endtime,i);
        end
    end
    label_temp = struct2table(EEG.event);
    label = label_temp.type;
    namei = namei+1;
    path = strcat('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat\hcho',name(namei),'.mat');
    save(path,'data','label');
    clear EEG pathA label label_temp data starttime endtime;
end

clear;
files_path='E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat';
filenames = dir([files_path, filesep, '*.mat']);
filenum = length(filenames);
num = 0;
lnum = 0;
%label = zeros(1643,1);
for i=1:filenum
    fn = [files_path, filesep, filenames(i).name];
    A = load(fn);
    B = A.data;
    C = A.label;  
    signal(:,:,num+1:num+size(B,3)) = B(:,:,1:size(B,3));
    for j = 1 : size(C,1) 
        t = C(j);
        if(t == 1540)
            lnum = lnum + 1;
            label(lnum,1) = 1;            
        end
        if(t == 1541)
            lnum = lnum + 1;
            label(lnum,1) = 0;           
        end
    end
    num = num + size(B,3);
end
save('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat\hcho\hchodata','signal','label');


% %% pref
% clear;
% load('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_pref\pref\prefdata.mat');
% %对1000ms的数据进行小波分析并输出coefs_channel_trial
% % 将尺度转换为频率后求得的时间-频率图
% fs=512;    %采样频率
% dt=1/fs;    %时间精度
% t=1/fs:1/fs:1;
% channel = size(signal,1);
% timeline = size(signal,2);
% trial = size(signal,3);
% for i = 1:trial
%     for j = 1:channel
%         z=signal(j,:,i);
%         %figure(1)
%         %plot(z);
%         wavename='db4'; %可变参数，分别为db1的
%         %举一个频率转尺度的例子
%         fmin=1;
%         fmax=43;
%         df=1;%0.1
%         f=fmax-df:-df:fmin;%预期的频率
%         wcf=centfrq(wavename); %小波的中心频率
%         scal=fs*wcf./f;%利用频率转换尺度
%         coefs = cwt(z,scal,wavename);
%         temp = abs(coefs);
%         ymax=255;ymin=0;%归一化并取整[0,255]
%         xmax = max(max(temp)); %求得temp中的最大值
%         xmin = min(min(temp)); %求得temp中的最小值
%         Out = round((ymax-ymin)*(temp-xmin)/(xmax-xmin) + ymin); %归一化并取整
%         coefs_channel_trial(:,:,j,i) = Out; 
%     end
% end
% label300 = label;
% save('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_pref\pref\prefwave.mat','coefs_channel_trial','label300');
% 
% %% 对分类器二产生输入数据：进行小波变换和fuzzy计算的图片
% clear;
% name = ["prefdata"];
% for namei = 1 
%     %% 分别计算某人静息态和工作态各次数的19个通道*30个尺度的模糊熵
%     pathA = strcat('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_pref\pref\',name(namei),'.mat');
%     A = load(pathA);
%     signal = A.signal;%19*300*208
%     dim = 2;
%     n = 2;
%     factor = 30;
%     num = 0;
%     channel = size(signal,1);
%     fs=512;dt=1/fs;
%     for q = 1:factor
%         for i = 1:size(signal,3)
%             for j = 1:channel
%                 [mse_fuzzys(j,q,i)] = fuzzymsentropy(signal(j,:,i),q);
%             end
%         end    
%     end
% %% 加载工作态的小波变换图，一共为208次
%     pathC = 'E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_pref\pref\prefwave.mat';
%     C = load(pathC);
%     trials = size(C.coefs_channel_trial,4);
%     coefs_channel_trial(:,:,1:channel,:) = C.coefs_channel_trial;
% %% 合并二者
%     for i = 1:trials
%         for r = 1:8%空8行0
%             for j = 1:channel
%                 coefs_channel_trial(r+42,1:end,j,i) = 0;
%             end
%         end
%     end
%     for i = 1:trials
%         for r = 1:10
%             for j = 1:channel
%                 for q = 1:factor
%                     coefs_channel_trial(r+50,q*17-16:q*17,j,i) = mse_fuzzys(j,q,i);
%                 end
%             end
%         end
%     end
% %% 归一化20-38通道图的值【0，255】
%     for i = 1:trials
%         for j = 1:channel
%             Xmax = max(max(coefs_channel_trial(51:end,:,j,i)));
%             Xmin = min(min(coefs_channel_trial(51:end,:,j,i)));
%             coefs_channel_trial(51:end,:,j,i) = round((coefs_channel_trial(51:end,:,j,i)-Xmin)*255/(Xmax-Xmin));
%         end
%     end
%     label300 = A.label;
%     pathD = 'E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_pref\pref\prefwavefuzzy.mat';
%     save(pathD,'coefs_channel_trial','label300');  
%     clear;
% end

%% hcho
clear;
load('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat\hcho\hchodata.mat');
%对1000ms的数据进行小波分析并输出coefs_channel_trial
% 将尺度转换为频率后求得的时间-频率图
fs=512;    %采样频率
dt=1/fs;    %时间精度
t=1/fs:1/fs:1;
channel = size(signal,1);
timeline = size(signal,2);
trial = size(signal,3);
for i = 1:trial
    for j = 1:channel
        z=signal(j,:,i);
        %figure(1)
        %plot(z);
        wavename='db4'; %可变参数，分别为db1的
        %举一个频率转尺度的例子
        fmin=1;
        fmax=43;
        df=1;%0.1
        f=fmax-df:-df:fmin;%预期的频率
        wcf=centfrq(wavename); %小波的中心频率
        scal=fs*wcf./f;%利用频率转换尺度
        coefs = cwt(z,scal,wavename);
        temp = abs(coefs);
        ymax=255;ymin=0;%归一化并取整[0,255]
        xmax = max(max(temp)); %求得temp中的最大值
        xmin = min(min(temp)); %求得temp中的最小值
        Out = round((ymax-ymin)*(temp-xmin)/(xmax-xmin) + ymin); %归一化并取整
        coefs_channel_trial(:,:,j,i) = Out; 
    end
end
label300 = label;
save('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat\hcho\hchowave.mat','coefs_channel_trial','label300');

%% 对分类器二产生输入数据：进行小波变换和fuzzy计算的图片
clear;
name = ["hchodata"];
for namei = 1 
    %% 分别计算某人静息态和工作态各次数的19个通道*30个尺度的模糊熵
    pathA = strcat('E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat\hcho\',name(namei),'.mat');
    A = load(pathA);
    signal = A.signal;%19*300*208
    dim = 2;
    n = 2;
    factor = 30;
    num = 0;
    channel = size(signal,1);
    fs=512;dt=1/fs;
    for q = 1:factor
        for i = 1:size(signal,3)
            for j = 1:channel
                [mse_fuzzys(j,q,i)] = fuzzymsentropy(signal(j,:,i),q);
            end
        end    
    end
%% 加载工作态的小波变换图，一共为208次
    pathC = 'E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat\hcho\hchowave.mat';
    C = load(pathC);
    trials = size(C.coefs_channel_trial,4);
    coefs_channel_trial(:,:,1:channel,:) = C.coefs_channel_trial;
%% 合并二者
    for i = 1:trials
        for r = 1:8%空8行0
            for j = 1:channel
                coefs_channel_trial(r+42,1:end,j,i) = 0;
            end
        end
    end
    for i = 1:trials
        for r = 1:10
            for j = 1:channel
                for q = 1:factor
                    coefs_channel_trial(r+50,q*17-16:q*17,j,i) = mse_fuzzys(j,q,i);
                end
            end
        end
    end
%% 归一化20-38通道图的值【0，255】
    for i = 1:trials
        for j = 1:channel
            Xmax = max(max(coefs_channel_trial(51:end,:,j,i)));
            Xmin = min(min(coefs_channel_trial(51:end,:,j,i)));
            coefs_channel_trial(51:end,:,j,i) = round((coefs_channel_trial(51:end,:,j,i)-Xmin)*255/(Xmax-Xmin));
        end
    end
    label300 = A.label;
    pathD = 'E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat\hcho\hchowavefuzzy.mat';
    save(pathD,'coefs_channel_trial','label300');  
    clear;
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
