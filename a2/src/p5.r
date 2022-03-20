insurTrainData = read.csv("insurTrain.csv")
insurTestData = read.csv("insurTest.csv")
newTrainData = insurTrainData[,c("newpol", "pctmin", "fires", "thefts", "pctold", "income")]
newTestData = insurTestData[,c("newpol", "pctmin", "fires", "thefts", "pctold", "income")]
# linear regression model of NEWPOL
fit = lm(newpol ~ ., data=newTrainData)
summary(fit)

# Find the RMSE
insurTrainDataRMSE = sqrt(mean(fit$residuals^2))
insurTrainDataRMSE
# Predict on the test set and compute error
insurPred = predict(fit, newTestData)
insurTestDataRMSE = sqrt(mean((insurPred - newTestData$newpol)^2))
insurTestDataRMSE                                              
# compare
percentDiff = (insurTestDataRMSE - insurTrainDataRMSE)/insurTrainDataRMSE
percentDiff

library(glmnet)
# prepare 
insurTrainNEWPOL = as.matrix(insurTrainData[, 1])
insurTrainOther = as.matrix(insurTrainData[, -1])
insurTestNEWPOL = as.matrix(insurTestData[, 1])
insurTestOther = as.matrix(insurTestData[, -1])
# ridge fit
insurTrainRidgeFit = glmnet(insurTrainOther, insurTrainNEWPOL, alpha=0, lambda=seq(0, 3, .1))
insurTrainRidgeFit
plot(insurTrainRidgeFit, xvar="lambda")
summary(insurTrainRidgeFit)

insurTrainRidgeFit2 = cv.glmnet(insurTrainOther, insurTrainNEWPOL, alpha=0, nfolds=7)
plot(insurTrainRidgeFit2)
ridgePred = predict(insurTrainRidgeFit2, insurTestOther, s="lambda.1se")
rmseRidge = sqrt(mean((ridgePred - insurTestNEWPOL)^2))
rmseRidge


# lasso fit
insurTrainLassoFit = glmnet(insurTrainOther, insurTrainNEWPOL, alpha=1, lambda=seq(0, 1, .1))
insurTrainLassoFit
plot(insurTrainLassoFit, xvar="lambda")

insurTrainLassoFit2 = cv.glmnet(insurTrainOther, insurTrainNEWPOL)
plot(insurTrainLassoFit2)
coef(insurTrainLassoFit2, s="lambda.1se")
lassoPred = predict(insurTrainLassoFit2, newx=insurTestOther, s="lambda.1se")
rmseLasso = sqrt(mean((lassoPred - insurTestNEWPOL)^2))
rmseLasso 

# elastic net regression
fitElastic = glmnet(insurTrainOther, insurTrainNEWPOL, alpha=.5, lambda=seq(0, 5, .1))
plot(fitElastic, xvar="lambda")
fitElastic
# alpha = 0.25
fitElastic25 = cv.glmnet(insurTrainOther, insurTrainNEWPOL, alpha=.25, nfolds=7)
elasticPred25 = predict(fitElastic25, insurTestOther, s="lambda.1se")
rmseElastic25 = sqrt(mean((elasticPred25 - insurTestNEWPOL)^2))
rmseElastic25
# alpha = 0.5
fitElastic = cv.glmnet(insurTrainOther, insurTrainNEWPOL, alpha=.5, nfolds=7)
elasticPred = predict(fitElastic, insurTestOther, s="lambda.1se")
rmseElastic = sqrt(mean((elasticPred - insurTestNEWPOL)^2))
rmseElastic
# alpha = 0.75
fitElastic75 = cv.glmnet(insurTrainOther, insurTrainNEWPOL, alpha=.75, nfolds=7)
elasticPred75 = predict(fitElastic75, insurTestOther, s="lambda.1se")
rmseElastic75 = sqrt(mean((elasticPred75 - insurTestNEWPOL)^2))
rmseElastic75