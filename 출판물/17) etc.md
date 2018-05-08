# Holt Winter

```
require(graphics)

## Seasonal Holt-Winters
(m <- HoltWinters(co2))
co2
plot(m)
plot(fitted(m))

(m <- HoltWinters(AirPassengers, seasonal = "mult"))
plot(m)

## Non-Seasonal Holt-Winters
x <- uspop + rnorm(uspop, sd = 5)
m <- HoltWinters(x, gamma = FALSE)
plot(m)

## Exponential Smoothing
m2 <- HoltWinters(x, gamma = FALSE, beta = FALSE)
lines(fitted(m2)[,1], col = 3)
```

# ELK
Elasticsearch Logstash Kibana

## ElasticSearch 
키워드가 어디에 저장되어 있다고 함. 엘라스틱서치로 검사하면 바로바로 어디문서에 있는지 알게됨.

인덱스 - 데이터베이스
타입 - 테이블
도큐먼트 - 로우
필드 - 컬럼
매핑 - 스키마

logstash - elasticsearch에 올리는 거.

kibana - 시각화 툴임.