library(dplyr)
library(rpart)
library(data.table)

Regdata <- read.table("C:/Users/student/Downloads/RegData.txt", header = T)
set.seed(1809)
Regdata <- subset(Regdata, select = -ID)

sam <- sample(x=c("train","test"), size=nrow(Regdata), replace=T, prob = c(0.7,0.3))
train <- Regdata[sam=="train",]
test <- Regdata[sam=="test",]
set.seed(1809)
head(train)
m1 <- lm(Korean ~ History + Math + Science, data = train)
#점수와 잠자는 시간으로 나눠서 분석해보았다
m2 <- lm(Korean ~ ., data = train)
#전체 분석해보았다
summary(m1)
summary(m2)
#모르겠다

par(mfrow=c(2,2)) #화면을 4개로 나눈후
plot(m1) #lm값 출력
plot(m2) #4번째 그림에서 m1이 좀더 선과 맞아보인다
set.seed(1809)
m3=step(m2) #전부 분석한 값을 step줄여보자
summary(m3) # 11개 컬럼중 5개만 남았다
plot(m3) # 그래프로 봐도 이게 최적화 된건지 잘 
