KSAT_Class<-read.table("ClassData.txt",header = T)
head(KSAT_Class)

KSAT_Class$PassFail<-factor(KSAT_Class$PassFail)

# (1) Data Split
set.seed(1809)
tr_ind <- sample(1:nrow(KSAT_Class),0.70*nrow(KSAT_Class))
tr<-KSAT_Class[tr_ind,]
tt<-KSAT_Class[-tr_ind,]

# (2) rpart
set.seed(1809)
library(rpart)
rp_kcls<-rpart(PassFail~., data=tr[,-1])
(tbl_tr_rp<-table(predict(rp_kcls,type="class"),tr$PassFail))
sum(diag(tbl_tr_rp))/sum(tbl_tr_rp)
#    0  1
# 0 50  7
# 1  8 40
# 0.8571429 # (3)

(tbl_tt_rp<-table(predict(rp_kcls,newdata=tt,type="class"),tt$PassFail))
sum(diag(tbl_tt_rp))/sum(tbl_tt_rp)
#    0  1
# 0 17  4
# 1  4 20
# 0.8222222 # (3)

library(pROC)
roc(as.numeric(as.character(predict(rp_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail)))
auc(roc(as.numeric(as.character(predict(rp_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail))))
# 0.8214 # (4)
# plot(roc(as.numeric(as.character(predict(rp_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail))))

# (3) randomForest (10)
set.seed(1809)
library(randomForest)
rf_kcls<-randomForest(PassFail~., data=tr[,-1], ntree=2001)

(tbl_tr_rf<-table(predict(rf_kcls,type="class"),tr$PassFail))
sum(diag(tbl_tr_rf))/sum(tbl_tr_rf)
#    0  1
# 0 46 11
# 1 12 36
# 0.7809524 # (3)

(tbl_tt_rf<-table(predict(rf_kcls,newdata=tt,type="class"),tt$PassFail))
sum(diag(tbl_tt_rf))/sum(tbl_tt_rf)
#    0  1
# 0 18  7
# 1  3 17
# 0.7777778 # (3)

library(pROC)
roc(as.numeric(as.character(predict(rf_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail)))
auc(roc(as.numeric(as.character(predict(rf_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail))))
# 0.785 # (4)
# plot(roc(as.numeric(as.character(predict(rf_kcls,newdata=tt,type="class"))),as.numeric(as.character(tt$PassFail))))
