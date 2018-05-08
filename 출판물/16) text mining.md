# 텍스트 마이닝
핵심 키워드를 도출해야 한다.

# 핵심 키워드 도출

# 단어 간 관계 분석

# 감정 분석

# 토픽 분석

- LSA: 분절된 단어들에 벡터값을 부여하고 차원축소를 하여 축소된 차원에서 근접한 단어들을
주제로 묶음
- LDA: 확률을 바탕으로 단어가 특정 주제에 존재할 확률과 문서에 특정 주제가 존재할 확률을
결합확률로 추정하여 토픽추출

# 맥락에 따른 단어 및 문서 분석 : bag of words

```
txt1 <- "R programming is fun!"
strsplit(txt1," ")
```

```
library(koNLP)
txt2 <- "한글 분석은 쉽지 않습니다"
strsplit(txt2," ")
extractNoun(txt2)
```

```
useSejongDic( )
mergeUserDic(data.frame(c('유관순','안중근'),c('ncn')))
mergeUserDic(data.frame(readLines("mergefile.txt"), "ncn"))
txt3 <- unique(txt2)
```

```
data2 <- Map(extractNoun,data1)
```


필요없는 문자 제거
```
txt5 <- rapply(txt4, function(x) gsub("최고", "", x), how = "replace")
```


# 워드클라우드

```
library(wordcloud2)
wordcount2 <- head(sort(wordcount, decreasing=T),100)
wordcloud2(wordcount2,gridSize=1,size=0.5,shape="diamond")
```

```
setwd("c:\\a_temp")
install.packages(“KoNLP”)
install.packages(“wordcloud”)
install.packages("stringr")
library(KoNLP)
library(wordcloud)
library(stringr)
#Step 1. 분석 파일을 불러 옵니다
data1 <- readLines("영화_밀정.txt")
data1
#Step 2. 문장을 단어로 분리합니다.
##########################################################################
##> tran1 <- Map(extractNoun, data1)
## Error in `Encoding<-`(`*tmp*`, value = "UTF-8") :
## 문자형 벡터 인자가 와야 합니다
## 위 에러가 나오면 아래의 글자수로 걸러주는 작업을 합니다.
## 위 에러는 띄어쓰기가 없이 너무 긴 문장이 들어갈 경우 발생하는 에러입니다.
## 아래의 nchar 뒤에 들어가는 글자수는 작업할 때 마다 적절하게 조절해서 사용하면 됩니다
data2 <- Filter(function(x) {nchar(x) <= 200} ,data1)
data2
tran1 <- Map(extractNoun, data2)
tran1
tran11 <- unique(tran1)
tran2 <- sapply(tran11, unique)
tran2
tran3 <- rapply(tran2, function(x) gsub("리뷰", "", x), how = "replace")
tran3 <- rapply(tran3, function(x) gsub("영화", "", x), how = "replace")
R라뷰 / 서진수 저 / 도서출판 더알음
tran3 <- rapply(tran3, function(x) gsub("평점", "", x), how = "replace")
tran3 <- rapply(tran3, function(x) gsub("내용", "", x), how = "replace")
tran3 <- rapply(tran3, function(x) gsub("제외", "", x), how = "replace")
tran3 <- rapply(tran3, function(x) gsub("ㅋㅋㅋ", "", x), how = "replace")
tran3 <- rapply(tran3, function(x) gsub("ㄱㄱㄱ", "", x), how = "replace")
tran3
tran4 <- sapply(tran3, function(x) {Filter(function(y) {nchar(y) <= 6 && nchar(y) > 1},x)} )
tran4
#Step 3. 공백을 제거하기 위해 저장 후 다시 불러 옵니다.
write(unlist(tran4),"밀정_2.txt")
data4 <- read.table("밀정_2.txt")
data4
nrow(data4)
#Step 4. 각 단어별로 집계하여 출현 빈도를 계산합니다 (1차 확인 단계)
wordcount <- table(data4)
wordcount
wordcount <- Filter(function(x) {nchar(x) <= 10} ,wordcount)
head(sort(wordcount, decreasing=T),100)
#Step 5. 필요없는 단어를 제거한 후 공백을 제거하고 다시 집계를 합니다.
# 이 과정을 여러 번 반복하여 필요 없는 단어들은 모두 제거해야 합니다.
txt <- readLines("영화gsub.txt")
txt
cnt_txt <- length(txt)
cnt_txt
for( i in 1:cnt_txt) {
tran3 <- rapply(tran3, function(x) gsub((txt[i]),"", x), how = "replace")
 }
tran3
data3 <- sapply(tran3, function(x) {Filter(function(y) { nchar(y) >=2 },x)} )
write(unlist(data3),"밀_2.txt")
data4 <- read.table("밀_2.txt")
data4
nrow(data4)
R라뷰 / 서진수 저 / 도서출판 더알음
wordcount <- table(data4)
wordcount
head(sort(wordcount, decreasing=T),100)
#Step 6. 전처리 작업이 모두 완료되면 워드 클라우드를 그립니다.
library(RColorBrewer)
palete <- brewer.pal(7,"Set2")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=5,
random.order=F,random.color=T,colors=palete)
legend(0.3,1 ,"영화 댓글 분석 - 밀정 ",cex=1.2,fill=NA,border=NA,bg="white" ,
 text.col="red",text.font=2,box.col="red")
savePlot("영화_밀정.png",type="png")
```

```
data1 <- iconv(data1,"WINDOWS-1252","UTF-8")
```

```
 corp1 <- Corpus(VectorSource(data1)) 
  inspect(corp1) 
  tdm <- TermDocumentMatrix(corp1)
 ```

 ```
 > corp2 <- tm_map(corp1,stripWhitespace) # 여러 개의 공백을 하나의 공백으로 변환합니다
> corp2 <- tm_map(corp2,tolower) # 대문자가 있을 경우 소문자로 변환합니다
> corp2 <- tm_map(corp2,removeNumbers) # 숫자를 제거합니다
> corp2 <- tm_map(corp2,removePunctuation) # 마침표,콤마,세미콜론,콜론 등의 문자 제거
> corp2 <- tm_map(corp2,PlainTextDocument)
> sword2 <- c(stopwords('en'),"and","but",”not”) # 기본 불용어 외 불용어로 쓸 단어 추가하기
> corp2 <- tm_map(corp2,removeWords,sword2) # 불용어 제거하기 (전치사 , 관사 등)
```

```
> class(m2)
[1] "matrix"
# 위 결과를 보면 tm_map( ) 으로 제거한 and , but , not 이 사라진 것이 확인됩니다.
# 그런데 Docs 의 이름이 character(0) 로 변환되어 어떤 문서인지 구분이 안됩니다.
# 그래서 Matrix 명령어 중 colnames( ) 로 Docs 이름을 변경하겠습니다.
> colnames(m2) <- c(1:4)
> m2
 Docs
Terms 1 2 3 4
 apple 1 0 0 0
 banana 1 1 0 0
 cherry 1 0 1 0
 eat 0 0 0 1
 grape 0 0 0 1
 hate 1 0 1 0
 like 1 0 1 0
 love 0 1 0 0
R라뷰 / 서진수 저 / 도서출판 더알음
 mango 0 1 0 0
 peach 0 0 1 0
 want 0 0 0 1
# 위와 같이 단어들이 추출되었습니다. 보기가 불편하죠?
# 그래서 위 결과를 단어 별로 집계를 해 보겠습니다.
> freq1 <- sort(rowSums(m2),decreasing=T)
> head(freq1,20)
banana cherry hate like apple eat grape love mango peach want
 2 2 2 2 1 1 1 1 1 1 1
# 위 결과처럼 행의 합계를 구할 때는 rowSums( ) 함수를 사용하면 됩니다.
# 만약 컬럼별로 집계를 하고 싶다면 아래와 같이 colSums( ) 함수를 사용하세요.
> freq2 <- sort(colSums(m2),decreasing=T)
> head(freq2,20)
1 3 2 4
5 4 3 3
# 만약 Term Document Matrix 에서 특정 회수 이상 언급된 것들만 출력하고 싶을 경우
# 아래와 같이 findFreqTerms( ) 사용 하세요.
> findFreqTerms(tdm2,2)
[1] "banana" "cherry" "hate" "like"
# 만약 특정 단어와 상관 관계를 찾고 싶을 경우 아래와 같이 findAssocs( ) 사용 하세요.
# 먼저 apple 단어와 상관계수가 0.5 이상인 값들만 출력하는 예입니다.
> findAssocs(tdm2,"apple",0.5)
$apple
banana cherry hate like
 0.58 0.58 0.58 0.58
> findAssocs(tdm2,"apple",0.6)
$apple
numeric(0) # 없을 경우 왼쪽과 같이 0 으로 나옵니다.
# 위 2 가지 함수를 사용해서 Term Document Matrix 내의 데이터를 쉽게 조회할 수 있어요.
# 위와 같이 집계된 내용을 워드 클라우드로 표현하겠습니다.
R라뷰 / 서진수 저 / 도서출판 더알음
> library(RColorBrewer)
> palete <- brewer.pal(7,"Set3")
> wordcloud(names(freq1),freq=freq1,scale=c(5,1),min.freq=1,colors=palete,random.order=F,
+ random.color=T)
# 워드 클라우드에 제목을 표시합니다
> legend(0.3,1 ,"tm Package Test #1 ",cex=1,fill=NA,border=NA,bg="white" ,
+ text.col="red",text.font=2,box.col="red")
# 이번에는 위 결과를 Bar chart 로 출력하겠습니다.
> barplot(freq1,main="tm package test #2",las=2,ylim=c(0,5))
```

```
> corp2 <- tm_map(corp1,stripWhitespace) # 여러개의 공백을 하나의 공백으로 변환합니다
> corp2 <- tm_map(corp2,tolower) # 대문자가 있을 경우 소문자로 변환합니다
> corp2 <- tm_map(corp2,removeNumbers) # 숫자를 제거합니다
> corp2 <- tm_map(corp2,removePunctuation) # 마침표,콤마,세미콜론,콜론 등 문자 제거합니다
> corp2 <- tm_map(corp2,PlainTextDocument)
> stopword2 <- c(stopwords('en'),"and","but") # 기본 불용어 외에 불용어로 쓸 단어 추가하기
> corp2 <- tm_map(corp2,removeWords,stopword2) # 불용어 제거하기 (전치사 , 관사 등)
# 아래 코드에서 wordLengths 옵션은 몇 글자 이상 되는 단어들만 가져와서 Term Document
# Matrix 를 생성하는 명령입니다.
# 단어가 많을 때 특정 글자수 이상의 단어만 골라와서 사용할 때 아주 많이 사용됩니다.
> corp3 <- TermDocumentMatrix(corp2,control=list(wordLengths=c(1,Inf)))
> corp3
<<TermDocumentMatrix (terms: 611, documents: 59)>>
Non-/sparse entries: 924/35125
Sparsity : 97%
Maximal term length: 14
Weighting : term frequency (tf )
> findFreqTerms(corp3,10) # TermDocumentMatrix 에서 10 회 이상 언급된 단어 출력하기
[1] "college" "life"
> findAssocs(corp3,"apple",0.5) # apple 단어와 0.5 이상의 상관관계 있는 단어 출력하기
$apple
R라뷰 / 서진수 저 / 도서출판 더알음
 company fired adult billion board creation
 0.87 0.78 0.73 0.73 0.73 0.73
devastating directors diverge earlier employees eventually
 0.73 0.73 0.73 0.73 0.73 0.73
 falling focus garage gone grew grown
 0.73 0.73 0.73 0.73 0.73 0.73
 hard hired lucky publicly released sided
 0.73 0.73 0.73 0.73 0.73 0.73
 talented two us visions well worked
 0.73 0.73 0.73 0.73 0.73 0.73
 woz started went began year just
 0.73 0.71 0.68 0.67 0.64 0.62
 loved thought pixar
 0.58 0.53 0.52
> corp4 <- as.matrix(corp3)
> corp4
( 출력 결과가 너무 길어 생략하겠습니다 )
> freq1 <- sort(rowSums(corp4),decreasing=T)
> freq2 <- sort(colSums(corp4),decreasing=T)
> head(freq2,20)
character(0) character(0) character(0) character(0) character(0)
 77 71 68 65 63
character(0) character(0) character(0) character(0) character(0)
 62 55 52 49 49
character(0) character(0) character(0) character(0) character(0)
 48 47 45 43 37
character(0) character(0) character(0) character(0) character(0)
 37 37 30 28 24
#위와 같이 컬럼 이름이 character(0) 으로 되면 안된다고 했죠?
# corp4 에 총 몇 개의 컬럼이 있는지 확인 후 숫자로 변경하겠습니다.
> dim(corp4)
[1] 611 59 # 행 수: 611 행 , 컬럼 수 : 59 개 라는 의미 입니다.
R라뷰 / 서진수 저 / 도서출판 더알음
> colnames(corp4) <- c(1:59)
> freq2 <- sort(colSums(corp4),decreasing=T)
# 위 결과에서 5회 이상 언급된 단어들만 모아서 워드 클라우드로 표현하기
> library(RColorBrewer)
> palete <- brewer.pal(7,"Set3")
> wordcloud(names(freq1),freq=freq1,scale=c(5,1),min.freq=5,colors=palete,random.order=F,
+ random.color=T)
> legend(0.3,1 ,"스티브 잡스 연설문 분석 ",cex=1,fill=NA,border=NA,bg="white" ,
+ text.col="red",text.font=2,box.col="red")
```

```
> setwd("c:\\a_temp")
> install.packages("tm")
> library("tm")
> install.packages(“wordcloud”)
> library(“wordcloud”)
> shin1 <- readLines("서울_신라호텔리뷰.txt")
> shin5 <- Corpus(VectorSource(shin1))
> inspect(shin5)
> shin6 <- tm_map(shin5,stripWhitespace) # 여러개의 공백을 하나의 공백으로 변환합니다
> shin6 <- tm_map(shin6,tolower) # 대문자가 있을 경우 소문자로 변환합니다
> shin6 <- tm_map(shin6,removePunctuation) # 마침표,콤마,세미콜론,콜론 등의 문자 제거
> stopword2 <- c(stopwords('english'),"수 있는","같습니다","싶습니다","있습니다","서울에서",
+ "하고","은","서울에서","이용했습니다","곳이예요") # 기본 불용어 외에 불용어로 쓸
# 단어 추가하기
> shin6 <- tm_map(shin6,removeWords,stopword2) # 불용어 제거하기 (전치사 , 관사 등)
> shin6 <- tm_map(shin6,PlainTextDocument)
> inspect(shin6)
> shin7 <-TermDocumentMatrix(shin6)
> inspect(shin7)
> findFreqTerms(shin7,5) # TermDocumentMatrix 안에서 지정된 빈도 수 이상 언급된 단어
> findAssocs(shin7,"신라호텔",0.5)
> shin8 <- as.matrix(shin7) # 일반 Matrix 형태로 변환합니다.
> shin8
> nrow(shin8) # 찾은 단어 개수 , 메트릭스에서 행 수가 됩니다.
> freq1 <- sort(rowSums(shin8),decreasing=T)
> head(freq1,20)
> library(RColorBrewer)
> palete <- brewer.pal(9,"Set3")
> wordcloud(names(freq1),freq=freq1,scale=c(5,1),rot.per=0.25,min.freq=3,
+ random.order=F,random.color=T,colors=palete)
> legend(0.3,1 ,"서울 신라호텔 이용 후기 분석 ",cex=0.8,fill=NA,border=NA,bg="white" ,
+ text.col="red",text.font=2,box.col="red")
R라뷰 / 서진수 저 / 도서출판 더알음
# tm 패키지를 활용한 서울 워커힐 호텔 이용후기 분석하기
> setwd("c:\\a_temp")
> install.packages("tm")
> install.packages("wordcloud")
> library("tm")
> library("wordcloud")
> wh1 <- readLines("서울_워커힐호텔리뷰.txt")
> wh2 <- Corpus(VectorSource(wh1))
> inspect(wh2)
> wh3 <- tm_map(wh2,stripWhitespace) # 여러개의 공백을 하나의 공백으로 변환합니다
> wh3 <- tm_map(wh3,tolower) # 대문자가 있을 경우 소문자로 변환합니다
> wh3 <- tm_map(wh3,removePunctuation) # 마침표,콤마,세미콜론,콜론 등의 문자 제거
> stopword2 <- c(stopwords('english'),"수 있는","같습니다","싶습니다","있습니다","서울에서",
+ "하고","은","곳이예요","서울에서","이용했습니다") # 기본 불용어 외에 불용어로 쓸
# 단어 추가하기
> wh3 <- tm_map(wh3,removeWords,stopword2) # 불용어 제거하기 (전치사 , 관사 등)
> wh3 <- tm_map(wh3,PlainTextDocument)
> wh4 <-TermDocumentMatrix(wh3)
> inspect(wh4)
> findFreqTerms(wh4,5) # TermDocumentMatrix 안에서 지정된 빈도 수 이상 언급된 단어 찾기
> wh5 <- as.matrix(wh4) # 일반 Matrix 형태로 변환합니다.
> nrow(wh5) # 찾은 단어 개수 , 메트릭스에서 행 수가 됩니다.
> freq1 <- sort(rowSums(wh5),decreasing=T)
> library(RColorBrewer)
> palete <- brewer.pal(8,"Set3")
> wordcloud(names(freq1),freq=freq1,scale=c(5,1),rot.per=0.25,min.freq=3,
+ random.order=F,random.color=T,colors=palete)
> legend(0.3,1 ,"서울 워커힐호텔 이용 후기 분석 ",cex=0.8,fill=NA,border=NA,bg="white" ,
+ text.col="red",text.font=2,box.col="red")
```

```
> setwd("c:\\a_temp")
> install.packages("KoNLP")
> install.packages("wordcloud")
> install.packages(“stringr”)
> library(KoNLP)
> library(wordcloud)
> library(stringr)
> useSejongDic()
# 아래 과정이 리뷰들을 R로 불러오는 과정입니다.
> data1 <- readLines("서울_신라호텔리뷰.txt")
> data1 <- gsub(" ","-",data1)
> data1 <- str_split(data1,"-")
> data1 <- str_replace_all(unlist(data1),"[^[:alpha:][:blank:]]","")
#아래 과정이 불러온 리뷰 문장을 단어로 분리하는 과정입니다.
> data2 <- sapply(data1,extractNoun,USE.NAMES=F)
> data2
> head(unlist(data2), 30)
> data3 <- unlist(data2)
# 아래 과정이 필요 없는 단어들이나 기호를 제거하는 과정입니다.
> data3 <- Filter(function(x) {nchar(x) <= 10} ,data3)
> head(unlist(data3), 30)
> data3 <- gsub("\\.","",data3)
> data3 <- gsub(" ","",data3)
> data3 <- gsub("\\'","",data3)
> data3 <- gsub("제목","",data3)
> data3 <- gsub("리뷰","",data3)
> data3 <- gsub("내용","",data3)
> data3 <- gsub("ㅋㅋㅋㅋ","",data3)
> data3 <- gsub("이용","",data3)
> data3 <- gsub("호텔","",data3)
> data3 <- gsub("신라호텔","",data3)
> data3 <- gsub("점수","",data3)
R라뷰 / 서진수 저 / 도서출판 더알음
> write(unlist(data3),"신라호텔_2.txt")
> data4 <- read.table("신라호텔_2.txt")
> nrow(data4)
> wordcount <- table(data4)
> wordcount
> wordcount <- Filter(function(x) {nchar(x) >= 2} ,wordcount)
> head(sort(wordcount, decreasing=T),50)
> txt <- readLines("호텔gsub.txt")
> cnt_txt <- length(txt)
> cnt_txt
> for( i in 1:cnt_txt) {
+ data3 <-gsub((txt[i]),"",data3)
+ }
> data3 <- Filter(function(x) {nchar(x) >= 2} ,data3)
> write(unlist(data3),"신라호텔_3.txt")
> data4 <- read.table("신라호텔_3.txt")
> nrow(data4)
#아래 과정이 필터링이 완료된 단어들을 언급 빈도수로 집계하는 과정입니다.
> wordcount <- table(data4)
> wordcount
> head(sort(wordcount, decreasing=T),100)
> library(RColorBrewer)
> palete <- brewer.pal(9,"Set3")
> wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=4,
+ random.order=F,random.color=T,colors=palete)
> legend(0.3,1 ,"서울 신라호텔 이용 후기 분석 ",cex=0.8,fill=NA,border=NA,bg="white" ,
+ text.col="red",text.font=2,box.col="red")
```

```
 [ 소스 코드 - KoNLP 패키지로 신라호텔 이용후기 분석하기 ]
> setwd("c:\\a_temp")
> install.packages("KoNLP")
> install.packages("wordcloud")
> install.packages(“stringr”)
> library(KoNLP)
> library(wordcloud)
> library(stringr)
> useSejongDic()
# 아래 과정이 리뷰들을 R로 불러오는 과정입니다.
> data1 <- readLines("서울_신라호텔리뷰.txt")
> data1 <- gsub(" ","-",data1)
> data1 <- str_split(data1,"-")
> data1 <- str_replace_all(unlist(data1),"[^[:alpha:][:blank:]]","")
#아래 과정이 불러온 리뷰 문장을 단어로 분리하는 과정입니다.
> data2 <- sapply(data1,extractNoun,USE.NAMES=F)
> data2
> head(unlist(data2), 30)
> data3 <- unlist(data2)
# 아래 과정이 필요 없는 단어들이나 기호를 제거하는 과정입니다.
> data3 <- Filter(function(x) {nchar(x) <= 10} ,data3)
> head(unlist(data3), 30)
> data3 <- gsub("\\.","",data3)
> data3 <- gsub(" ","",data3)
> data3 <- gsub("\\'","",data3)
> data3 <- gsub("제목","",data3)
> data3 <- gsub("리뷰","",data3)
> data3 <- gsub("내용","",data3)
> data3 <- gsub("ㅋㅋㅋㅋ","",data3)
> data3 <- gsub("이용","",data3)
> data3 <- gsub("호텔","",data3)
> data3 <- gsub("신라호텔","",data3)
> data3 <- gsub("점수","",data3)
R라뷰 / 서진수 저 / 도서출판 더알음
> write(unlist(data3),"신라호텔_2.txt")
> data4 <- read.table("신라호텔_2.txt")
> nrow(data4)
> wordcount <- table(data4)
> wordcount
> wordcount <- Filter(function(x) {nchar(x) >= 2} ,wordcount)
> head(sort(wordcount, decreasing=T),50)
> txt <- readLines("호텔gsub.txt")
> cnt_txt <- length(txt)
> cnt_txt
> for( i in 1:cnt_txt) {
+ data3 <-gsub((txt[i]),"",data3)
+ }
> data3 <- Filter(function(x) {nchar(x) >= 2} ,data3)
> write(unlist(data3),"신라호텔_3.txt")
> data4 <- read.table("신라호텔_3.txt")
> nrow(data4)
#아래 과정이 필터링이 완료된 단어들을 언급 빈도수로 집계하는 과정입니다.
> wordcount <- table(data4)
> wordcount
> head(sort(wordcount, decreasing=T),100)
> library(RColorBrewer)
> palete <- brewer.pal(9,"Set3")
> wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=4,
+ random.order=F,random.color=T,colors=palete)
> legend(0.3,1 ,"서울 신라호텔 이용 후기 분석 ",cex=0.8,fill=NA,border=NA,bg="white" ,
+ text.col="red",text.font=2,box.col="red")
R라뷰 / 서진수 저 / 도서출판 더알음
# KoNLP 패키지를 활용한 서울 워커힐 호텔 이용후기 분석 소스
> dev.new( )
> setwd("c:\\a_temp")
> install.packages("KoNLP")
> install.packages("wordcloud")
> library(KoNLP)
> library(wordcloud)
> useSejongDic()
# 아래 과정이 리뷰들을 R로 불러오는 과정입니다.
> data1 <- readLines("서울_워커힐호텔리뷰.txt")
> data1
> data1 <- gsub(" ","-",data1)
> data1 <- str_split(data1,"-")
> data1 <- str_replace_all(unlist(data1),"[^[:alpha:][:blank:]]","")
#아래 과정이 불러온 리뷰 문장을 단어로 분리하는 과정입니다.
> data2 <- sapply(data1,extractNoun,USE.NAMES=F)
> data2
> head(unlist(data2), 30)
> data3 <- unlist(data2)
# 아래 과정이 필요 없는 단어들이나 기호를 제거하는 과정입니다.
> data3 <- Filter(function(x) {nchar(x) <= 10} ,data3)
> head(unlist(data3), 30)
> data3 <- gsub("\\d+","", data3) ## <--- 모든 숫자 없애기
> data3 <- gsub("\\.","",data3)
> data3 <- gsub(" ","",data3)
> data3 <- gsub("\\'","",data3)
> data3 <- gsub("리뷰","",data3)
> data3 <- gsub("내용","",data3)
> data3 <- gsub("ㅋㅋㅋㅋ","",data3)
> data3 <- gsub("서울","",data3)
> data3 <- gsub("리버뷰","한강",data3)
> data3 <- gsub("한강뷰","한강",data3)
> data3 <- gsub("한강전망","한강",data3)
> write(unlist(data3),"워커힐호텔_2.txt")
R라뷰 / 서진수 저 / 도서출판 더알음
> data4 <- read.table("워커힐호텔_2.txt")
> data4
> nrow(data4)
> wordcount <- table(data4)
> wordcount
> wordcount <- Filter(function(x) {nchar(x) >= 2} ,wordcount)
> txt <- readLines("호텔gsub.txt")
> cnt_txt <- length(txt)
> for( i in 1:cnt_txt) {
+ data3 <-gsub((txt[i]),"",data3)
+ }
> data3 <- Filter(function(x) {nchar(x) >= 2} ,data3)
> write(unlist(data3),"워커힐호텔_3.txt")
> data4 <- read.table("워커힐호텔_3.txt")
> nrow(data4)
#아래 과정이 필터링이 완료된 단어들을 언급 빈도수로 집계하는 과정입니다.
> wordcount <- table(data4)
> wordcount
> head(sort(wordcount, decreasing=T),100)
> library(RColorBrewer)
> palete <- brewer.pal(9,"Set1")
> wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=5,
+ random.order=F,random.color=T,colors=palete)
> legend(0.3,1 ,"서울 워커힐호텔 이용 후기 분석 ",cex=0.8,fill=NA,border=NA,bg="white" ,
+ text.col="red",text.font=2,box.col="red")
```