import numpy as np
import time
from keras.models import load_model
import h5py  # v7.3格式
import gc
I = 0
name = ['fww', 'lc', 'lhy', 'lyb', 'wy', 'wyh', 'xy', 'yyb', 'zc', 'zxj', 'zy', 'zzh']#
for namei in name:
    I = I+1
    path = r'E:/science research/转动意图识别/laboratory_data&result/data/转头21_mat/' + namei + '/' + namei + 'wave300_50s.mat'
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
            label300[j,] = int(label300_temp[i, j])  # 转换维度
    del data, coefs_channel_trial_temp, coefs_channel_trial, label300_temp
    gc.collect()
    during = np.zeros((trial,))
    h = np.zeros((1, num_f, timeline, channel))
    p = r'E:/pycharm projects/zhuantou3-3class/model/rw wave/rwmodel' + namei + '.h5'
    model = load_model(p)
    for i in range(0, trial):
        start = time.clock()
        h[0, :, :, :] = coefs[i, :, :, :]
        pred = model.predict(h)
        pred = np.round(pred)
        end = time.clock()
        during[i,] = end-start
    print("%s:"%(I))
    print(during)
    print("%.8fs (+/- %.8fs)" % (np.mean(during[1:trial]), np.std(during[1:trial])))

