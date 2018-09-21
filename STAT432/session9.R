library(ElemStatLearn)
data("zip.train")
zip.sub = zip.train[zip.train[,1] %in% c(1,4,8), -1]
zip.sub = zip.sub - matrix(colMeans(zip.sub), nrow = nrow(zip.sub),
                           ncol = ncol(zip.sub), byrow = T)
zip.sub.truth = as.factor(zip.train[zip.train[,1] %in% c(1,4,8), 1])
dim(zip.sub)
zip_pc = prcomp(zip.sub)
plot(zip_pc, type = "l", pch = 19, main = "Digits 1, 4, and 8 PCA eigen-values")
zip_pc$sdev^2
summary(zip_pc$sdev)

v <- zip_pc$rotation

zip.sub %*% v
# Scaling depends on type of data