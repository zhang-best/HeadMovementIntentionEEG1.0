import numpy as np
import matplotlib.pyplot as plt
import pywt
import h5py
import time
path = r'E:\science research\转动意图识别\laboratory_data&result\data\转头21_mat\lhy\lhydata300_50s.mat'
data = h5py.File(path)
y19 = data['signal300'][:]
t = np.linspace(0, 0.3, 300, endpoint=False)
f = np.arange(1, 43)
fc = pywt.central_frequency('db4', precision=8)

scale = 1000*fc/f
a = y19.shape[2]
b = y19.shape[1]
c = y19.shape[0]
TIME = 0
for i in range(0, c):
    for j in range(0, 3):
        start = time.clock()
        y = y19[i, :, j]
        cwtmatr1, freqs1 = pywt.cwt(y, scale, 'cgau8', 0.001)
        end = time.clock()
        TIME = end - start +TIME
    u
plt.figure(figsize=(12, 9))

