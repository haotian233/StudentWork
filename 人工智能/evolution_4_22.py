import random
import math
import numpy as np


MAX = 9999
MIN = 0


class Population:
    # 种群的设计
    def __init__(self, size, chrom_size_1, chrom_size_2, cp, mp, gen_max):
        # 种群信息合
        self.individuals = []           # 个体集合
        self.fitness = []               # 个体适应度集
        self.selector_probability = []  # 个体选择概率集合
        self.new_individuals = []       # 新一代个体集合

        self.elitist_0 = {'chromosome': [0], 'fitness': [MIN], 'age': [0]}
        self.elitist_1 = {'chromosome': [0], 'fitness': [MIN], 'age': [0]}  # 最佳个体的信息
        self.size = size  # 种群所包含的个体数
        self.chromosome_size_1 = chrom_size_1
        self.chromosome_size_2 = chrom_size_2
        self.chromosome_size = chrom_size_1+chrom_size_2  # 个体的染色体长度
        self.crossover_probability = cp    # 个体之间的交叉概率
        self.mutation_probability = mp     # 个体之间的变异概率

        self.generation_max = gen_max  # 种群进化的最大世代数
        self.age = 0                   # 种群当前所处世代

        # 随机产生初始个体集，并将新一代个体、适应度、选择概率等集合以 0 值进行初始化
        v = 2 ** self.chromosome_size - 1
        v = v >> 3
        for i in range(self.size):
            self.individuals.append([random.randint(0, v)*random.randint(1, 8)])
            self.new_individuals.append([0])
            self.fitness.append(0)
            self.selector_probability.append(0)

# 基于轮盘赌博机的选择
    def decode(self, interval, chromosome):
        '''将一个染色体 chromosome 映射为区间 interval 之内的数值'''
        d_1 = interval[0][1] - interval[0][0]
        d_2 = interval[1][1] - interval[1][0]
        n_1 = float(2 ** self.chromosome_size_1 - 1)
        n_2 = float(2 ** self.chromosome_size_2 - 1)
        return ((interval[0][0] + (chromosome[0]//(2**15))*d_1 / n_1), (interval[1][0] + (chromosome[0] % (2**15))*d_2 / n_2))

    def fitness_func(self, chrom):
        '''适应度函数，可以根据个体的两个染色体计算出该个体的适应度'''
        interval = [[-3.0, 12.1], [4.1, 5.8]]
        (x_1, x_2) = (self.decode(interval, chrom))

        def n(x_1): return x_1*math.sin(4*math.pi*x_1)
        def d(x_2): return x_2*math.sin(20*math.pi*x_2)
        # def func(x_1, x_2): 21.5+n(x_1)+d(x_2)
        # print(func(x_1, x_2))
        return 21.5+n(x_1)+d(x_2)

    def evaluate(self):
        '''用于评估种群中的个体集合 self.individuals 中各个个体的适应度'''
        sp = self.selector_probability
        for i in range(self.size):
            self.fitness[i] = self.fitness_func(self.individuals[i])   # 将计算结果保存在 self.fitness 列表中
        ft_sum = sum(self.fitness)
        for i in range(self.size):
            sp[i] = self.fitness[i] / float(ft_sum)   # 得到各个个体的生存概率
        for i in range(1, self.size):
            sp[i] = sp[i] + sp[i-1]   # 需要将个体的生存概率进行叠加，从而计算出各个个体的选择概率

    # 轮盘赌博机（选择）
    def select(self):
        (t, i) = (random.random(), 0)
        for q in self.selector_probability:
            if q > t:
                break
            i = i + 1
        return i

    # 交叉
    def cross(self, chrom1, chrom2):
        p = random.random()    # 随机概率
        n = 2 ** self.chromosome_size - 1
        if p < self.crossover_probability:
            t = random.randint(1, self.chromosome_size - 1)   # 随机选择一点（单点交叉）
            mask = n << t    # << 左移运算符
            (r1, r2) = (chrom1[0] & mask, chrom2[0] & mask)   # & 按位与运算符：参与运算的两个值,如果两个相应位都为1,则该位的结果为1,否则为0
            mask = n >> (self.chromosome_size - t)
            (l1, l2) = (chrom1[0] & mask, chrom2[0] & mask)
            (chrom1, chrom2) = (r1 + l2, r2 + l1)
        if p > self.crossover_probability:
            return (chrom1, chrom2)
        return ([chrom1], [chrom2])

    # 变异
    def mutate(self, chrom):
        p = random.random()
        if p < self.mutation_probability:
            t = random.randint(1, self.chromosome_size)
            mask1 = 1 << (t - 1)
            mask2 = chrom[0] & mask1
            if mask2 > 0:
                chrom[0] = chrom[0] & (~mask2)  # ~ 按位取反运算符：对数据的每个二进制位取反,即把1变为0,把0变为1
            else:
                chrom[0] = chrom[0] ^ mask1   # ^ 按位异或运算符：当两对应的二进位相异时，结果为1
        return chrom

    # 保留最佳个体
    def reproduct_elitist(self):
        # 与当前种群进行适应度比较，更新最佳个体
        for i in range(self.size):
            if self.elitist_0['fitness'][0] < self.fitness[i]:
                self.elitist_1 = self.elitist_0
                self.elitist_0['fitness'] = [self.fitness[i]]
                self.elitist_0['chromosome'] = [self.individuals[i]]
                self.elitist_0['age'][0] = self.age
                continue
            if self.elitist_1['fitness'][0] < self.fitness[i]:
                self.elitist_1['fitness'] = [self.fitness[i]]
                self.elitist_1['chromosome'] = [self.individuals[i]]
                self.elitist_1['age'][0] = self.age
                continue

    # 进化过程
    def evolve(self):
        indvs = self.individuals
        new_indvs = self.new_individuals
        # 计算适应度及选择概率
        self.evaluate()
        # 进化操作
        i = 0
        while True:
            # 选择两个个体，进行交叉与变异，产生新的种群
            idv1 = self.select()
            idv2 = self.select()
            # 交叉
            # print(self.elitist_0['chromosome'][0])
            (new_idv1, new_idv2) = self.cross(indvs[idv1], indvs[idv2])
            # 变异
            (new_idv1, new_idv2) = (self.mutate(new_idv1), self.mutate(new_idv2))
            (new_indvs[i]) = new_idv1  # 将计算结果保存于新的个体集合self.new_individuals中
            (new_indvs[i+1]) = new_idv2
            # 判断进化过程是否结束
            i = i + 2         # 循环self.size/2次，每次从self.individuals 中选出2个
            if i >= self.size:
                break
        # 最佳个体保留
        # 如果在选择之前保留当前最佳个体，最终能收敛到全局最优解。
        self.reproduct_elitist()
        # print(self.elitist_0['chromosome'][0], self.elitist_0['fitness'][0], self.elitist_1['chromosome'][0], self.elitist_1['fitness'][0])
        # print(self.new_individuals)
        # 更新换代：用种群进化生成的新个体集合 self.new_individuals 替换当前个体集合
        n = random.randint(0, self.size-1)
        m = random.randint(0, self.size-1)
        a = self.elitist_0['chromosome'][0][0]
        b = self.elitist_1['chromosome'][0][0]
        self.new_individuals[m] = [a]
        self.new_individuals[n] = [b]
        for i in range(self.size):
            self.individuals[i] = self.new_individuals[i]

    def run(self):
        '''根据种群最大进化世代数设定了一个循环。
        在循环过程中，调用 evolve 函数进行种群进化计算，并输出种群的每一代的个体适应度最大值、平均值和最小值。'''
        interval = [[-3.0, 12.1], [4.1, 5.8]]
        for i in range(self.generation_max):
            self.evolve()
            print(i, max(self.fitness), sum(self.fitness)/self.size, min(self.fitness), self.elitist_0['fitness'], self.elitist_0['chromosome'][0])
        print(self.decode(interval, self.elitist_0['chromosome'][0]))
        print(self.fitness_func(self.elitist_0['chromosome'][0]))


if __name__ == '__main__':
    # 种群的个体数量为 10，染色体长度为 18+15，交叉概率为 0.6，变异概率为 0.01,进化最大世代数为 1000
    pop = Population(30, 18, 15, 0.6, 0.1, 3000)
    pop.run()
    # x_1 = 7.085099354169289
    # x_2 = 4.502703939939573
    # print(21.5+x_1*math.sin(4*math.pi*x_1)+x_2*math.sin(20*math.pi*x_2))
