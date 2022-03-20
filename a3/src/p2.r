library(MASS)
library(matlib)
# matrix prepare
M = matrix(c(5,-1,-1,5), nrow=2, ncol=2, byrow=F)
N = matrix(c(21,-3,3,-2,10,-22,1,-11,-1), nrow=3, ncol=3, byrow=F)
v = matrix(c(-1,1,-1), nrow=3, ncol=1, byrow=F)

# problem (a)
evM <- eigen(M)
evM$values

#problem (b)
evN <- eigen(N)
evN$values 