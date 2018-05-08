# 애인의 까다로운 입맛을 만족시키는 프로그램 – 협업필터링 추천시스템

사람들의 입맛을 만족시키는 것은 굉장히 어렵습니다. 당장 점심메뉴만 해도 굉장히 선택하기 힘든데, 한끼한끼가 소중한 애인과의 데이트는 신중히 결정하여야 하는게 사실입니다.

하지만 당신은 굉장히 능숙한 애인 전문가이기 때문에 상당히 많은 사람과 데이트한 결과를 잘 정리해놓은 표가 있습니다. 이러한 상황에서 당신은 정말 마음에 드는 이상형과 소개팅을 하게 되었고 소개팅 이성은 태국음식인 똠양꿍을 나름 좋아하는것처럼 보였기에, 다음의 만남에서도 신중하게 음식을 고르기로 합니다. 

	김태형	송혜형	전지형	설형	한가형	이상형
짬뽕	1	4	2	5	3	?
탕수육	2	5	3	4	4	3
햄버거	1	5	3	1		?
뿌빳뽕커리	5	2	5	1	5	?
똠양꿍	4	2	5	1	3	5
비빔밥	3	1	1	5	3	?

## 적용분야

보통의 사람들은 하나를 좋아하면 비스무리한 다른것도 좋아하는 경향이 있으며, 헙업필터링은 이를 이용해서 다른사람들이 사전에 해놓은 데이터를 배경으로 빠르게 다른 물건들을 해줍니다. 

예를들어 인터넷 서점의 경우, 수많은 책들중에 내가 구입한건 거의 한두개인데 이를 바탕으로 빠르게 다른 비슷한 책들을 추천해야하는 인터넷 서점의 경우에 딱 들어맞게 사용할수 있는것입니다. 넷플릭스와 다른 컨텐츠 추천 서비스들도 비슷하게 돌아가고 있습니다.

## arules 에서 제공하는 기능 쓰기

사실, 차있지 않은 행렬은 대부분 값이 NULL이나 0이 저장되어야하므로 공간만 차지하고 쓸모가 없어서 희소행렬이라는 특별한 행렬을 이용합니다.

```
install.packages("arules")
library(arules)
groceries <- read.transactions("groceries.csv", sep=",")
summary(groceries)

transactions as itemMatrix in sparse format with
 9835 rows (elements/itemsets/transactions) and
 169 columns (items) and a density of 0.02609146 

most frequent items:
      whole milk other vegetables       rolls/buns             soda           yogurt          (Other) 
            2513             1903             1809             1715             1372            34055 

element (itemset/transaction) length distribution:
sizes
   1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21 
2159 1643 1299 1005  855  645  545  438  350  246  182  117   78   77   55   46   29   14   14    9   11 
  22   23   24   26   27   28   29   32 
   4    6    1    1    1    1    3    1 

   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  1.000   2.000   3.000   4.409   6.000  32.000 

includes extended item information - examples:
            labels
1 abrasive cleaner
2 artif. sweetener
3   baby cosmetics

```

arules 에서 제공하는 기능을 쓰면, 실제로 어떤 열에 어떤 데이터가 있는지, 몇개가 있는지 상관없이 한줄에 하나씩 쓰면 됩니다.
최대 32개를 한꺼번에 구매한 사람도 있으며, 딱 하나만 산 사람도 존재합니다. 어떻게 무슨 물품을 샀는지 확인하려면 아래와 같이 적습니다.

```
inspect(groceries[1:5])
```

## 아이템별 빈도 확인과 시각화

```
itemFrequency(groceries[,1:3])
itemFrquencyPlot(groceries, support = 0.1)
itemFrequencyPlot(groceries, topN = 20)
image(groceries[1:5])
```

이는 지지도 0.1이상만 보여주는 시각화 자료로써, support는 전체 갯수중 몇개가 있나를 살펴볼수 있습니다. 전체 아이템이 아닌 전체 거래중 특정 아이템이 포함된 놈만 해당되는걸 알수있습니다.
또한 희소행렬의 시각화도 확인할수 있습니다.

## 지지도(support)
어떤 아이템을 구입했다면, 전체 N개의 거래중에 실제로 해당하는 아이템이 있는 거래가 몇건인지 알려줍니다.

## 신뢰도(confidence)
어떤 A아이템이 포함된 거래중, A와 B거래가 모두 포함된 거래의 비율을 말합니다. 1보다 당연히 작을것입니다.

## 리프트(lift)
lift가 1보다 크면, 우연으로 예상하는 것보다 더 자주 발견이된다는 뜻. A => B 신뢰도를 B의 지지도를 나누면, 1이면 별다른 뜻이 없는 것입니다. 우연의 요소를 제거해야하기 때문에 지지도로 나눠줍니다.

## apriori 함수
```
apriori(groceries)
```
를 통해 함수를 실행하면 set of 0 rules 라는 문구가 나옵니다. 이는 기본적으로 0.1의 지지도가 설정되어있는데, 하루에 0.1의 지지도를 나타내는 아이템은 아까 플롯에서 살펴보았듯이 몇개 되지도 않기 때문에 모수가 적어져 버리는 단점이 있습니다.

```
gr <- apriori(groceries, parameter = list(support = 0.006, confidence = 0.25, minlen = 2))
inspect(sort(gr, by = "lift")[1:20])
     lhs                                             rhs                  support     confidence
[1]  {herbs}                                      => {root vegetables}    0.007015760 0.4312500 
[2]  {berries}                                    => {whipped/sour cream} 0.009049314 0.2721713 
[3]  {other vegetables,tropical fruit,whole milk} => {root vegetables}    0.007015760 0.4107143 
[4]  {beef,other vegetables}                      => {root vegetables}    0.007930859 0.4020619 
[5]  {other vegetables,tropical fruit}            => {pip fruit}          0.009456024 0.2634561 
[6]  {beef,whole milk}                            => {root vegetables}    0.008032537 0.3779904 
[7]  {other vegetables,pip fruit}                 => {tropical fruit}     0.009456024 0.3618677 
[8]  {pip fruit,yogurt}                           => {tropical fruit}     0.006405694 0.3559322 
[9]  {citrus fruit,other vegetables}              => {root vegetables}    0.010371124 0.3591549 
[10] {other vegetables,whole milk,yogurt}         => {tropical fruit}     0.007625826 0.3424658 
[11] {other vegetables,whole milk,yogurt}         => {root vegetables}    0.007829181 0.3515982 
[12] {tropical fruit,whipped/sour cream}          => {yogurt}             0.006202339 0.4485294 
[13] {other vegetables,tropical fruit,whole milk} => {yogurt}             0.007625826 0.4464286 
[14] {other vegetables,rolls/buns,whole milk}     => {root vegetables}    0.006202339 0.3465909 
[15] {frozen vegetables,other vegetables}         => {root vegetables}    0.006100661 0.3428571 
[16] {other vegetables,tropical fruit}            => {root vegetables}    0.012302999 0.3427762 
[17] {sliced cheese}                              => {sausage}            0.007015760 0.2863071 
[18] {other vegetables,tropical fruit}            => {citrus fruit}       0.009049314 0.2521246 
[19] {beef}                                       => {root vegetables}    0.017386884 0.3313953 
[20] {citrus fruit,root vegetables}               => {other vegetables}   0.010371124 0.5862069 
     lift     count
[1]  3.956477  69  
[2]  3.796886  89  
[3]  3.768074  69  
[4]  3.688692  78  
[5]  3.482649  93  
[6]  3.467851  79  
[7]  3.448613  93  
[8]  3.392048  63  
[9]  3.295045 102  
[10] 3.263712  75  
[11] 3.225716  77  
[12] 3.215224  61  
[13] 3.200164  75  
[14] 3.179778  61  
[15] 3.145522  60  
[16] 3.144780 121  
[17] 3.047435  69  
[18] 3.046248  89  
[19] 3.040367 171  
[20] 3.029608 102  
```

## 특정한 물품이 들어간 거래에 대해 찾고싶을때

```
br <- subset(gr, items %in% "berries")
inspect(br)
    lhs          rhs                  support     confidence lift     count
[1] {berries} => {whipped/sour cream} 0.009049314 0.2721713  3.796886  89  
[2] {berries} => {yogurt}             0.010574479 0.3180428  2.279848 104  
[3] {berries} => {other vegetables}   0.010269446 0.3088685  1.596280 101  
[4] {berries} => {whole milk}         0.011794611 0.3547401  1.388328 116  
```

## 조심하여야 할 점
지지도를 너무 높게 잡으면, 왠만한 대상 아이템들이 다 쓸려나가며, 너무 낮게 잡으면 별로 중요하지 않은 아이템까지 고려대상이 되어 아무 인사이트를 발견하지 못할수도 있습니다. 이 숫자는 어느정도 통찰력이 필요한 부분입니다.



