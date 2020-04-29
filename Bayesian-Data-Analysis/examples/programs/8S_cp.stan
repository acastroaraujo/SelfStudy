data {
  int J;                       // 8 schools
  real y[J];                  // estimated treatment effect
  real<lower=0> sigma[J];    // std. error of effect
}
parameters {
  real theta[J];          // school effect
  real mu;               // mean for schools
  real<lower=0> tau;    // variance between schools
}
model {
  theta ~ normal(mu, tau);
  y ~ normal(theta, sigma);
}
