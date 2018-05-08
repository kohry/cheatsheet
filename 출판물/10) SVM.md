# 서포트 벡터 머신 (Support Vector Machine)

서포트 벡터 머신은 상당히 유용한 방법이면서도 이름으로는 쉽게 그 역할을 가늠할수 없는 방법이기도 합니다.
사실, 서포트 벡터를 이름만으로 느끼기는 힘드니, 그래프를 하나 봅시다

<<<그래프>>>

여기서, 서포트 벡터는 최대 간격에 제일 가까워서 두꺼운 경계선을 만드는데 도움을 주는 녀석들을 말합니다. 
우리가 무언가를 구별하는 문제에 있어서 사실은 어디엔가 선을 그어야 하는 문제가 있습니다.
예를들어, 2차원 산점도에서 어떤곳에 직선을 그어야 될는지 판단해서 한쪽은 복숭아로, 한쪽은 사과로 판단해야 하는 문제가 있는데,
서포트 벡터 머신은 구별하는 선을 잘 그릴수 있게 도와주는 역할을 합니다. 제일 두껍게 그리는 점을 찾아주기 때문입니다.

## 차원을 늘리는 방법

PCA의 경우는 차원을 필요한만큼 줄여버렸지만, SVM은 내부적으로 필요한경우 직선으로 안될것 같으면 아예 차원을 높여버립니다.
2차원에서의 구분선은 직선(1차원)이고, 3차원에서의 구분은 면(2차원)이라고 한다면, 4차원에서의 구분선은.. 5차원에서의 구분선은.. 머리가 돌아가지 않으니 초평면(Hyperplane)이라는 그럴듯한 말을 붙입니다.
우리가 이를 머릿속에 굳이 그리지 않아도 됩니다.
SVM은 그 성능이 좋기 때문에 차량 번호판 인식등에 자주 쓰입니다.

## 간단하게 이용해보기

사용할수 있는 라이브러리는 kernlab 패키지, e1071패키지 등이 있습니다. 여기서는 e1071패키지를 이용해봅니다.

여기서는 대표적인 iris를 가지고 웜업을 해봅니다.

```
svm_model <- svm(Species ~ ., data=iris)
svm_model

Call:
svm(formula = Species ~ ., data = iris)


Parameters:
   SVM-Type:  C-classification 
 SVM-Kernel:  radial 
       cost:  1 
      gamma:  0.25 

Number of Support Vectors:  51

```

## 예측하기

svm을 이용하기 위해서는 여러가지 하이퍼파라미터 (사용자가 튜닝을 해야하는값)을 조정해 최대의 효과를 측정해보아야 하는데, 위의 설명에서 Parameter가 이를 뜻합니다. 서포트 벡터의 수도 나와있습니다.
간단하게 훈련했고, 이를 통해 결과를 예측해 보겠습니다.

```
s <- subset(iris, select=-Species)
table(predict(svm_model,s), iris$Species)

             setosa versicolor virginica
  setosa         50          0         0
  versicolor      0         48         2
  virginica       0          2        48
```

## 튜닝하기

테스트 결과를 제대로 나눈건 아니지만 신기하게도 일반적인 일반선형회귀 모델이나 결정나무보다 더 나은 성능을 보이는것 같이 보이기도 합니다. 게다가 SVM은 여기서 끝이 아니고, 튜닝할수 있는 여지가 많이 남아있기는 합니다. tune()함수를 이용하면 됩니다.

```
svm_tune <- tune(svm, train.x=subset(iris, select=-Species), train.y=iris$Species, kernel="radial", ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))
svm_tune

Parameter tuning of ‘svm’:

- sampling method: 10-fold cross validation 

- best parameters:
 cost gamma
    1   0.5

- best performance: 0.04666667 
```
커널과 cost, gamma값을 여러가지로 주어서 구별을 해낼수가 있습니다. 이 tune을 가지고 찾아낸 파라미터를 옵션으로 주고 다시한번 예측해볼수도 있습니다.

```
svm_model_after_tune <- svm(Species ~ ., data=iris, kernel="radial", cost=1, gamma=0.5)
pred <- predict(svm_model_after_tune,subset(iris, select=-Species))
table(pred,iris$Species)

pred         setosa versicolor virginica
  setosa         50          0         0
  versicolor      0         48         2
  virginica       0          2        48

```

사실은 결과가 거의 완벽하게 나와있었기때문에 별 의미는 없으나, 조금 더 큰 데이터셋을 가지고 커널과 여러 파라미터를 바꾸면서 시도하면 모델의 향상이 이뤄집니다. SVM은 단순히 옛날 방법이 아닌, 최근에서도 계속해서 딥러닝 계층에서 종종 보이는 방법입니다.
