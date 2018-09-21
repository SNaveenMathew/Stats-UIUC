library(plyr)
library(ggplot2)
library(class)
set.seed(123)

# Create training and testing data sets
idx = sample(1:nrow(iris), size = 100)
train.idx = 1:nrow(iris) %in% idx
test.idx =  ! 1:nrow(iris) %in% idx

train = iris[train.idx, 1:4]
test = iris[test.idx, 1:4]

# Get labels
labels = iris[train.idx, 5]

# Do knn
fit = knn(train, test, labels)
fit

# Create a dataframe to simplify charting
prob <- attr(fit, "prob")
prob <- ifelse(fit=="1", prob, 1-prob)

px1 <- iris$Sepal.Length[order(iris$Sepal.Length)]
px2 <- iris$Sepal.Width[order(iris$Sepal.Length)]
prob15 <- matrix(prob, length(px1), length(px2))
par(mar=rep(2,4))
contour(x = px1, y = px2, z = prob15, levels=0.5, labels="", xlab="", ylab="", main=
          "3-nearest neighbour", axes=FALSE)
z <- matrix(px1, nrow=length(px1), ncol=length(px2))
persp(px1,px2,z, theta = 30, phi = 30, expand = 0.5, col = "lightblue")
points(x, col=ifelse(g==1, "coral", "cornflowerblue"))
gd <- expand.grid(x=px1, y=px2)
points(gd, pch=".", cex=1.2, col=ifelse(prob15>0.5, "coral", "cornflowerblue"))
box()