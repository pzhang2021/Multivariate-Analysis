library(dplyr)
library(car)
library(corrplot)
library(ggplot2)
library(psych)

data = read.csv("Census2.csv")
# (a)
p = prcomp(data)
summary(p)
print(p$rotation)
# (b)
newData = data %>% mutate(MedianHomeVal = MedianHomeVal/100000)
p2 = prcomp(newData)
summary(p2)
print(p2$rotation)
# (c)
head(newData)
# (d)
p3 = prcomp(newData, scale. = TRUE)
biplot(p2)
biplot(p3)
summary(p3)
# (e)
corrTest = corr.test(newData, adjust="none")
x = corrTest$p
xTest = ifelse(x < 0.05, T, F)
