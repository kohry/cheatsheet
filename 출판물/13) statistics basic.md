# 실제 변수들이 독립변수인지 확인 (다중공선성)


# 실제 변수들이 정규분포를 따르는지 확인

실제, shapiro.test는 R기본내장으로 p-value가 0.05이하이면 대충 정규분포를 따른다고 보면 됨.
shapiro.test(data)

히스토그램으로 확인
```
hist(cars$speed)
```

# 시계열 데이터가 랜덤성을 따르는지 확인

nortest 패키지안에 있음.
tseries에 runs.test는 연속된 데이터의 랜덤성을 체크함.

```
library(tseries)
s <- sample(c(0,1), 100, replace = T)
runs.test(as.factor(s))
```

# 두 모집단 평균 비교

```
t.test()
```

기본적인 대립가설은 평균이 같지않다는것이고, p-value가 유의미하다면 (<0.05) 평균은 같지 않다고 보면된다. 이 외의 경우에는 평균은 같다고 보면 된다.

# 상관관계 비교

```
cor.test(x,y)
```
로 계산한다. p-value가 작다는것은 상관계수의 유의성이 높다는것. 상관관계가 0.9가 나오고 p-value가 낮다는건 상관이 있다는 뜻.

정규붐포는 pearson방법, 미보수적인 방법은 spearman

# 동일한 분포에서 왔는지 확인

ks.test(x,y)

lm시 절편을 0으로 만들고 싶으면 lm(y ~ x + 0)으로 판단.

이진값으로 된 변수 예측 (로지스틱 회귀)
m <- glm(gender ~ c_eye_left_size + c_eye_right_size + c_eye_left_width, family = binomial)

# Kappa 통계

우연히 정확한 예측을 할 확률을 계산. 

# 민감도 (Sensitivity)

관심범주 (긍정으로 분류했어야 하는놈) 중 제대로 분류 (긍정)

# 특이도 (Specificity)

관심범주가 아닌놈들 (부정으로 분류했어야 하는놈) 중 부정으로 제대로 분류한 비율

# 정밀도 (precision)

긍정으로 분류된 것들중 진짜 긍정인놈들

# 재현율 (recall)

민감도와 같음

# ROC 커브 (Receiver Operating Characteristics)

```
library(ROCR)
data(ROCR.simple)

pred <- prediction(ROCR.simple$predictions,ROCR.simple$labels)

```



# 다중공선성 (multicollinearity)

설명변수간 서로 상관관계가 있어서 제대로설명하는지 판단.


```
perf <- performance(pred, measure = "tpr", x.measure="fpr")
perf
plot(perf)
abline(a = 0, b = 1)
perf.auc <- performance(pred, measure = "auc")
perf.auc
unlist(perf.auc@y.values)
```



# 배깅

bootstrap aggregating. 여러개의 부트스트랩 자료를 생성하고 각 모델링을 하여, (단순 복원 임의추출) 여러개의 표본자료.
연속형일때는 평균, 범주형일때는 다중투표를 통함.
즉 단순선형회귀도 표본을 계속 추출하여 강한 거시기를 만들어낼수 있음.

# 부스팅

잘못 분류되는 애들에 집중하여 다시 강한 예측모형을 만들게 됨. (약한 러너를 강화하고 결합시킴.)

# 랜덤포레스트


# rcurl
인터넷에 있는 문서를 읽어오는데 쓸수있음
```
install.packages("RCurl")
library(RCurl)
webpage <- getURL("http://naver.com")
```


# rjson
```
library(rjson)
r_object <- fromJSON(json_string)
json_string <- toJSON(r_object)
```


# join
join은 merge()함수로 끝내버린다.
merge(aa,bb, by = "V1") 이렇게 하면, 원하는 결과, 즉 아이디를 기준으로 통합되며 열이 옆으로 붙음. 

# 평균차이검정

t검정

t.test(breads$weigth, mu = 400)
mu는 모집단 평균임

# 독립성 검정
chisq.test
편중이 발생할 확률이 p-value 이며, 유의수준 이하로 떨어지면 편중이 발생한다. 데이터가 서로 영향이 있는지 확인. 0.05 이하면 대립가설채택, 독립적이다.

분할표에 5미만의 빈도가 있는 경우는 카이제곱 검정 사용이 효과적이지 않을 수 있다.

# 결정 계수
직선상에 데이터가 놓여있는 정도

# p-value
선형회귀에서 p-value는 계수가 0인데(파라미터가 0인데) 영향을 미칠 확률

# 차원감소방법
- feature selection : 몇가지 데이터들만 뽑아서 쓰겠다는 뜻
- feature extraction : d차원 벡터를 입력으로 하고 m차원 벡터를 출력하는 함수를 만들어냄


# 1시그마, 2시그마, 3시그마
68%, 95%, 99.7%

# 오즈비
계수를 exp해서 보면 odds ratio 산출간으.
model$coefficients %>% exp %>% round(2)


# MASS 패키지
Modern Applied Statistics with S

# logistics regression
MASS패키지에 여러 데이터 라이브러리들이 저장이 되어있음.
```
model <- glm(low ~ age + lwt + race + smoke + ptl + ht + ui + ftv, family = binomial, data = birthwt)
summary(model)
```

# factor설정
df$f <- factor(df$f, levels=c('a','b','c'),
  labels=c('Treatment A: XYZ','Treatment B: YZX','Treatment C: ZYX'))

# 달력
```
install.packages("openair")
library(openair)
caldendarPlot(어쩌고)
```

# subset
subset(gr, items %in% "berrys") 
berry에 관련된 것들 찾음
subset(gr, items %ain% c("berrys","apple"))
다 관련된것들을 찾음 %ain%
부분만 관련된 것들을 찾음 %pin%

# 표본추출
- 단순랜덤 추출법 (simple random sampling) : 그냥 추출하기
- 계통추출 (systematic sampling) : 랜덤샘플링과 그다지 다를것이 없는데, n개씩 띄엄띄엄 추출하기
- 집락추출 (cluster random sampling) : 여러 cluster가 존재하고 몇개의 cluster를 특별하게 골라 거기 안에서 다 처리함
- 층화추출 (stratified random sampling) : 많이쓰는 방법으로, 남녀가 나뉘어져 있는 샘플인 경우 train / test데이터를 성별을 맞춰주기 위해 씀

# 분포
이산형
- 이항분포
- 베르누이 확률분포
- 기하분포
- 다항분포
- 포아송분포

연속형
- 균일분포
- 정규분포
- 지수분포
- t-분포
- 카이제곱분포
- F-분포

# 더 알아야 할것들

<<<<여기는 모두 공식들과 문제들을 넣어주어야 함>>>>

# 이산형과 연속형
이산형은 정수로 딱딱 떨어지는것. 연속형은 셀수없고 키와같은거.

# t분포
표본을 많이 뽑지 못한다면 이에 대한 대응책으로 예측범위가 넓은 분포를 사용하게 됨.
따라서 직접 확률구할때 사용하는것이 아니라, 신뢰구간이나 가설검정을 할때 사용함. 예측범위가 넓은 t분포를 땜빵으로 사용.

t분포표는 자유도와 확률을 나타내는데, 자유도는 표본 - 1로써 표본들이 얼마나 마음대로 의지를 가지고 움직일수 있는지에 대한 지표이다. 자유도는 30까지는 잘 적혀있으나, 그 이후에는 띄엄띄엄 존재하는데 왜냐면 표본이 30개 이상이면 정규분포표로 놀면되기 때문이다.

t검증은 두 집단간의 평균치를 비교하는 것.

# 카이제곱분포
데이터나 집단의 분산을 추정하고 검정할때 사용. 신뢰구간, 가설검정, 적합도 검정, 동질성 검정, 독립성 검정등에 사용하는 분포. 이건 유투브를 참조하면 너무 깔끔하게 이해됨.

# F분포
분산을 추정하고 검정할때 사용. 카이제곱분포는 한집단의 분산파악때 유리, F분포는 두집단의 분산을 비교할때 사용. 즉 카이제곱분포의 업그레이드판이라고 보면 됨. 3개이상은 ANOVA. Ronald Fisher 의 이름을 따서 F분포. 집단간 분산과 집단내 분산을 분자, 분모로 두어 1보다 큰 값의 크기를 측정함.

# 베르누이 분포
베르누이는 합격 / 불합격, 앞면 / 뒷면 두가지만 나오는 경우임. 이름이 졸라 있어보이는데 그냥 두개중에 하나임.

# 이항분포
둘중에 하나인점은 베르누이와 같은데, 베르누이는 한방으로 끝나는데 비해 이항은 여러번 시도한다.

# 다항분포
이항분포는 둘중에 하나지만, 다항분포는 여러 상황이 나올 수 있다.

# 초기하분포
이항분포와 마찬가지지만, 비복원추출로 매 실험조건이 달라질 경우. 즉 한번의 실험이 이전 실험에서 독립적이지 않을때.

# 기하분포
계속실패하다가 언젠가 성공할 확률에 대해 구한다.

# 음이항분포
기하분포와 같으나, x번째 시험에서 k번째 성공할 확률을 구할 때 사용. 따라서 성공횟수 k에 대한 추가 정보가 필요.

# 포아송분포
일정한 시간과 공간내에 발생하는 사건의 발생횟수. 발생에만 초점을 두기 때문에, 실패는 상관이 없으며 포아송분포는 사건의 발생횟수와 평균만 알면 확률값 계산 가능. 매시간 접수되는 전화요청 건수 등.

# 지수분포
시간에 따라 확률이 작아지는 경우

# 그밖에
모수의 표준편차를 모를때는 표본의 표준편차를 이용하여 신뢰구간을 정하는데, 표본의 정규분포가 30이상이면 정규분포를 이용하지만, 30개 미만이면 t분포를 이용한다.

# 쌍체비교 (Paired test)
한 표본안에 시간에 따라 전후를 비교하고싶을때

# 결정계수
1이면 점들이 회귀식에 가깝고, 0이면 점들이 회귀식에 가깝지않음.

# ANOVA
Analysis of Variance. 단순 T검증을 쓸수도 있지만, 여러개를 비교할때는 귀찮게 계속해서 두개씩 비교해야함. 
여러가지를 봐서, ANOVA가 95퍼센트 신뢰도로 자신있으면 추가로 tukey HSD test, Duncan LSR test 를 한다.

# Duncan Test
다중비교를 하는 방법중 하나. post-hoc pair-wise multiple comparison. 모든 짝에 대해서 다른건지 확인. 던칸이 조금더 보수적. 차례대로 소트한다음에 유의범위를 계산하고 최소유의범위값보다 차이가 크면 유의수준에서 두수준평균간에 차이가 있다고 판단한다.

http://rfriend.tistory.com/133

# kernal density estimation (커널밀도추정)
parametric 밀도추정 - 미리 pdf에대한 모델을 정해놓고 데이터들로부터 모델의 파라미터만 추정. 예를들어 일일 트래픽양이 정규분포를 따른다로 가정하면 관측된 데이터들로부터 평균과 분산만 구하면 되기 때문에 밀도 추정 문제가 간단한문제가됨

non-parametric estimation - 히스토크림을 그려놓고 smoothing등을 하는것을 떠올려볼수 있는데, 커널함수를 사용하는것이 불연속성등의 문제를 해결할수 있다. 수학적으로 커널함수는 원점을 중심으로 대칭, 적분값이 1, 가우시안 등이 대표적. 데이터 하나를 커널함수로 대치하여 더함으로써, smooth한 확률밀도함수를 얻을수 있다.

출처:
http://math7.tistory.com/29?category=471451

youtube
https://www.youtube.com/watch?v=dXB3cUGnaxQ

