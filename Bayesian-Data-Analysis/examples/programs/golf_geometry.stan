data {
  int J;
  real r;
  real R;
  int n[J];
  vector[J] dist;
  int success[J];
}
parameters {
  real<lower=0> sigma;
}
model {
  vector[J] p;
  for (j in 1:J){
    p[j] = 2*Phi(asin((R-r) / dist[j]) / sigma) - 1;
  }
  success ~ binomial(n, p);
}

