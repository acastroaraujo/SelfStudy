// This is completely unnecessary
data {
  int J;                 // # of schools
  real y[J];            // estimated effect
  real sigma[J]; // std. errors
}
parameters {
  real theta[J];     // school effect
}
model {
  y ~ normal(theta, sigma);
}
