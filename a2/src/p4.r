housingTrainData = read.csv("housingTrain.csv")
housingTestData = read.csv("housingTest.csv")
# linear regression model of MEDV
fit = lm(MEDV ~ ., data=housingTrainData)
summary(fit)

# Find the RMSE
housingTrainDataRMSE = sqrt(mean(fit$residuals^2))
housingTrainDataRMSE

# Predict on the test set and compute error
housingPred = predict(fit, housingTestData)
housingTestDataRMSE = sqrt(mean((housingPred - housingTestData$MEDV)^2))
housingTestDataRMSE                                              
# compare
percentDiff = (housingTestDataRMSE - housingTrainDataRMSE)/housingTrainDataRMSE
percentDiff

library(glmnet)
# prepare 
housingTrainMEDV = as.matrix(housingTrainData[, 13])
housingTrainOther = as.matrix(housingTrainData[, -13])
housingTestMEDV = as.matrix(housingTestData[, 13])
housingTestOther = as.matrix(housingTestData[, -13])
# ridge fit
housingTrainRidgeFit = glmnet(housingTrainOther, housingTrainMEDV, alpha=0, lambda=seq(0, 3, .1))
housingTrainRidgeFit
plot(housingTrainRidgeFit, xvar="lambda")
summary(housingTrainRidgeFit)

housingTrainRidgeFit2 = cv.glmnet(housingTrainOther, housingTrainMEDV, alpha=0, nfolds=7)
plot(housingTrainRidgeFit2)
ridgePred = predict(housingTrainRidgeFit2, housingTestOther, s="lambda.1se")
rmseRidge = sqrt(mean((ridgePred - housingTestMEDV)^2))
rmseRidge

percentDiff2 = (housingTestDataRMSE - rmseRidge)/rmseRidge
percentDiff2

# lasso fit
housingTrainLassoFit = glmnet(housingTrainOther, housingTrainMEDV, alpha=1, lambda=seq(0, 1, .1))
housingTrainLassoFit
plot(housingTrainLassoFit, xvar="lambda")

housingTrainLassoFit2 = cv.glmnet(housingTrainOther, housingTrainMEDV)
plot(housingTrainLassoFit2)
coef(housingTrainLassoFit2, s="lambda.1se")
lassoPred = predict(housingTrainLassoFit2, newx=housingTestOther, s="lambda.1se")
rmseLasso = sqrt(mean((lassoPred - housingTestMEDV)^2))
rmseLasso 

percentDiff3 = (housingTestDataRMSE - rmseLasso)/rmseLasso
percentDiff3
