library(MASS)
library(gdata)
library(fda)
trainingData <- read.xls("BondRating.xls", sheet=1)
colnames(trainingData) = trainingData[1,]
trainingData = trainingData[-1,]
trainingData = trainingData[,-(1:2)] 
i <- c(1: 11)
trainingData[ , i] <- apply(trainingData[ , i], 2, function(x) as.numeric(as.character(x)))
validationData <- read.xls("BondRating.xls", sheet=2,)
colnames(validationData) = validationData[1,]
validationData = validationData[-1,]
validationData = validationData[,-(1:2)]
validationData[ , i] <- apply(validationData[ , i], 2, function(x) as.numeric(as.character(x)))
# a
plot(ds, pch = 16, col=ds$CODERTG)
trainingData.lda = lda(CODERTG ~ ., data = trainingData)
print(trainingData.lda)
print(trainingData.lda$scaling[order(trainingData.lda$scaling[, 1]), ])
print(trainingData.lda$scaling[order(trainingData.lda$scaling[, 2]), ])
par(mar=c(2,2,2,2))
trainingData.lda.predict = predict(trainingData.lda, newdata = trainingData)

ldahist(data = trainingData.lda.predict$x[,1], g = trainingData$CODERTG)
plot(trainingData.lda.predict$x[, 1], trainingData.lda.predict$x[, 2], col=trainingData$CODERTG, pch=16)
ldahist(data = trainingData.lda.predict$x[,2], g = trainingData$CODERTG)
plot(trainingData.lda.predict$x[, 3], trainingData.lda.predict$x[, 4], col=trainingData$CODERTG, pch=16)

# predict with test data
validationData.lda.predict = predict(trainingData.lda, newdata = validationData)
ldahist(data = validationData.lda.predict$x[,1], g = validationData$CODERTG)
table(validationData$CODERTG, validationData.lda.predict$class)
