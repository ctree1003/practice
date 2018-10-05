Classdata <- read.table("C:/Users/student/Documents/ClassData.txt", header = T, stringsAsFactors = T)
set.seed(1809)
Classdata <- subset(Classdata, select = -ID)

sam <- sample(x=c("train","test"), size=nrow(Classdata), replace=T, prob = c(0.7,0.3))
train <- Classdata[sam=="train",]
test <- Classdata[sam=="test",]
