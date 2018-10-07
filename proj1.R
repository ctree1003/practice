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
purchase <- fread("D:/R/02.txt", header = T, sep = ",")
product <- read.table("D:/R/03.txt", header = T, sep = ",", stringsAsFactors = F,
                      col.names = c("co.com", "big.code", "mid.code", "small.code",
                                    "mid.name", "small.name"))

table(demo$location)#서울 지역인원 확인 100이하는 서울인원
demo1 <- demo #복사본 생성
demo1 <- subset(demo, location <= 99) #서울 지역인원만 추출
demo1 #확인
