library(MASS)
# matrix prepare
Z = matrix(c(1,4,1,3,1,2,1,-5), nrow=4, ncol=2, byrow=T)
Y = matrix(c(2,1,-1,3), nrow=4, ncol=1, byrow=T)
M = matrix(c(20,5,0,5,25,-10,0,10,5), nrow=3, ncol=3, byrow=T)
N = matrix(c(-20,0,10,5,10,15,5,20,-5), nrow=3, ncol=3, byrow=T)
v = matrix(c(-1,1,3), nrow=3, ncol=1, byrow=T)
w = matrix(c(2,-1,1), nrow=3, ncol=1, byrow=T)
# a. v dot w
p1 = sum(v * w)
# b. -3 * w
p2 = -3 * w
# c. M * v
p3 = M %*% v
# d. M + N
p4 = M + N
# e. M - N
p5 = M - N
# f. Transpose of Z
p6 = t(Z)
# g. (Transpose of Z) * Z
p7 = p6 %*% Z