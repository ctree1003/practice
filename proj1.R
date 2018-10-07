install.packages("data.table")
install.packages("plyr")
install.packages("dplyr")
install.packages("ggplot2")

library(plyr)
library(dplyr)
library(ggplot2)
library(data.table)#install.packages("data.table")

demo <- read.table("D:/R/01.txt", header = T, 
                   col.names = c("no", "sex", "age", "location"), 
                   sep = ",", stringsAsFactors = F)

purchase <- fread("D:/R/02.txt", header = T, sep = ",", stringsAsFactors = F, 
                  col.names = c("co.com", "re.no", "big.code", "mid.code", 
                                "smal.code", "no", "mk.no", "pur.date", "pur.time",
                                "pur.price"))

product <- read.table("D:/R/03.txt", header = T, sep = ",", stringsAsFactors = F,
                      col.names = c("co.com", "big.code", "mid.code", "small.code",
                                    "mid.name", "small.name"))
table(demo$location) #서울 인원 확인
demo1 <- demo #복사본 생성
demo1 <- subset(demo, location <= 99) #서울 지역인원만 추출
demo1 #확인

purchase$pur.date <- as.Date(paste(purchase$pur.date), format("%Y%m%d")) #int형이였던 구매일자 date형으로 변환

demo_merge <- merge(x = demo1, y = purchase, by = "no", all.x = T) 
#demo1 과 purchase에서 no가 같은것을 첫번째 데이터프레임의 키 열의 모든 데이터를 포함하여 합친다

head(demo_merge)

