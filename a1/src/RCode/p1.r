library(psych)
data = read.csv("olympics.csv")
str(data)
data$GDP.per.capita <- (data$X2011.GDP/data$X2010.population)
data$Total.medals <- (data$Gold.medals+data$Silver.medals+data$Bronze.medals)
# Check correlations for a data matrix
pairs.panels(data[,-c(1,2)]) # country code and name is not necessary
data$GDP.per.participants <- (data$X2011.GDP/(data$Male.count+data$Female.count))
attach(data)
fit = lm(Total.medals ~ Female.count + Male.count + X2011.GDP)
summary(fit)
library(car)
vif(fit)

data$Total.participants <-(data$Male.count+data$Female.count)
pairs.panels(data[,-c(1,2)])
attach(data)
fit2 = lm(Total.medals ~ Total.participants + X2011.GDP)
summary(fit2)
vif(fit2)

finalModel = data[-c(2, 9), -c(1,2)]
attach(finalModel)
fit3 = lm(Total.medals ~ Total.participants + X2011.GDP)
summary(fit3)
vif(fit3)
