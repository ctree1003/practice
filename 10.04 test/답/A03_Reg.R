K_reg<-read.table("RegData.txt",header = T)
head(K_reg)

# (1) Data Split
set.seed(1809)
ind_reg<-sample(2,nrow(K_reg),replace=T, prob=c(0.7,0.3))
table(ind_reg)
tr_reg<-K_reg[ind_reg==1,]
tt_reg<-K_reg[ind_reg==2,]

# (2) lm & Summary & plot
set.seed(1809)
head(tr_reg)
lm_ks<-lm(K_SAT~.,data=tr_reg[,-1])
summary(lm_ks)

par(mfrow=c(2,2))
plot(lm_ks)
par(mfrow=c(1,1))

# (3) RMSE & MAPE
sqrt(mean((predict(lm_ks,newdata=tr_reg)-tr_reg$K_SAT)^2))
sqrt(sum((predict(lm_ks)-tr_reg$K_SAT)^2)/nrow(tr_reg))
# 15.56236
mean(abs(predict(lm_ks)-tr_reg$K_SAT)/tr_reg$K_SAT) # MAPE
# 0.03997937
# https://en.wikipedia.org/wiki/Mean_absolute_percentage_error

sqrt(mean((predict(lm_ks,newdata=tt_reg)-tt_reg$K_SAT)^2))
# 17.04495
mean(abs(predict(lm_ks,newdata=tt_reg)-tt_reg$K_SAT)/tt_reg$K_SAT)
# 0.04372132

# (4) Step Default
set.seed(1809)
lm_min<-lm(K_SAT~1,data=tr_reg[,-1])
step(lm_min,scope=list(lower=lm_min,upper=lm_ks),direction = "forward")

f_ks<-formula(lm(K_SAT~.,data=tr_reg[,-1]))
step(lm_min, scope = f_ks, direction = "forward")

step(lm_min, scope = formula(lm_ks), direction = "forward")
