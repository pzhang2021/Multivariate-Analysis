library(MASS)
library(cluster)
library(factoextra)
# p1 read file
data = read.table("kellog.dat", skip=2, row.names=1)
head(data)

# p2 compute distance
kellog.x = as.matrix(data)
kellog.dist = dist(kellog.x)
kellog.dist

# p3 multidimensional scaling
kellog.mds = isoMDS(kellog.dist)
kellog.mds$stress

# p3 plot
plot(kellog.mds$points, type = "n")
text(kellog.mds$points, labels = as.character(1:nrow(kellog.x)))

# p5 Agglomerative Hierarchical Clustering
# Hierarchical clustering using Complete Linkage
hc1 <- hclust(kellog.dist, method = "complete" )
# Plot the obtained dendrogram
plot(hc1, cex = 0.6, hang = -1)

# p6 Agglomerative Hierarchical Clustering
clust1 <- cutree(hc1, k = 3)
fviz_cluster(list(data = data, cluster = clust1))

# p6  Divisive Hierarchical Clustering
hc2 <- diana(data)
clust2 <- cutree(hc2, k = 3)
fviz_cluster(list(data = data, cluster = clust2))
