from math import sqrt
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc  # 한글 처리
import recommend,sql
from flask import Flask


font_name = font_manager.FontProperties(fname="c:/Windows/Fonts/malgun.ttf").get_name()
rc('font', family=font_name)

member = {}
lst = []
member,lst = sql.getMember("태윤")


def sim_distance(data, name1, name2):
    sum = 0
    for i in data[name1]:
        if i in data[name2]:
            sum += pow(data[name1][i] - data[name2][i], 2)
    return 1 / (1 + sqrt(sum))


def top_match(data, name, index=3, sim_function=sim_distance):
    li = []
    for i in data:
        if name != i:
            li.append((sim_function(data, name, i), i))
    li.sort()
    li.reverse()

    return li[:index]


# 나중에 자바에서 현재 사용자값을 넘겨줘야할듯
li = top_match(member, "태윤")

score = []
names = []

for i in li:
    score.append(i[0])
    names.append(i[1])

print(li)


def barchart(data, labels):  # data, labels 는 list 형태로 사용
    positions = range(len(data))
    plt.barh(positions, data, height=0.5, color='r')  # 가로
    plt.yticks(positions, labels)
    plt.xlabel('similarity')
    plt.ylabel('name')
    plt.show()


def drawGraph(data, name1, name2):
    plt.figure(figsize=(14, 8))  # plot 크기 설정
    # plot 좌표를 위한 list 선언
    li = []
    li2 = []

    for i in member[name1]:  # i = 키값
        if i in data[name2]:  # 같은 영화를 평가 했을 때만
            print(i)
            li.append(member[name1][i])  # name1의 평점 li[]에 추가
            li2.append(member[name2][i])  # name2의 평점 li2[]에 추가
            plt.text(member[name1][i], member[name2][i], i)  # 영화 제목 text 찍기
    plt.plot(li, li2, 'ro')  # plot 그리기

    # 각 축의 크기 설정 0에서 6까지
    plt.axis([0, 6, 0, 6])

    # x축과 y축 이름 설정
    plt.xlabel(name1)
    plt.ylabel(name2)

    # 그리기
    plt.show()


# drawGraph(member, '태윤', 'test1')

# 피어슨 상관계수 구하기
def sim_pearson(data, name1, name2):
    sumX = 0  # X의 합
    sumY = 0  # Y의 합
    sumPowX = 0  # X 제곱의 합
    sumPowY = 0  # Y 제곱의 합
    sumXY = 0  # X*Y의 합
    count = 0  # 영화 개수

    for i in data[name1]:  # i=key
        if i in data[name2]:
            sumX += data[name1][i]
            sumY += data[name2][i]
            sumPowX += pow(data[name1][i], 2)
            sumPowY += pow(data[name2][i], 2)
            sumXY += data[name1][i] * data[name2][i]
            count += 1
    return (sumXY - ((sumX * sumY) / count)) / sqrt(
        (sumPowX - (pow(sumX, 2) / count)) * (sumPowY - (pow(sumY, 2) / count)))


# print(top_match(member,'태윤',3))

def getRecommendation(data, person, sim_function=sim_pearson):
    result = top_match(member, person, len(data))

    simSum = 0  # 유사도 합을 위한 변수
    score = 0  # 평점 합을 위한 변수
    li = []  # 리턴을 위한 리스트
    score_dic = {}  # 유사도 총합을 위한 dic
    sim_dic = {}  # 평점 총합을 위한 dic

    for sim, name in result:  # 튜플이므로 한번에
        if sim < 0: continue  # 유사도가 양수인 사람만
        for movie in data[name]:
            if movie not in data[person]:  # name이 평가를 내리지 않은 영화
                score += sim * data[name][movie]  # 그사람의 영화평점 * 유사도
                score_dic.setdefault(movie, 0)  # 기본값 설정
                score_dic[movie] += score  # 합계 구함

                # 조건에 맞는 사람의 유사도의 누적합을 구한다
                sim_dic.setdefault(movie, 0)
                sim_dic[movie] += sim

            score = 0  # 영화가 바뀌었으니 초기화한다

    for key in score_dic:
        score_dic[key] = score_dic[key] / sim_dic[key]  # 평점 총합/ 유사도 총합
        li.append((score_dic[key], key))  # list((tuple))의 리턴을 위해서.
    li.sort()  # 오름차순
    li.reverse()  # 내림차순
    return li


# for i in lst:
#     print(getRecommendation(member, i))
# print(getRecommendation(member,"태윤"))







