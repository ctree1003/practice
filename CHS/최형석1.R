library(plyr)
library(dplyr)
library(ggplot2)
library(data.table)

clust_ori <- read.table("C:/Users/student/Downloads/ClusteringData.txt", header = T)
set.seed(1809)
clust <- subset(clust_ori, select = -ID) #ID값 제거
k_result1 <- kmeans(clust, 1) #간략화 시키는법 
k_result2 <- kmeans(clust, 2) #나중에 공부
k_result3 <- kmeans(clust, 3)
k_result4 <- kmeans(clust, 4)
k_result5 <- kmeans(clust, 5)
k_result6 <- kmeans(clust, 6)
k_result7 <- kmeans(clust, 7)
k_result8 <- kmeans(clust, 8)
k_result9 <- kmeans(clust, 9)
k_result10 <- kmeans(clust, 10)
k_result11 <- kmeans(clust, 11)
k_result12 <- kmeans(clust, 12)
k_result13 <- kmeans(clust, 13)
k_result14 <- kmeans(clust, 14)
k_result15 <- kmeans(clust, 15)

a <-  k_result1$tot.withinss #값 입력
b <-  k_result2$tot.withinss #이것도 방법을 찾아보자
c <-  k_result3$tot.withinss
d <-  k_result4$tot.withinss
e <-  k_result5$tot.withinss
f <-  k_result6$tot.withinss
g <-  k_result7$tot.withinss
h <-  k_result8$tot.withinss
i <-  k_result9$tot.withinss
j <-  k_result10$tot.withinss
k <-  k_result11$tot.withinss
l <-  k_result12$tot.withinss
m <-  k_result13$tot.withinss
n <-  k_result14$tot.withinss
o <-  k_result15$tot.withinss

k_result <- rbind(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o) #통합

data <- data.frame(NC=c(1:15))
k_result <- cbind(data,k_result)
names(k_result) <- c("NC","Value")

ggplot(data = k_result, aes(x=NC, y=Value )) + geom_line()

centervalue <- data.frame(k_result3$centers)  

clust$cls1 <- k_result1$cluster
clust$cls2 <- k_result2$cluster
clust$cls3 <- k_result3$cluster
clust$cls4 <- k_result4$cluster
clust$cls5 <- k_result5$cluster
clust$cls6 <- k_result6$cluster
clust$cls7 <- k_result7$cluster
clust$cls8 <- k_result8$cluster
clust$cls9 <- k_result9$cluster
clust$cls10 <- k_result10$cluster
clust$cls11 <- k_result11$cluster
clust$cls12 <- k_result12$cluster
clust$cls13 <- k_result13$cluster
clust$cls14 <- k_result14$cluster
clust$cls15 <- k_result15$cluster

head(clust,6)




