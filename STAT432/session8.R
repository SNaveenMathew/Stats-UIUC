data("iris")


pca_model <- princomp(x = iris[, 1:4])
plot(pca_model)

pc_projected <- predict(pca_model, iris[, 1:4])
pairs(pc_projected, col = iris$Species, pch = 19)

summary(pca_model)
# 2 components can explain 97.76% of the variance