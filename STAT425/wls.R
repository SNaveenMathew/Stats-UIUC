library(faraway)

travel <- read.table("travel.dat", header = T)
head(travel)

model1 <- lm(y ~ x, data = travel, weights = n)
summary(model1)

travel1 <- travel[rep(rownames(travel), travel$n), ]
model2 <- lm(y ~ x, data = travel1)
summary(model2)
print(sum(travel$n))
print(nrow(travel1))