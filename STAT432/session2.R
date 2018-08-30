## Creating a data frame with 2 dimensional 'x' and binary 'y'
x <- 1:4
matrix(data = x, nrow = 2, ncol = 2, byrow = F)
matrix(data = x, nrow = 3, ncol = 2, byrow = F)
matrix(data = x, nrow = 3, ncol = 2, byrow = T)
y <- c(1,2)
y <- as.factor(x = rep(x = y, 2))
levels(y)
levels(y) <- c("lab1", "lab2")
y
z = data.frame("num" = x, "fac" = y)
class(z)


## Random number generation
rnorm(n = 10) # may give different set of 10 numbers every time

set.seed(1)
rnorm(n = 10) # this will generate same set of 10 numbers every time
rnorm(n = 10)

set.seed(1)
rnorm(n = 10) # same as first set
rnorm(n = 10) # same as second set

## Data reading and summarization
head(x = iris, n = 5)
summary(iris)
class(iris$Species)

## Plotting for exploration
plot(x = iris$Sepal.Length, y = iris$Sepal.Width, type = 'p', pch = 19, col = 'red')
plot(x = iris$Sepal.Length, y = iris$Sepal.Width, type = 'p', pch = 19, col = iris$Species)
plot(x = iris$Sepal.Length, y = iris$Sepal.Width, type = 'p', pch = 19, col = c("red", "orange", "green")[iris$Species])

# Univariate
hist(x = iris$Sepal.Length)
# One variable on outcome
boxplot(formula = Sepal.Length ~ Species, data = iris, col = c("blue", "orange", "green"))

pairs(iris[, 1:4], pch = 19, cex = 0.75, lower.panel = NULL, col = c("red", "blue", "green")[iris$Species])

## Summarization
aggregate(x = iris[, 1:4], by = list(iris$Species), FUN = mean)
aggregate(x = iris[, 1:4], by = list(iris$Species), FUN = sd)
aggregate(x = iris[, 1:4], by = list(iris$Species), FUN = median)

## Multivariate normal
library(MASS)
MASS::mvrnorm(n = 100, mu = rep(0, 4), Sigma = 0.5^abs(outer(X = 1:4, Y = 1:4, FUN = "-")))

## 3d plotting
library(scatterplot3d)
scatterplot3d::scatterplot3d(x = iris[, 1:3], pch = 19, col = c("red", "orange", "green")[iris$Species]) # Need to correct this

## Fitting a linear model
model <- lm(formula = Sepal.Length ~ Sepal.Width, data = iris)
summary(model)
model$fitted.values
model$residuals
str(model)
