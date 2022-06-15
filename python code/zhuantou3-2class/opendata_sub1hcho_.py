for seedi in range(1, 4):
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
    from keras.layers import Dense, Activation, Convolution2D, MaxPooling2D, Flatten, Dropout
    from keras.optimizers import Adam
    import h5py  # v7.3格式
    from sklearn.model_selection import StratifiedKFold
    import gc

    path = r'E:\science research\转动意图识别\公开数据集\15sub-6move\S01_ME_mat\hcho\hchowave.mat'
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
                    coefs_channel_trial[h, k, j, i] = coefs_channel_trial_temp[i, j, k, h] / 255
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
            label300[j,] = int(label300_temp[i, j])
    A = np.ones((trial,))
    B = np.ones((trial, 1))
    kfold = StratifiedKFold(n_splits=4, shuffle=True, random_state=seed)
    cvscores = []
    # build neural network
    for train, test in kfold.split(B, A):
        TRAIN = np.empty((trial // 4 * 3, num_f, timeline, channel))
        for i in range(0, trial // 4 * 3):
            TRAIN[i, :, :, :] = coefs[train[i], :, :, :]
        TEST = np.empty((trial // 4 * 1, num_f, timeline, channel))
        for i in range(0, trial // 4 * 1):
            TEST[i, :, :, :] = coefs[test[i], :, :, :]
        TRAIN_label300 = np.empty((trial // 4 * 3,))
        for i in range(0, trial // 4 * 3):
            TRAIN_label300[i,] = label300[train[i]]
        TEST_label300 = np.empty((trial // 4 * 1,))
        for i in range(0, trial // 4 * 1):
            TEST_label300[i,] = label300[test[i]]
        TRAIN_label300_class = np_utils.to_categorical(TRAIN_label300, num_classes=2)  #
        TEST_label300_class = np_utils.to_categorical(TEST_label300, num_classes=2)  #
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
        model.add(MaxPooling2D(pool_size=(6, 3), strides=(2, 2), border_mode='valid'))  # size=6.3

        # 这是添加第三层神经网络，卷积层，激励函数，池化层

        model.add(Convolution2D(32, 3, 3, border_mode='same'))
        model.add(Activation('relu'))
        model.add(MaxPooling2D(pool_size=(6, 4), strides=(2, 2), border_mode='valid'))  # size=6.4
        model.add(Flatten())
        model.add(Activation('relu'))
        model.add(Dropout(0.2))
        # 1024像素
        model.add(Dense(
            600))  # , kernel_regularizer=regularizers.l2(2), activity_regularizer=regularizers.l1(2),利用正则化来减少过拟合现象
        model.add(Dense(300))
        model.add(Dense(2))
        # 使用softmax进行分类
        model.add(Activation('softmax'))

        # Another way to define your optimize

        adam = Adam(lr=3e-7)  # alldata lr=3e-7

        model.compile(
            loss='categorical_crossentropy',  #
            optimizer=adam,
            metrics=['accuracy'])

        print('\nTraining-----------')
        H = model.fit(TRAIN, TRAIN_label300_class, nb_epoch=300,
                      batch_size=13)  # 测试的间隔次数为20,validation_split=0.2,,  validation_freq=1
        print('\nTesting------------')
        loss, accuracy = model.evaluate(TEST, TEST_label300_class)
        print('test loss: ', loss)
        print('test accuracy: ', accuracy)

        print('test before save:')  # 预测
        # model.save('E:\pycharm projects\zhuantou\zhuantou1_model.h5')
        cvscores.append(accuracy * 100)

        # plot the training loss and accuracy
    print("%.2f%% (+/- %.2f%%)" % (np.mean(cvscores), np.std(cvscores)))
    f = open('C://Users/001/Desktop/1.txt', 'a', encoding='utf-8')  ##ffilename可以是原来的txt文件，也可以没有然后把写入的自动创建成txt文件
    f.write("yyb%d :" % seed)
    f.write("%.2f%% (+/- %.2f%%)\n" % (np.mean(cvscores), np.std(cvscores)))
    f.close()
    val_not_del = ['name', 'seedi', 'gc', 'val_not_del', 'K']
    for key in list(globals().keys()):
        if (key != "key") and (key not in val_not_del):  # (not key.startswith("__")) and
            del globals()[key]
            gc.collect()
    del key
    gc.collect()
    K.clear_session()  # 方法一：如果不关闭，则会一直占用显存
