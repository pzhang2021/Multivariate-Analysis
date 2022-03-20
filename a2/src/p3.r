library(MASS)
library(matlib)
# Create a copy of the dataset called A with only the columns {cyl, disp, hp, wt, carb}
A = mtcars[,c("cyl", "disp", "hp", "wt", "carb")]

# Add a column of “ones” to A called “count”, convert it to a matrix and assign it back to the variable A
A <- as.matrix(cbind(A, count = 1))

# computing the matrix operations
Y = as.matrix(mtcars[,c("mpg")])
beta = solve(t(A) %*% A) %*% (t(A) %*% Y)
beta

# linear model result
fit = lm(Y ~ A)
summary(fit)