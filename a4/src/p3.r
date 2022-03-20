library(ca)
data = read.csv("StoresAndAges.csv")

# p1 Create a mosaic plot of the two categorical variables.
store = data[,-1]
rownames(store) = data[,1]

mosaicplot(store, shade = T, main = "")

# p2 Plot the results of the correspondence analysis.
fit = ca(store)
fit
plot(fit)

# p5
c = ca(store)
summary(c)
