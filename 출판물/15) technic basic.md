# filter()


# merge()

merge는 일종의 조인이고 굉장히 중요함!

dau.install <- merge(dau, install, by = c("user_id", "app_name"))


# ddply()

ddply는 데이터 프레임을 가져와서 그룹으로 더하고 빼고는 쉽게 할수 있다.

library("plyr")
mau.payment <- ddply(dau.install.payment,
                     .(log_month, user_id, install_month), # 그룹화
                     summarize, # 집계 명령
                     payment = sum(payment) # payment 합계
)
head(mau.payment)


ab.test.imp.summary <-
  ddply(ab.test.imp.summary, .(test_case), transform,
        cvr.avg=sum(cv)/sum(imp))
head(ab.test.imp.summary)

     log_date test_case  imp  cv        cvr    cvr.avg
1  2013-10-01         A 1358  98 0.07216495 0.08025559
2  2013-10-02         A 1370  88 0.06423358 0.08025559
3  2013-10-03         A 1213 170 0.14014839 0.08025559
4  2013-10-04         A 1521  89 0.05851414 0.08025559
5  2013-10-05         A 1587  56 0.03528670 0.08025559
6  2013-10-06         A 1219 120 0.09844135 0.08025559

# scales

1000과 같이 3자릿수마다 쉼표로 구분해주는 편리한 도구

# reshape2 - dcast
세그먼트 분석（성별과 연령대를 조합해 집계） 

library(reshape2)
dcast(dau.user.info, log_month ~ gender + generation, value.var = "user_id",
      length)

  log_month F_10  F_20  F_30 F_40 F_50 M_10  M_20  M_30 M_40 M_50
1   2013-08 9091 17181 14217 4597 2257 9694 16490 13855 4231 2572
2   2013-09 7316 13616 11458 3856 1781 8075 13613 10768 3638 2054

# A/B 테스트
어떤 것이 가장 좋은 결과를 가져다줄지 알아보기 위한 검증방법.
초기 도입시 개발비용이 많이 들지만 비교적 낮은 비용으로 실시가능.

# 카이제곱 테스트
통계적으로 둘이 차이가 있는지 .. 0.05 이하면 차이가 있다는 것임.

# unique()
유일한 레코드를 가져와줌.

# xtabs()

```
DF <- as.data.frame(UCBAdmissions)
DF
xtabs(Freq ~ Gender + Admit, DF)

        Admit
Gender   Admitted Rejected
  Male       1198     1493
  Female      557     1278
```

# reshape2 - melt() cast() reshape()
melt

```
french_fries
m <- melt(french_fries, id.vars=1:4)
m
r <- dcast(m, time + treatment + subject + rep ~ ...)
r
```
다시 원복됨.


