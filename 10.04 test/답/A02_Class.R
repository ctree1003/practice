KSAT_Class<-read.table("ClassData.txt",header = T)
head(KSAT_Class)

KSAT_Class$PassFail<-factor(KSAT_Class$PassFail)

# (1) Data Split
set.seed(1809)
ind_cls<-sample(2,nrow(KSAT_Class),replace=T, prob=c(0.7,0.3))

table(ind_cls)
tr<-KSAT_Class[ind_cls==1,]
tt<-KSAT_Class[ind_cls==2,]

# (2) rpart
set.seed(1809)
library(rpart)
head(tr)
rp_kcls<-rpart(PassFail~., data=tr[,-1])
head(predict(rp_kcls))
head(predict(rp_kcls,type="class"))
head(predict(rp_kcls, newdata=tr,type="class"))

(tbl_tr_rp<-table(predict(rp_kcls,type="class"),tr$PassFail))
sum(diag(tbl_tr_rp))/sum(tbl_tr_rp)
#    0  1
# 0 43  4
# 1 10 40
# 0.8556701 # (3)

(tbl_tt_rp<-table(predict(rp_kcls,newdata=tt,type="class"),tt$PassFail))
sum(diag(tbl_tt_rp))/sum(tbl_tt_rp)
#    0  1
# 0 18  5
# 1  8 22
# 0.754717 # (3)

library(pROC)
roc(as.numeric(as.character(predict(rp_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail)))
auc(roc(as.numeric(as.character(predict(rp_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail))))
# 0.758 # (4)
# plot(roc(as.numeric(as.character(predict(rp_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail))))

# (3) randomForest (10)
set.seed(1809)
library(randomForest)
rf_kcls<-randomForest(PassFail~., data=tr[,-1], ntree=2001)

(tbl_tr_rf<-table(predict(rf_kcls,type="class"),tr$PassFail))
sum(diag(tbl_tr_rf))/sum(tbl_tr_rf)
#    0  1
# 0 42  9
# 1 11 35
# 0.7938144 # (3)

(tbl_tt_rf<-table(predict(rf_kcls,newdata=tt,type="class"),tt$PassFail))
sum(diag(tbl_tt_rf))/sum(tbl_tt_rf)
#    0  1
# 0 20  6
# 1  6 21
# 0.7735849 # (3)

library(pROC)
roc(as.numeric(as.character(predict(rf_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail)))
auc(roc(as.numeric(as.character(predict(rf_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail))))
# 0.7735 # (4)
# plot(roc(as.numeric(as.character(predict(rf_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail))))
