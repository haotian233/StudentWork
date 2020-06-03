#  -*- coding: utf-8 -*-

# 分类技术---二分网络上的链路预测
# 1、导入数据
import pandas as pd
import numpy as np
import scipy.sparse as sparse
import matplotlib.pyplot as plt
filename = "\\data\\ratings.dat"  # rating文件路径
all_ratings = pd.read_csv(filename, header=None, sep="::", names=["UserID",  "MovieID",  "Rating",  "Datetime"], engine="python")
# 2、对数据进行预处理
all_ratings["Favorable"] = all_ratings["Rating"] > 3.0
# 3、通过随机数将数据分为训练集与测试集
randum = np.random.rand(len(all_ratings), 1)
for i in range(len(randum)):
    randum[i] = int(randum[i]*10)
all_ratings["class"] = randum
# 4、导入函数、数据，预处理数据。
all_ratings.to_csv('classified_ratings.csv')
MovieID_set = set(all_ratings["MovieID"])
MovieID_tuple = tuple(MovieID_set)
UserID_set = set(all_ratings["UserID"])
UserID_tuple = tuple(UserID_set)
M = len(UserID_set)             # 用户数量
N = len(MovieID_set)            # 电影数量
values = range(N)
MovieID_dict = dict(zip(MovieID_tuple,  values))    # 把MovieID从小到大逐一映射
all_ratings = pd.read_csv('\\data\\classified_ratings.csv',
                          usecols=[1, 2, 5, 6])
# 5、将设计方案中的第5、6、7步放在一个循环体中求出


def computeF():
    # 已知矩阵的维数，提前初始化一个M*N的矩阵F总体上利用两层 for 循环，
    # 一层用来找对应的用户编号，另一 层用来找对应的电影编号，
    # 如果都找到对应的编号则把 a[i][j]置为 1
    # 即在二部图中构建了一条从用户 i 到电影 j 的连边
    F = []
    for x in range(M):
        index = UserID_tuple[x]     # index = Uid
        reviews_set = set(reviews_by_users[index])   # 用户看过的所有电影mid集合
        reviews_set_modified = set()                # 电影编号的集合
        for t in reviews_set:
            reviews_set_modified.add(MovieID_dict[t])   # 用户看过的电影对应的索引集合
        for y in range(N):
            if y in reviews_set_modified:
                F.append(1)
            else:
                F.append(0)

    F = np.array(F).reshape((M, N)).transpose()

    return F


def recommend(r):
    global sort_result
    global M
    global N

    rate = r
    dic = dict()
    for i in range(M):
        index = UserID_tuple[i]     # index=uid
        reco = []
        stop = int(rate * (N - len(reviews_by_users[index])))   # ; print stop
        movie_index = sort_result[:stop, i]
        for j in movie_index:
            reco.append(MovieID_tuple[j])
        recommend_set = set(reco)
        dic[index] = recommend_set

    return dic


def calculate_r():
    global sort_result
    global test_by_users
    global M
    global N
    print("enter")
    sum = 0.0

    for i in range(M):
        index = UserID_tuple[i]     # uid
        if ((index in favor_in_test_by_users) == False):        # 这里的 == 不能改成 is ,下面的也一样，pandas的问题会报错
            # print "uid %d " % index
            continue
        mv_set = favor_in_test_by_users[index]
        slic_dict = dict(zip(sort_result[:, i],  range(N)))
        for m in mv_set:
            mindex = MovieID_dict[m]
            sum += slic_dict[mindex]+1
        sum = float(sum) / (N - len(reviews_by_users[index]))
#         print "sum=%f,  count=%d" % (sum,  i)
    return sum


for iteration in range(1):
    print("第%d轮迭代" % iteration)
    # 选取训练集、测试集记录
    train_ratings = all_ratings[all_ratings["class"] != iteration]
    test_ratings = all_ratings[all_ratings["class"] == iteration]
    # 只选择那些用户评分为喜欢的记录
    favor_ratings = train_ratings[train_ratings["Favorable"] == True]
    favor_ratings_in_test = test_ratings[test_ratings["Favorable"] == True]
    favor_reviews_by_users = dict((k,  frozenset(v.values)) for k,  v in favor_ratings.groupby("UserID")["MovieID"])
    reviews_by_users = dict((k,  frozenset(v.values)) for k, v in train_ratings.groupby("UserID")["MovieID"])
    movie_reviewed = dict((k,  frozenset(v.values)) for k,  v in train_ratings.groupby("MovieID")["UserID"])
    movie_favor_reviewed = dict((k,  frozenset(v.values)) for k,  v in favor_ratings.groupby("MovieID")["UserID"])
    test_by_users = dict((k,  frozenset(v.values)) for k,  v in test_ratings.groupby("UserID")["MovieID"])
    favor_in_test_by_users = dict((k,  frozenset(v.values)) for k, v in favor_ratings_in_test.groupby("UserID")["MovieID"])
    row = []
    col = []
    data = []
    keys_list = favor_reviews_by_users.keys()
# 计算W矩阵
    for l in range(M):      # print "enter outer iteration %d" % l
        index = UserID_tuple[l]
        # print l
        if index in keys_list:
            #  movie_favored，临时tuple变量，用来存储用户所喜欢的电影,  leng 存储用户喜欢电影的个数
            movie_favored = tuple(favor_reviews_by_users[index])
            leng = len(movie_favored)    # 训练集中用户index=UserID_tuple评分大于3的电影
            # ; print "movie_favored number:%d" %leng
            kl = len(reviews_by_users[index])      #该用户总评价的电影数量
            for x in range(leng):
                #  x位置的电影ID，j 为该电影在对照表中的位置
                mid = movie_favored[x]
                j = MovieID_dict[mid]
                kj = len(movie_reviewed[mid])   # 训练集中电影j被评价的总次数
                for y in np.arange(x+1,  leng):
                    i = MovieID_dict[movie_favored[y]]  # y位置对应电影的ID，去检索，得到该ID对应的索引
                    ki = len(movie_reviewed[movie_favored[y]])  

                    row.append(i)
                    col.append(j)
                    data.append(1.0/kl/kj)
                    # 行列反转，顺势计算对称位置上的W[i][j]
                    row.append(j)
                    col.append(i)
                    data.append(1.0/kl/ki)

    row = np.array(row)
    col = np.array(col)
    data = np.array(data)
    W = sparse.coo_matrix((data,  (row, col)),  shape=(N, N),  dtype=float)     # 使用稀疏矩阵对W进行存储
    print("W矩阵:\n", W)
    #  计算F矩阵, shape=(N，M),  存放用户看过那些电影
    F = computeF()
    print("F:\n", F)

    F2 = W.dot(F)
    print("F2矩阵为:\n", F2)

#  修正F2矩阵，归零那些用户已经看过的电影
    for i in range(M):
        slic = F[:,  i]
        for j in range(N):
            if slic[j] == 1:
                F2[j][i] = 0
    print("F2 have modified")
    print(F2)
#  对F2矩阵排序, 返回从大到小的下标数组
    sort_result = np.argsort(-F2,  axis=0)
    print('the result of sort:', sort_result)
# F2每列中的元素从小到大排序(加负号实现倒序排序)，提取对应的Index，即推荐的电影序号
#  计算r
    R = []
    r = calculate_r()
    R.append(r)
    print("r: %f" % r)
#  绘制ROC曲线所需相关参数
#  计算TP、FP
    TPR = []
    FPR = []
    area = []
    TP = 0      # 在推荐集中，实际也给了好评
    FN = 0      # 不在推荐集中，实际却给了好评
    FP = 0      # 在推荐集中，实际给了差评
    TN = 0      # 不在推荐集中，实际给了差评

    #  为每个用户选取推荐一定比例的电影的电影
    recommend_rate = np.linspace(0.001, 0.5, 50)    #设置阈值在1-0.5之间的50个值
    for rate in recommend_rate:
        recommend_dict = recommend(rate)

        for uid,  reviews in test_by_users.items():
            recommend_movies = recommend_dict[uid]
            if ((uid in favor_in_test_by_users) == False):
                # print "uid = %d" % uid
                for m in reviews:
                    if m in recommend_movies:
                        FP += 1
                    else:
                        TN += 1
                continue
            for m in reviews:
                if m in recommend_movies and m in favor_in_test_by_users[uid]:
                    TP = TP + 1
                elif m in recommend_movies and m not in favor_in_test_by_users[uid]:
                    FP = FP + 1
                elif m not in recommend_movies and m in favor_in_test_by_users[uid]:
                    FN = FN + 1
                else:
                    TN = TN + 1

        TPR.append(float(TP)/(TP+FN))
        FPR.append(float(FP)/(FP+TN))
        area.append(float(TP)/(TP+FN) * (1-float(FP)/(FP+TN)))

    best_index = int(np.argmax(np.array(area)))
    # print recommend_rate[best_index]
#  画图
    plt.figure(1)
    plt.plot(FPR,  TPR,  'bx',  linewidth=20)
    plt.plot(np.linspace(0, 1, 200),  np.linspace(0, 1, 200),  'r--', )
    plt.xlabel('FPR rate')
    plt.ylabel("TPR rate")
    plt.scatter(FPR, TPR, linewidths=3, s=3, c='b')
    plt.legend(("points with changing recommend rate", "reference curve"))
    title = "ROC Curve"
    plt.title(title)
    f1 = plt.gcf()
    plt.show()
