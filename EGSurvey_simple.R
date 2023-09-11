model {
  # Prior for the common shape parameter
  shape ~ dgamma(0.001, 0.001)
  
  # Priors for group means
  mu_pre ~ dgamma(0.001, 0.001)
  mu_post ~ dgamma(0.001, 0.001)
  
  # Likelihood
  for (i in 1:N) {
    mean[i] <- ifelse(time[i] == 1, mu_pre, mu_post)
    density[i] ~ dgamma(shape, rate = 1 / mean[i])
  }
  
  # Posterior summaries
  delta <- mu_post - mu_pre
}

# Define data
list(N = nrow(data), density = data$density, time = as.numeric(factor(data$time, levels = c("pre", "post"))))
