install.packages("data.table")
install.packages("plyr")
install.packages("dplyr")
install.packages("ggplot2")

library(plyr)
library(dplyr)
library(ggplot2)
library(data.table)#install.packages("data.table")

demo <- read.table("C:/Users/student/Documents/multi_chs/pro/01.txt", header = T, col.names = c("no", "sex", "age", "location"), sep = ",", stringsAsFactors = F)
purchase <- fread("C:/Users/student/Documents/multi_chs/pro/02.txt", header = T, sep = ",")
product <- read.table("C:/Users/student/Documents/multi_chs/pro/03.txt", header = T, sep = ",", 
                      stringsAsFactors = F,
                      col.names = c("co.com", "big.code", "mid.code","small.code","mid.name", "small.name"))
table(demo$location)
demo1 <- demo #복사본 생성
demo1 <- subset(demo, location <= 99) #서울 지역인원만 추출
table(demo1$location) #확인

table(demo1$no) #서울 시민만 뽑았으니 구매내역도 서울시민만 뽑고싶다

head(purchase2)
