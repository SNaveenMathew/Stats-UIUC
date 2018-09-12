t1_Feature_bars <- c(2, 5, 11)
t1 <- c(9, 11, 15)

I <- length(t1_Feature_bars) # Total number of feature bars
t1_max <- max(t1) # Total number of bars - time part for calculating labels

ind_mat <- matrix(data = 0, nrow = t1_max, ncol = I)

for(i in 1:I) {
  ind_mat[(t1_Feature_bars[i]+1):t1[i], i] <- 1 # It's too late when we are at t1_Feature_bars[i]
}

# 2nd label has overlap with 1st label. But 3rd label has no overlap

c_t <- rowSums(ind_mat)

u_ti <- ind_mat/c_t

u_ti[is.na(u_ti)] <- 0

# u_bar_i <- colMeans(u_ti)

