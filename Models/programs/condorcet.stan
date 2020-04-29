data {
  int N;
  int odd_vector[N];
  real beta_params[2];
}
generated quantities {
  matrix[4000, N] S;   // 4,000 simulations for each jury size
  for (i in 1:4000) {
    for (j in 1:N) {
      real p[odd_vector[j]];
      real verdict[odd_vector[j]];
      for (k in 1:odd_vector[j]) {
        p[k] = beta_rng(beta_params[1], beta_params[2]);
        verdict[k] = bernoulli_rng(p[k]);
      }
      S[i, j] = mean(verdict);
    }
  }
}
