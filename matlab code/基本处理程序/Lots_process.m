eeglab;
i=8;%改变数字
files_path='E:\science research\转动意图识别\laboratory_data&result\data\转头数据_set\周煜';%'D:\0PCL\experiment\EXPweizhi\data_set\sub01';
filenames = dir([files_path, filesep, '*.set']);
files_path_preprocessed='E:\science research\转动意图识别\laboratory_data&result\data\转头23_mat\周煜';%改文件夹号码
fn = [files_path, filesep, filenames(i).name];
EEG = pop_loadset(fn);
   
EEG.etc.eeglabvers = '14.1.2';
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'lookup','E:\\science research\\脑电资料\\program\\完整版的eeglab14_1_2b\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'channel',{'Fp1' 'Fp2' 'Fz' 'F1' 'F2' 'F3' 'F4' 'FCz' 'FC1' 'FC2' 'FC3' 'FC4' 'Cz' 'C1' 'C2' 'C3' 'C4' 'C5' 'C6' 'CP1' 'CP2' 'CP3' 'CP4'});
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, [],1,3300,1,[],1);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, [],40,330,0,[],1);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, 49,51,3300,1,[],1);
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '1'  '2'  }, [-0.5           3], 'newname', 'BDF file epochs', 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-500    0]);
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',strcat('zy8.set'),'filepath',files_path_preprocessed);%改文件名称
save('E:\science research\转动意图识别\laboratory_data&result\data\转头23_mat\周煜\zy8','EEG');%改文件名称

