library(dplyr)
library(car)
library(corrplot)
library(ggplot2)
library(psych)

PCA_Plot_Psyc = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = as.data.frame(unclass(pcaData$loadings))
  s = rep(0, ncol(loadings))
  for (i in 1:ncol(loadings))
  {
    s[i] = 0
    for (j in 1:nrow(loadings))
      s[i] = s[i] + loadings[j, i]^2
    s[i] = sqrt(s[i])
  }
  
  for (i in 1:ncol(loadings))
    loadings[, i] = loadings[, i] / s[i]
  
  loadings$.names = row.names(loadings)
  
  p + geom_text(data=loadings, mapping=aes(x = RC1, y = RC2, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC1", y = "PC2")
}

data = read.csv("wiscsem.csv")
# (b)
p = prcomp(data, scale. = TRUE)
summary(p)
plot(p)
abline(h=1, col="red", lty= 1)
# (c)
pfa = principal(data, nfactors = 3, rot = "varimax")
print(pfa$loadings, cutoff = 0.4)
PCA_Plot_Psyc(pfa)
# (e)
fact = factanal(data, 3)
print(fact$loadings, cutoff=.4, sort=T)