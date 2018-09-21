library(faraway)
data("savings")
mod <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data=savings)

par(mfrow = c(2, 2))

plot(mod)
rstandard(mod)
rstudent(mod)
hatvalues(mod)
cooks.distance(mod)
