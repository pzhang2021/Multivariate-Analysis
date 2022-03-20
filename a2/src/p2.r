library(MASS)
library(matlib)
# matrix prepare
Z = matrix(c(1,1,1,1,2,-3,4,-1), nrow=4, ncol=2, byrow=F)
Y = matrix(c(0,1,4,-3), nrow=4, ncol=1, byrow=F)

# Z transpose
p1 = t(Z)
p1

# (Transpose of Z) * Z
p2 = p1 %*% Z
p2

# inverse of ((Transpose of Z) * Z)
p3 = solve(p2)
p3

# (Transpose of Z) * Y
p4 = p1 %*% Y
p4

# c * d
p5 = p3 %*% p4
p5

# determinant of (Transpose of Z) * Z
p6 = det(p2)
p6

# linear model
fit = lm(Y ~ Z)
summary(fit)