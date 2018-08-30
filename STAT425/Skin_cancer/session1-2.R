setwd("C:/Users/Naveen/Desktop/Stats-UIUC/STAT425/Skin_cancer/")

skin <- read.table(file = "Skin.dat")
summary(skin)
str(skin)

model <- lm(mortality ~ latitude, data = skin)
summary(model)
# R^2 = 0.6798

skin$ocean <- as.factor(skin$ocean)
model2 <- lm(mortality ~ ocean, data = skin)
summary(model2)
# R^2 = 0.2241

model3 <- lm(mortality ~ ., data = skin)
summary(model3)
# R^2 = 0.7696
# Multiple R^2 here is not simple sum of previous 2 R^2 values because ocean and latitude are correlated
model3 <- lm(latitude ~ ocean, data = skin)
plot(x = as.integer(as.character(skin$ocean)), y = skin$latitude)
abline(model3)

# Computing var(y) where y = a^T * x, cov(x) = ((9, 2, -3), (4, 2, -3), (-3, -2, 16))
c(2, -3, -1) %*% matrix(c(9, 2, -3, 2, 4, -2, -3, -2, 16), nrow = 3, ncol = 3, byrow = T) %*% c(2, -3, -1)
