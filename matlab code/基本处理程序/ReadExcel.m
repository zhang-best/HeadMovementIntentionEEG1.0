% clear;
% for i = 1:1:12
%     h = 7*i;
%     sd = strcat('A',mat2str(h));
%     st = strcat('B',mat2str(h));
%     sp = strcat(sd,':',st);
%     [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','lr wave',sp);
%     W(i,1) = TXT;
% end
% for i=1:length(W)
%     label_01{i} = W{i}(1 : regexp(W{i}, '%') - 1);
%     a = label_01{i};
%     gf(1,i) = str2num(a);
% end
clear;
for i = 1:1:12
    h = 7*i-1;
    sd = strcat('A',mat2str(h));
    st = strcat('B',mat2str(h));
    sp = strcat(sd,':',st);
    [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','rw wave',sp);
    W(i,1) = TXT;
end

for i = 1:1:12
    rwwavezql(i,:) = str2num(W{i});
end
rwwavezql = rwwavezql';

% for i = 1:1:12
%     h = 7*i-4;
%     sd = strcat('A',mat2str(h));
%     st = strcat('B',mat2str(h));
%     sp = strcat(sd,':',st);
%     [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','rw wavefuzzy',sp);
%     W(i,1) = TXT;
% end
% for i = 1:1:12
%     rwwavefuzzyzql(i,:) = str2num(W{i});
% end
% rwwavefuzzyzql = rwwavefuzzyzql';

for i = 1:1:12
    h = 7*i-1;
    sd = strcat('A',mat2str(h));
    st = strcat('B',mat2str(h));
    sp = strcat(sd,':',st);
    [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','lr wave',sp);
    W(i,1) = TXT;
end

for i = 1:1:12
    lrwavezql(i,:) = str2num(W{i});
end
lrwavezql = lrwavezql';

% for i = 1:1:12
%     h = 7*i-4;
%     sd = strcat('A',mat2str(h));
%     st = strcat('B',mat2str(h));
%     sp = strcat(sd,':',st);
%     [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','lr wavefuzzy',sp);
%     W(i,1) = TXT;
% end
% 
% for i = 1:1:12
%     lrwavefuzzyzql(i,:) = str2num(W{i});
% end
% lrwavefuzzyzql = lrwavefuzzyzql';
% 
% 
% 
% 
% 
% 
% 
% for i = 1:1:12
%     h = 7*i-4;
%     sd = strcat('A',mat2str(h));
%     st = strcat('B',mat2str(h));
%     sp = strcat(sd,':',st);
%     [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','rw wave3',sp);
%     W(i,1) = TXT;
% end
% 
% for i = 1:1:12
%     rwwave3zql(i,:) = str2num(W{i});
% end
% rwwave3zql = rwwave3zql';
% 
% for i = 1:1:12
%     h = 7*i-4;
%     sd = strcat('A',mat2str(h));
%     st = strcat('B',mat2str(h));
%     sp = strcat(sd,':',st);
%     [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','lr wave3',sp);
%     W(i,1) = TXT;
% end
% 
% for i = 1:1:12
%     lrwave3zql(i,:) = str2num(W{i});
% end
% lrwave3zql = lrwave3zql';
% 
% for i = 1:1:12
%     h = 7*i-4;
%     sd = strcat('A',mat2str(h));
%     st = strcat('B',mat2str(h));
%     sp = strcat(sd,':',st);
%     [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','lr wavefuzzy3',sp);
%     W(i,1) = TXT;
% end
% 
% for i = 1:1:12
%     lrwavefuzzy3zql(i,:) = str2num(W{i});
% end
% lrwavefuzzy3zql = lrwavefuzzy3zql';
% for i = 1:1:12
%     h = 7*i-4;
%     sd = strcat('A',mat2str(h));
%     st = strcat('B',mat2str(h));
%     sp = strcat(sd,':',st);
%     [NUM,TXT,RAW] = xlsread('C:\Users\001\Desktop\转头意图识别论文1\图片\总表.xlsx','rw wavefuzzy3',sp);
%     W(i,1) = TXT;
% end
% for i = 1:1:12
%     rwwavefuzzy3zql(i,:) = str2num(W{i});
% end
% rwwavefuzzy3zql = rwwavefuzzy3zql';

% figure % 打开新的绘画窗口，可省略该句
% plot(k,valloss); %采用默认样式，绘制实线
% hold on;
% figure % 打开新的绘画窗口，可省略该句
% plot(k,vallosswave); %采用默认样式，绘制实线
