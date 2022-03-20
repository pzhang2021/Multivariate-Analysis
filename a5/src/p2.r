library(corrplot)
library(CCA)

data = read.csv("data_marsh_cleaned.csv")
ccaWilks = function(set1, set2, cca)
{
  ev = ((1 - cca$cor^2))
  ev
  
  n = dim(set1)[1]
  p = length(set1)
  q = length(set2)
  k = min(p, q)
  m = n - 3/2 - (p + q)/2
  m
  
  w = rev(cumprod(rev(ev)))
  
  # initialize
  d1 = d2 = f = vector("numeric", k)
  
  for (i in 1:k) 
  {
    s = sqrt((p^2 * q^2 - 4)/(p^2 + q^2 - 5))
    si = 1/s
    d1[i] = p * q
    d2[i] = m * s - p * q/2 + 1
    r = (1 - w[i]^si)/w[i]^si
    f[i] = r * d2[i]/d1[i]
    p = p - 1
    q = q - 1
  }
  
  pv = pf(f, d1, d2, lower.tail = FALSE)
  dmat = cbind(WilksL = w, F = f, df1 = d1, df2 = d2, p = pv)
}

# p1
water = data[, 2:6]
soil = data[, 7:9]
ccSoil = cc(water, soil)

wilksSoil = ccaWilks(water, soil, ccSoil)
round(wilksSoil, 2)

# p2
loadingsSoil = comput(water, soil, ccSoil)
ls(loadingsSoil)
round(-loadingsSoil$corr.X.xscores, 2)
round(-loadingsSoil$corr.Y.yscores, 2)
