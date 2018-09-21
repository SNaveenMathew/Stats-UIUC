# Normal from double exponential

set.seed(1)
exp <- rexp(1000)
sample1 <- sample(x = 1:1000, size = 500, replace = F)
exp[sample1] <- -exp[sample1]

exp <- exp[runif(1000) < exp(-0.5*exp^2 + abs(exp) - 0.5)]
exp <- exp[exp!=0]
hist(exp)