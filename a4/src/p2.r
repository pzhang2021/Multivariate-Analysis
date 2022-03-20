library(corrplot)
library(psych)

data = read.csv("Survey.csv")
# p1 Compute the correlation matrix in three ways
c1 = cor(data, method = "pearson")
corrplot(c1)
c2 = cor(data, method = "spearman")
corrplot(c2)
c3 = cor(data, method = "kendall")
corrplot(c3)

# p2 Compute the KMO
KMO(data)

# p3  Use the Spearman correlation matrix to conduct a first PCA
pca.spearman = prcomp(c2)
summary(pca.spearman)
screeplot(pca.spearman, main="Spearman Scree Plot", type="lines")

# p4 Compute a principal factor analysis
pfa.spearman = principal(c2, nfactors = 3, rot = "none")
pfa.spearman

# p5 Print the loadings with a proper cutoff 
print(pfa.spearman$loadings, cutoff = 0.4)

# p6 Evaluate the goodness of fit with the Chi-square and the RMSEA
print(pfa.spearman) 

# p7 Repeat the analysis with the polychoric correlation
## Polychoric correlation
poly_cor = polychoric(data[1:11])
rho = poly_cor$rho
save(rho, file = "polychoric")
### Thresholds/Scaling results
poly_cor$tau
cor.plot(poly_cor$rho, numbers=T, upper=FALSE, main = "Polychoric Correlation", show.legend = FALSE)
load("polychoric")
# Scree plot
fa.parallel(rho, fm="pa", fa="fa", main = "Scree Plot")
