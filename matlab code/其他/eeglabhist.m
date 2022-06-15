clear;
name = ["冯万玮" "刘畅" "李赫洋" "刘元博" "王毅" "王宇航" "肖毅" "杨焱博" "张驰" "周湘杰" "周煜" "张志毫"];
EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
n = 0;
for namei = 1:12 
    files_path = 'E:\science research\转动意图识别\laboratory_data&result\data\转头数据_set\'+name(namei);
    files_path = str2mat(files_path);
    filenames = dir([files_path, filesep, '*.set']);
    for i = 1:size(filenames)
        fn = [files_path, filesep, filenames(i).name];
        EEG = pop_loadset(fn);
        EEG=pop_chanedit(EEG, 'lookup','E:\\science research\\脑电资料\\program\\完整版的eeglab14_1_2b\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
        EEG = pop_reref( EEG, []);
        EEG = pop_select( EEG,'channel',{'FCz' 'FC3' 'FC4'});%
        EEG = pop_epoch( EEG, {  '1'  '2'  }, [0         0.3], 'newname', 'BDF file epochs', 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [0  299]);
        epoch = size(EEG.epoch,2);
        for j  = 1:epoch
           EEGs = pop_selectevent( EEG, 'epoch',j,'deleteevents','off','deleteepochs','on','invertepochs','off');
           tic;
           EEGs = pop_eegfiltnew(EEGs, [],1,3300,1,[],1);
           EEGs = pop_eegfiltnew(EEGs, [],40,330,0,[],1);
           EEGs = pop_eegfiltnew(EEGs, 49,51,3300,1,[],1);
           toc;
           n = n+1;
           cost(n) = toc;
        end
    end
end

