name = ['fww', 'lc', 'lhy', 'lyb', 'wy', 'wyh', 'xy', 'yyb', 'zc', 'zxj', 'zy', 'zzh']#
for namei in name:
    for seedi in range(1, 2):
        '''k折交叉验证法，计算k次准确率取平均值，随机种子不一样，结果也不一样，添加了DROPOUT'''
        seed = seedi
        import keras.backend as K
        import numpy as np
        np.random.seed(seed)
        import random
        random.seed(seed)
        import tensorflow as tf
        tf.random.set_seed(seed)
        import keras.callbacks as KC
        import keras
        from keras.utils import np_utils
        from keras.models import Sequential
        from keras.layers import Dense, Activation, Convolution2D, MaxPooling2D, Flatten, Dropout,ActivityRegularization
        from keras.optimizers import Adam
        import h5py  # v7.3格式
        from sklearn.model_selection import StratifiedKFold
        import sklearn.metrics as skm
        import gc
        path = r'E:/science research/转动意图识别/laboratory_data&result/data/转头21_mat/'+namei+'/'+namei+'wavefuzzy300_50s.mat'
        data = h5py.File(path)
        # 读取mat文件
        # 读取mat文件中所有数据存储到array中
        coefs_channel_trial_temp = data['coefs_channel_trial'][:]  # 定义矩阵
        a = coefs_channel_trial_temp.shape[3]
        b = coefs_channel_trial_temp.shape[2]
        c = coefs_channel_trial_temp.shape[1]
        d = coefs_channel_trial_temp.shape[0]
        coefs_channel_trial = np.empty((a, b, c, d))  # 定义矩阵
        for i in range(0, d):
            for j in range(0, c):
                for k in range(0, b):
                    for h in range(0, a):
                        coefs_channel_trial[h, k, j, i] = coefs_channel_trial_temp[i, j, k, h]/255
        trial = coefs_channel_trial.shape[3]
        channel = coefs_channel_trial.shape[2]
        timeline = coefs_channel_trial.shape[1]
        num_f = coefs_channel_trial.shape[0]
        coefs = np.empty((trial, num_f, timeline, channel))  # 定义矩阵
        for i in range(0, trial):
            for j in range(0, channel):
                coefs[i, :, :, j] = coefs_channel_trial[:, :, j, i]  # 转换维度
        label300_temp = data['label300'][:]  # 定义矩阵
        c = label300_temp.shape[1]
        d = label300_temp.shape[0]
        label300 = np.ones((c,))  # 定义矩阵
        for i in range(0, d):
            for j in range(0, c):
                label300[j, ] = int(label300_temp[i, j])  # 转换维度
        del data, coefs_channel_trial_temp, coefs_channel_trial, label300_temp
        gc.collect()
        '''随机划分训练集和测试集'''
        num_trainval = 180
        folds = 10
        listdata = range(0, trial)
        index_1 = np.random.choice(listdata, size=trial - num_trainval, replace=False, )
        index_2 = np.delete(listdata, index_1)
        TRAIN_VAL = np.empty((num_trainval, num_f, timeline, channel))
        for i in range(0, num_trainval):
            TRAIN_VAL[i, :, :, :] = coefs[index_2[i], :, :, :]
        TEST = np.empty((trial - num_trainval, num_f, timeline, channel))
        for i in range(0, trial - num_trainval):
            TEST[i, :, :, :] = coefs[index_1[i], :, :, :]
        TRAIN_VAL_label300 = np.empty((num_trainval,))
        for i in range(0, num_trainval):
            TRAIN_VAL_label300[i, ] = label300[index_2[i]] - 1
        TEST_label300 = np.empty((trial - num_trainval,))
        for i in range(0, trial - num_trainval):
            TEST_label300[i, ] = label300[index_1[i]] - 1
        del coefs, label300
        gc.collect()
        '''随机划分训练集和验证集'''
        trial = num_trainval
        A = np.ones((trial,))
        B = np.ones((trial, 1))
        kfold = StratifiedKFold(n_splits=folds, shuffle=True, random_state=seed)
        cvscores = []
        f1scores = []
        accuracy_now = 0
        # build neural network
        for train, val in kfold.split(B, A):
            TRAIN = np.empty((trial // folds * (folds-1), num_f, timeline, channel))
            for i in range(0, trial // folds * (folds-1)):
                TRAIN[i, :, :, :] = TRAIN_VAL[train[i], :, :, :]
            VAL = np.empty((trial // folds * 1, num_f, timeline, channel))
            for i in range(0, trial // folds * 1):
                VAL[i, :, :, :] = TRAIN_VAL[val[i], :, :, :]
            TRAIN_label300 = np.empty((trial // folds * (folds-1),))
            for i in range(0, trial // folds * (folds-1)):
                TRAIN_label300[i,] = TRAIN_VAL_label300[train[i]]
            VAL_label300 = np.empty((trial // folds * 1,))
            for i in range(0, trial // folds * 1):
                VAL_label300[i,] = TRAIN_VAL_label300[val[i]]
            TRAIN_label300_class = np_utils.to_categorical(TRAIN_label300, num_classes=2)  #
            VAL_label300_class = np_utils.to_categorical(VAL_label300, num_classes=2)  #
            TEST_label300_class = np_utils.to_categorical(TEST_label300, num_classes=2)  #
            #callback = KC.callbacks.EarlyStopping(monitor='val_loss', patience=6)  # 使用loss作为监测数据，轮数设置为1
            model = Sequential(
            )
            model.add(Convolution2D(
                nb_filter=8,
                nb_col=3,
                nb_row=3,
                border_mode='same',  # padding method
                input_shape=(  # channels
                    num_f, timeline, channel)  # length and width
            ))
            model.add(Activation('relu'))

            model.add(MaxPooling2D(
                pool_size=(3, 3),
                strides=(1, 1),
                border_mode='same',  # padding method
            ))

            # 这是添加第二层神经网络，卷积层，激励函数，池化层
            model.add(Convolution2D(16, 3, 3, border_mode='same'))
            model.add(Activation('relu'))
            model.add(MaxPooling2D(pool_size=(6, 4), strides=(2, 2), border_mode='valid'))  # size=6.3

            # 这是添加第三层神经网络，卷积层，激励函数，池化层
            model.add(Convolution2D(32, 3, 3, border_mode='same'))
            model.add(Activation('relu'))
            model.add(MaxPooling2D(pool_size=(6, 4), strides=(2, 2), border_mode='valid'))  # size=6.4
            model.add(Flatten())
            model.add(Dense(600, kernel_regularizer=keras.regularizers.l2(0.002), activation='relu')) #  activity_regularizer=keras.regularizers.l1(0.002), , kernel_regularizer=regularizers.l2(2), activity_regularizer=regularizers.l1(2),利用正则化来减少过拟合现象
            model.add(Dropout(0.2))
            model.add(Dense(300, kernel_regularizer=keras.regularizers.l2(0.002), activation='relu'))  # activity_regularizer=keras.regularizers.l1(0.002), , kernel_regularizer=regularizers.l2(2), activity_regularizer=regularizers.l1(2),利用正则化来减少过拟合现象
            model.add(Dense(2))
            # 使用softmax进行分类
            model.add(Activation('softmax'))

            # Another way to define your optimize

            adam = Adam(lr=1e-4)  # alldata lr=3e-7

            model.compile(
                loss='categorical_crossentropy',  #
                optimizer=adam,
                metrics=['accuracy'])

            print('\nTraining-----------')
            H = model.fit(TRAIN, TRAIN_label300_class, nb_epoch=100,
                          batch_size=9, validation_data=(VAL, VAL_label300_class), validation_freq=1,
                          )  # 测试的间隔次数为20,2 callbacks=[callback],
            print('\nTesting------------')
            loss, accuracy = model.evaluate(TEST, TEST_label300_class)
            print('test loss: ', loss)
            print('test accuracy: ', accuracy)
            cvscores.append(accuracy * 100)

            pred = model.predict(TEST)
            pred = np.round(pred)
            F1 = skm.f1_score(y_true=TEST_label300_class, y_pred=pred, average='macro')
            f1scores.append(F1 * 100)

            f = open('C://Users/001/Desktop/fuzzy2.txt', 'a', encoding='utf-8')  ##ffilename可以是原来的txt文件，也可以没有然后把写入的自动创建成txt文件
            f.write("%s:\n" % (namei))
            f.write("%s\n \n" % (H.history["val_loss"]))
            f.close()

            if (accuracy_now < accuracy):
                accuracy_now = accuracy
                model.save('E:/pycharm projects/zhuantou3-3class/model/fuzzylrmodel' + namei + '.h5')
            print('test before save:')  # 预测
            K.clear_session()

        # plot the training loss and accuracy
        print("%.2f%% (+/- %.2f%%)" % (np.mean(cvscores), np.std(cvscores)))
        f = open('C://Users/001/Desktop/fuzzy1.txt', 'a', encoding='utf-8')  ##ffilename可以是原来的txt文件，也可以没有然后把写入的自动创建成txt文件
        f.write("%s:\n" % (namei))
        f.write("准确率：\n%s\n" % (cvscores))
        f.write("%.2f%% (+/- %.2f%%)\n" % (np.mean(cvscores), np.std(cvscores)))
        f.write("F1：\n%s\n" % (f1scores))
        f.write("%.2f%% (+/- %.2f%%)\n" % (np.mean(f1scores), np.std(f1scores)))
        f.close()
        val_not_del = ['name', 'namei', 'seedi', 'gc', 'val_not_del', 'K']
        for key in list(globals().keys()):
            if (key != "key") and (key not in val_not_del):  #(not key.startswith("__")) and
                del globals()[key]
                gc.collect()
        del key
        gc.collect()
        K.clear_session() # 方法一：如果不关闭，则会一直占用显存
