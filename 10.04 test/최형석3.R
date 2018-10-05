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

m1 <- lm(Korean ~ History + Math + Science + SleepHr, data = train)
#점수와 잠자는 시간으로 나눠서 분석해보았다
summary(m1)
#모르겠다
head(train)
