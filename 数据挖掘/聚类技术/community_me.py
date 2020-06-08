import numpy as np
import random
import igraph as ig
import pandas as pd
import matplotlib.pyplot as plt

# ----------------读入数据并生成边表和邻接矩阵-----------------------#
data_source = 'C:\\Users\\67575\\Desktop\\HomeWork\\datamining\\聚类技术---复杂网络社团检测代码\\data\\'
graph = ig.Graph.Read_GML(data_source+'karate.gml')     # 读取karate文件中的数据
M = graph.vcount()    # m=34
N = graph.ecount()    # m=78
edgelist = graph.get_edgelist()       # 边的list
neighbors = graph.neighborhood()      # 与各个点相连的其他点的集合
k = graph.degree()
# print(edgelist, '\n', neighbors, k)
Q_list = []

# -----------------------------数据输出函数----------------------------#


# ---------------由导入的边和邻节点数据构建邻接矩阵-----------------------#
def compute_A(m):
    A = np.zeros((m, m), dtype=np.int)
    for i in range(m):
        for j in range(m):
            if i is j:
                break
            # 由邻节点构建邻接矩阵
            if j in neighbors[i]:
                A[i][j] = 1
                A[j][i] = 1
    # print('A矩阵为：\n', A)
    return A


# --------------------相似度计算函数---------------------------------#
def similarity(m):
    similar = np.zeros((m, m), dtype=np.float)  # 构建相似度矩阵
    for i in range(m):
        for j in range(m):
            p = []      # 并集矩阵
            q = []      # 交集矩阵
            for k in range(m):
                if(i in neighbors[k] and j in neighbors[k]):    # 求交操作
                    p.append(k)
                if(i in neighbors[k] or j in neighbors[k]):     # 求并操作
                    q.append(k)
            l1 = len(p)
            l2 = len(q)
            similar[i][j] = l1/l2
            similar[j][i] = l1/l2
    for k in range(m):
        similar[k][k] = 0  # 将对角线上的值置为0
    # print('similar矩阵:\n', similar)
    return similar


# -------------------------模块化度量值----------------------------------#
def init_compute_clusters(clusters, m):  # 初始化clusters列表，将clusters的每一位置为-1，表示未分类
    for i in range(m):
        clusters.append(-1)
    return clusters


# 模块度Q计量
def compute_Q(f, adjacency):
    Q = 0
    for i in range(M):
        for j in range(M):
            if f[i] == f[j]:
                Q += (adjacency[i][j]-(k[i]*k[j]/(2*N)))/(2*N)
            else:
                Q += 0
    Q_list.append(Q)
    return Q


# ----------------------层次聚类函数--------------------------------------# 
def cluster(sim):
    m = len(sim)
    max_s = 0
    x = 0
    y = 0
    # 选出最大相似度
    for i in range(m):
        for j in range(m):
            if(sim[i][j] > max_s):
                x = i
                y = j
                max_s = sim[i][j]
    # 全链算法更新相似度矩阵
    for i in range(m):
        sim[x][i] = min(sim[x][i], sim[y][i])
        sim[y][i] = min(sim[x][i], sim[y][i])
    return x, y


# ------------------------------输出结果函数-------------------------#
def outputData(clusters,  edges):   # 输出无向图的连接关系，输出分类结果
    edge_out = []
    graph_file = data_source+'grafh.csv'
    name1 = ['nodea',  'edgetype',  'nodeb']
    for edge in edges:
        edge_out.append((edge[0]+1, 1, edge[1]+1))
    out1 = pd.DataFrame(columns=name1, data=edge_out)
    out1.to_csv(graph_file)

    attribute_file = data_source+'class.csv'
    name2 = ['node',  'class']
    attribute_out = []
    for i in range(1, M+1):
        attribute_out.append((i, clusters[i-1]))
    out2 = pd.DataFrame(columns=name2,  data=attribute_out)
    out2.to_csv(attribute_file)


# ---------------------画图函数------------------------------------#
def draw():
    plt.figure(1)
    plt.plot(range(len(Q_list)),  Q_list,  color="b",  linewidth=2)
    plt.xlabel('merge times')
    plt.ylabel("Q")
    plt.scatter(range(len(Q_list)), Q_list, linewidths=3, s=3, c='b')
    f1 = plt.gcf()
    plt.show()


# -------------------------主函数-----------------------------------#
A = compute_A(M)
similar = similarity(M)
clusters = []
cluster_complete = []
clusters = init_compute_clusters(clusters, M)
i = 0
flag = 0
Q = 0
q_max = -1
while(i < 100):
    x, y = cluster(similar)
    if clusters[x] != -1 and clusters[y] != -1:   # x,y都已经分类，则将x, y的聚类合并成为一个，这里采用合并树的思想，将相同簇的节点遍历并进行修改
        temp = clusters[y]
        for j in range(M):
            if clusters[j] == temp:
                clusters[j] = clusters[x]
    if clusters[x] == -1 or clusters[y] == -1:      # 两个簇中至少有一个未分类
        if clusters[x] == -1 and clusters[y] == -1:     # 两个簇都未分类
            flag += 1                                   # 新建一个分类保存此簇
            clusters[x] = clusters[y] = flag
        elif clusters[x] == -1:                 # x未分类y已分类，将x并到y上去
            clusters[x] = clusters[y]
        elif clusters[y] == -1:                 # x已分类y未分类，将y并到x上去
            clusters[y] = clusters[x]
    Q = compute_Q(clusters, A)
    if(Q > q_max):
        outputData(clusters, edgelist)
        q_max = Q
        # print(clusters)
    i += 1
print(clusters)
draw()
# print(k)
# print('A:', A)
# print(Q)
