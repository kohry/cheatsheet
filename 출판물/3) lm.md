# 회귀분석

Regression은 회귀분석이라는 이름으로 사회과학, 자연과학 등 학계 전반에 걸쳐 너무나도 자주 쓰이는 분석방식입니다.

회귀라는 이름은 사실은 그다지 와닫지는 않습니다. 사실은 이름에 대한 유래는 Galton이라는 사람의 실험에서 부터 시작됩니다. 이 실험의 논문 이름은 "Regression towards Mediocrity in Hereditary Stature." 즉, 자식의 키가 부모 두명의 키의 평균으로 회귀(되돌아온다) 한다는 뜻입니다. 이 논문에서 자식의 키 분포 그래프에 보조선을 하나 쭉 그어놓은것도 있구요. 

그렇게 어떻게 어떻게 하다가 이렇게 각 산점도에 이를 설명할수 있는 선을 그려보기도 하고 모델을 만들어 예측하고 분석하는 방법이 regression analysis라는 이름으로 좀더 의미가 변형 확장되어 전해져왔습니다. 딱히 수축하는 현상하고는 관련이 없습니다.

회귀분석은, 관찰된 변수들에 대해 이들 사이의 모델을 계산하고 적합도를 측정해 내는 분석 방법입니다.

# Galton 의 연구자료로 돌아가기

```
install.packages("UsingR")
library(UsingR)
data(galton)
str(galton)

'data.frame':	928 obs. of  2 variables:
 $ child : num  61.7 61.7 61.7 61.7 61.7 62.2 62.2 62.2 62.2 62.2 ...
 $ parent: num  70.5 68.5 65.5 64.5 64 67.5 67.5 67.5 66.5 66.5 ...
 ```

그리고, 데이터들이 제대로 박혀있는지 확인을 해볼수 있습니다.

```
hist(galton$child)
```

<<<< 그래프 제대로 박혀있는지 확인 >>>>

그리고 여기에 꼭 들어맞는 선형회귀식을 도출해볼수 있습니다.

```
lm(child~parent,data=galton)

Call:
lm(formula = child ~ parent, data = galton)

Coefficients:
(Intercept)       parent  
    23.9415       0.6463 
```

너무나도 쉽게, 자식의키 = 0.65 * 부모의 키 + 23.94 라는 식이 도출되었습니다.
coefficients 는 계수로써, y=ax+b 라는 식에서 a와 b를 뜻합니다.

```
ggplot(data=galton,aes(x=parent,y=child))+geom_count()+geom_smooth(method="lm")
```

좀더 예쁘게 그래프를 그려볼수도 있습니다.

결론적으로, 자식의 키는 부모의 키와 상관관계가 있되, 부모의 키를 100% 따라가는것은 아닌것로 결론을 내볼수 있습니다. 결국 자식의 키가 부모의 키만큼은 아니고, 그보다 적은 수준으로 평균화되는 현상으로 해석할수도 있겠습니다. 

다만, 뭔가 썰렁하기는 합니다. 아마 저 계수들을 얼마나 믿을 수 있는지 어떻게 알수 있을까요? lm으로 나온 변수를 다시 summary를 하면 됩니다.

```
model <- lm(child~parent,data=galton)
summary(model)

Call:
lm(formula = child ~ parent, data = galton)

Residuals:
    Min      1Q  Median      3Q     Max 
-7.8050 -1.3661  0.0487  1.6339  5.9264 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 23.94153    2.81088   8.517   <2e-16 ***
parent       0.64629    0.04114  15.711   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.239 on 926 degrees of freedom
Multiple R-squared:  0.2105,	Adjusted R-squared:  0.2096 
F-statistic: 246.8 on 1 and 926 DF,  p-value: < 2.2e-16
```

위의 값들은 적당한 p-value와 몇가지의 검증가능한 값들을 제시해줍니다. 일단, 모델의 설명력을 나타내는 R제곱, 즉 결정계수는 0.2로 설명력이 떨어집니다. 0~1사이의 값으로 0.5이상 정도 되면 상당히 모델의 설명력이 높다고 할수 있겠습니다. 다만, p-value값들은 모두 2e-16으로 관습적으로 사용하는 0.05보다 낮은 값입니다. parent계수는 미슐랭 별처럼 별 ***로써 믿을만 합니다.

## 예측하기
모델이 나왔으니, 이걸로 간단하게 예측해볼수 있습니다.

```
parents <- data.frame(parent = c(60,65,70))
predict(model, parents)

       1        2        3 
62.71897 65.95042 69.18187 
```

값을 예측하는것을 확인할수 있습니다.

## 다중회귀

지금 자식의 키를 예측하는 변수는 부모의 키 단 하나이나, 이가 여러개가 될수도 있습니다.

예를들어, 아이의 수명을 예측하는 모델을 만드는데 있어 다음과 같이 가능한 모든 변수를 넣어서 계산할 수 있습니다.

```
data(swiss)
model <- lm(formula = Infant.Mortality ~ ., data = swiss)
summary(model)

Residuals:
    Min      1Q  Median      3Q     Max 
-8.2512 -1.2860  0.1821  1.6914  6.0937 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)   
(Intercept)  8.667e+00  5.435e+00   1.595  0.11850   
Fertility    1.510e-01  5.351e-02   2.822  0.00734 **
Agriculture -1.175e-02  2.812e-02  -0.418  0.67827   
Examination  3.695e-02  9.607e-02   0.385  0.70250   
Education    6.099e-02  8.484e-02   0.719  0.47631   
Catholic     6.711e-05  1.454e-02   0.005  0.99634   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.683 on 41 degrees of freedom
Multiple R-squared:  0.2439,	Adjusted R-squared:  0.1517 
F-statistic: 2.645 on 5 and 41 DF,  p-value: 0.03665

```

다만, 몇가지 변수는 p-value가 너무 높습니다. 이럴경우에 어떤 변수를 택해야 하는가의 문제가 있을수 있습니다. 이럴경우에는 변수를 하나씩 추가해보거나 하나씩 제거해보고 모델의 설명력을 측정하는 방식을 쓰면 편합니다. 이를 자동으로 해주는 함수는 step() 이 있습니다.

```
smodel <- step(model)
summary(smodel)

Residuals:
    Min      1Q  Median      3Q     Max 
-7.6927 -1.4049  0.2218  1.7751  6.1685 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  8.63758    3.33524   2.590 0.012973 *  
Fertility    0.14615    0.04125   3.543 0.000951 ***
Education    0.09595    0.05359   1.790 0.080273 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.614 on 44 degrees of freedom
Multiple R-squared:  0.2296,	Adjusted R-squared:  0.1946 
F-statistic: 6.558 on 2 and 44 DF,  p-value: 0.003215

```

결국 쓰잘데기없는 변수 빼고 중요한 변수 두개가 선택된것을 볼수있습니다.

## 명목형 변수가 숨어있으면 어떻게 합니까?

명목형 변수가 독립변수에 숨어들어있으면, 수치형 데이터로 바꿔주기가 뭐합니다. 사실 factor()함수를 이용해서 변환하거나 혹은 이미 팩터로 변환되어 있다면 알아서 더미변수를 만들어서 해석합니다. 즉, 인종에대해 황인,흑인,백인이 있다면 제일 기준이 되거나 숫자가 많은 데이터를 제외하고 RaceBlack, RaceWhite 변수를 하나씩 만들어서 이에대해 0과 1로 판단을 하게 됩니다.

이는 실제로, 회귀 기울기를 바꾸지는 않고 절편만을 바꾸어 평행하게 움직이는 역할만을 해줍니다.

# 회귀분석의 표준 가정

회귀분석은 사실, 어느정도의 데이터에 대한 가정이 존재합니다. 이는 다음과 같습니다.

1.오차항(residuals)은 모든 독립변수 값에 대하여 동일한 분산을 갖는다.
2.오차항의 평균(기대값)은 0이다.
3.수집된 데이터의 확률 분포는 정규분포를 이루고 있다.
4.독립변수 상호간에는 상관관계가 없어야 한다.
5.시간에 따라 수집한 데이터들은 잡음의 영향을 받지 않아야 한다.

이게 무슨 소리냐 하면, 각각의 데이터들이 정규분포로 잘 분포되어있어야 하며 뭔가 쏠린게 없이 잘 되어있어야 한다는 겁니다.


## 전진제거, 후진제거
