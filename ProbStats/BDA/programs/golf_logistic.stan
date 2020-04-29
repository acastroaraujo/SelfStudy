data {
  int J;
  int n[J];         // note the that location of the [J]
  vector[J] dist;   // is different for "int" and "vector"
  int success[J];
}
parameters {
  real a;
  real b;
}
model {
  success ~ binomial_logit(n, a + b*dist);
}

