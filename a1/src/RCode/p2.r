housingData = read.csv("housing.csv")
attach(housingData)
fit = lm(MEDV ~ ., data=housingData)
summary(fit)

# correlation scatterplot matrix
library(psych)
pairs.panels(housingData)

# correlation scatterplot with a corrplot
library(corrplot)
cor.hbat = cor(housingData)
corrplot(cor.hbat)

#data transformation (DIS, NOX and LSTAT.)
logDis = log(housingData$DIS)
housingData$DIS = logDis
# logNOX has negative impact on R^2
#logNOX = log(housingData$NOX)
#housingData$NOX = logNOX
logLSTAT = log(housingData$LSTAT) 
housingData$LSTAT = logLSTAT
attach(housingData)
fit = lm(MEDV ~ ., data=housingData)
summary(fit)

# stepwise selection
null = lm(MEDV ~ 1, data=housingData)
full = lm(MEDV ~ ., data=housingData)
# forward
housingForward = step(null, scope = list(lower=null, upper=full), direction="forward", trace=F)
summary(housingForward)
#backward
housingBackward = step(full, scope=list(lower=null, upper=full), direction="backward", trace=F)
summary(housingBackward)

#both
housingStep = step(null, scope=list(lower=null, upper=full), direction="both", trace=F)
summary(housingStep)


library(leaps)
housingSubsets = regsubsets(MEDV ~ ., data=housingData, nvmax=13, nbest=1)
reg.summary = summary(housingSubsets)
plot(reg.summary$rsq, xlab="Number of Variables", ylab="RSquare", type="l")
plot(housingSubsets, scale="adjr2")
bestR2Fit = lm(MEDV ~ .-INDUS-AGE-ZN, data=housingData)
summary(bestR2Fit)

library(lm.beta)
stdCoef = coef(lm.beta(housingForward))    
barplot(rev(sort(stdCoef)))  
finalModel = lm(MEDV ~ .-INDUS-AGE-ZN-CHAS, data=housingData)
summary(finalModel)
library(car)
vif(finalModel)
