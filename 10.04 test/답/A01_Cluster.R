KSAT_Clst<-read.table("ClusteringData.txt",header = T)
head(KSAT_Clst)

# (1) Determine # of Cluster
# set.seed(1809)
i<-1
(i<-i+1)
for (i in 1:15) {
  km<-kmeans(KSAT_Clst[,-1],center=i)
  if (i==1) tw<-km$tot.withinss else tw<-c(tw,km$tot.withinss)
}
plot(tw,type="l")

# 10점

# (2) centers & cluster
head(KSAT_Clst)
set.seed(1809)
kms<-kmeans(KSAT_Clst[,-1],center=3)
table(kms$cluster)
class(kms$centers)
(kms_cls<-as.data.frame(kms$centers))
#     Korean  History     Math  Science
# 1 94.45455 90.72727 92.41818 92.14545
# 2 74.87500 62.70000 80.02500 62.55000
# 3 72.78182 97.18182 82.45455 82.30909

KSAT_Clst$cls<-kms$cluster
head(KSAT_Clst)
#        ID Korean History Math Science cls
# 1 1809001     95      98   99     100   1
# 2 1809002    100      97   98      98   1
# 3 1809003     96      95   96      99   1
# 4 1809004     98      97  100      99   1
# 5 1809005     97      99  100      98   1
# 6 1809006     99      98   97      97   1

# (3) duncan.test
library(agricolae) # install.packages("agricolae")
aov_k<-aov(Korean ~ cls, KSAT_Clst)
(dc_k<-duncan.test(aov_k,"cls",console=T))
str(dc_k)
(kms_cls<-kms_cls[order(kms_cls$Korean,decreasing=T),])
kms_cls$dc_k<-dc_k$groups$groups
kms_cls
dc_k$groups

aov_h<-aov(History ~ cls, KSAT_Clst)
dc_h<-duncan.test(aov_h,"cls",console=T)
kms_cls<-kms_cls[order(kms_cls$History,decreasing=T),]
kms_cls$dc_h<-dc_h$groups$groups
kms_cls
dc_h$groups

aov_m<-aov(Math ~ cls, KSAT_Clst)
dc_m<-duncan.test(aov_m,"cls",console=T)
kms_cls<-kms_cls[order(kms_cls$Math,decreasing=T),]
kms_cls$dc_m<-dc_m$groups$groups
kms_cls
dc_m$groups

aov_s<-aov(Science ~ cls, KSAT_Clst)
dc_s<-duncan.test(aov_s,"cls",console=T)
kms_cls<-kms_cls[order(kms_cls$Science,decreasing=T),]
kms_cls$dc_s<-dc_s$groups$groups
kms_cls
dc_s$groups

kms_cls
#     Korean  History     Math  Science dc_k dc_h dc_m dc_s
# 1 94.45455 90.72727 92.41818 92.14545    a    b    a    a
# 3 72.78182 97.18182 82.45455 82.30909    b    a    b    b
# 2 74.87500 62.70000 80.02500 62.55000    b    c    c    c

# (1) plot

# (2)
#     Korean  History     Math  Science
# 1 94.45455 90.72727 92.41818 92.14545
# 2 74.87500 62.70000 80.02500 62.55000
# 3 72.78182 97.18182 82.45455 82.30909

#        ID Korean History Math Science cls
# 1 1809001     95      98   99     100   1
# 2 1809002    100      97   98      98   1
# 3 1809003     96      95   96      99   1
# 4 1809004     98      97  100      99   1
# 5 1809005     97      99  100      98   1
# 6 1809006     99      98   97      97   1

# (3)
#     Korean  History     Math  Science dc_k dc_h dc_m dc_s
# 1 94.45455 90.72727 92.41818 92.14545    a    b    a    a
# 3 72.78182 97.18182 82.45455 82.30909    b    a    b    b
# 2 74.87500 62.70000 80.02500 62.55000    b    c    c    c
