data {
  int J;                       // number of schools
  real y[J];                  // estimated treatment effect
  real<lower=0> sigma[J];    // std. error of effect
}
parameters {
  real mu;               // population treatment effect
  real<lower=0> tau;    // standard deviation in treatment effects
  real eta[J];     // unscaled deviation from mu by school
}
transformed parameters {
  real theta[J];
  for (j in 1:J) {
    theta[j] = mu + tau * eta[j];
  }
}
model {
  eta ~ normal(0, 1);
  y ~ normal(theta, sigma);
}
generated quantities {
  vector[J] y_rep;
  for (j in 1:J) {
    y_rep[j] = normal_rng(theta[j], sigma[j]);
  }
}
