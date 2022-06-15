name = ['fww', 'lc', 'lhy', 'lyb', 'wy', 'wyh', 'xy', 'yyb', 'zc', 'zxj', 'zy', 'zzh']  #
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
        from keras.utils import np_utils
        from keras.models import Sequential
        from keras.layers import Dense, Activation, Convolution3D, MaxPooling3D, Flatten, Dropout, ActivityRegularization
        from keras.optimizers import Adam
        import h5py  # v7.3格式
        from sklearn.model_selection import StratifiedKFold
        import gc
        path = r'E:/science research/转动意图识别/laboratory_data&result/data/转头21_mat/'+namei+'/'+namei+'waveconfusion3DCNN_s.mat'
        data = h5py.File(path)
        # 读取mat文件
        # 读取mat文件中所有数据存储到array中
        coefs_channel_trial_temp = data['coefs_channel_trial'][:]  # 定义矩阵
        coefs = coefs_channel_trial_temp / 255
        num_f = coefs.shape[4]
        timeline = coefs.shape[3]
        y_num = coefs.shape[2]
        x_num = coefs.shape[1]
        trial = coefs.shape[0]
        label300_temp = data['label300'][:]  # 定义矩阵
        c = label300_temp.shape[1]
        d = label300_temp.shape[0]
        label300 = np.ones((c,))  # 定义矩阵
        for i in range(0, d):
            for j in range(0, c):
                label300[j] = int(label300_temp[i, j])
        A = np.ones((trial,))
        B = np.ones((trial, 1))
        kfold = StratifiedKFold(n_splits=10, shuffle=True, random_state=seed)
        cvscores = []
        # build neural network
        for train, test in kfold.split(B, A):
            TRAIN = np.empty((trial // 10 * 9, x_num, y_num, timeline, num_f))
            for i in range(0, trial // 10 * 9):
                TRAIN[i, :, :, :, :] = coefs[train[i], :, :, :, :]
            TEST = np.empty((trial // 10 * 1, x_num, y_num, timeline, num_f))
            for i in range(0, trial // 10 * 1):
                TEST[i, :, :, :, :] = coefs[test[i], :, :, :, :]
            TRAIN_label300 = np.empty((trial // 10 * 9,))
            for i in range(0, trial // 10 * 9):
                TRAIN_label300[i] = label300[train[i]] - 1
            TEST_label300 = np.empty((trial // 10 * 1,))
            for i in range(0, trial // 10 * 1):
                TEST_label300[i] = label300[test[i]] - 1
            TRAIN_label300_class = np_utils.to_categorical(TRAIN_label300, num_classes=2)  #
            TEST_label300_class = np_utils.to_categorical(TEST_label300, num_classes=2)  #
            model = Sequential(
            )
            model.add(Convolution3D(
                16, (2, 1, 3),
                strides=(2, 1, 1),
                border_mode='same',  # padding method
                input_shape=(  # channels
                    x_num, y_num, timeline, num_f)  # length and width
            ))
            model.add(Activation('relu'))

            model.add(MaxPooling3D(
                pool_size=(1, 1, 3),
                strides=(1, 1, 1),
                border_mode='same',  # padding method
            ))

            # 这是添加第二层神经网络，卷积层，激励函数，池化层
            model.add(Convolution3D(32, (2, 2, 3), border_mode='same'))
            model.add(Activation('relu'))
            model.add(MaxPooling3D(pool_size=(2, 2, 6), strides=(1, 1, 3), border_mode='valid'))  # size=6.3

            # 这是添加第三层神经网络，卷积层，激励函数，池化层

            model.add(Convolution3D(32, (1, 1, 3), border_mode='same'))
            model.add(Activation('relu'))
            model.add(MaxPooling3D(pool_size=(1, 1, 6), strides=(1, 1, 3), border_mode='valid'))  # size=6.4
            model.add(Flatten())
            model.add(Dense(1024))  # , kernel_regularizer=regularizers.l2(2), activity_regularizer=regularizers.l1(2),利用正则化来减少过拟合现象1024-512-150-59%
            model.add(Activation('relu'))
            model.add(ActivityRegularization(l2=0.005))
            model.add(Dropout(0.3))
            model.add(Dense(512))
            model.add(Activation('relu'))
            model.add(ActivityRegularization(l2=0.005))
            model.add(Dropout(0.3))
            model.add(Dense(2))
            # 使用softmax进行分类
            model.add(Activation('softmax'))

            adam = Adam(lr=4e-7)  # alldata lr=3e-7

            model.compile(
                loss='categorical_crossentropy',  #
                optimizer=adam,
                metrics=['accuracy'])

            print('\nTraining-----------')
            H = model.fit(TRAIN, TRAIN_label300_class, nb_epoch=120,
                          batch_size=1)  # 测试的间隔次数为20,validation_split=0.2,,  validation_freq=1
            print('\nTesting------------')
            loss, accuracy = model.evaluate(TEST, TEST_label300_class)
            print('test loss: ', loss)
            print('test accuracy: ', accuracy)

            print('test before save:')  # 预测
            # model.save('E:\pycharm projects\zhuantou\zhuantou1_model.h5')
            cvscores.append(accuracy * 100)
            K.clear_session()
            # plot the training loss and accuracy
        print("%.2f%% (+/- %.2f%%)" % (np.mean(cvscores), np.std(cvscores)))
        f = open('C://Users/001/Desktop/1.txt', 'a', encoding='utf-8')  ##ffilename可以是原来的txt文件，也可以没有然后把写入的自动创建成txt文件
        f.write("%s %d :" % (namei, seed))
        f.write("%.2f%% (+/- %.2f%%)\n" % (np.mean(cvscores), np.std(cvscores)))
        f.close()
        val_not_del = ['name', 'namei', 'seedi', 'gc', 'val_not_del', 'K']
        for key in list(globals().keys()):
            if (key != "key") and (key not in val_not_del):  #(not key.startswith("__")) and
                del globals()[key]
                gc.collect()
        del key
        gc.collect()
        K.clear_session() # 方法一：如果不关闭，则会一直占用显存
