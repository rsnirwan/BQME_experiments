data{
     int N;
     int M;
     vector[M] q;
     vector[M] X;
}
parameters{
    real<lower=0> dof;
}
transformed parameters{
    vector[M] U;
    for (m in 1:M)
        U[m] = chi_square_cdf(X[m], dof);
}
model{
    dof ~ normal(0, 100);
    target += orderstatistics(N, M, q, U);
    for (m in 1:M)
        target += chi_square_lpdf(X[m] | dof);
}
generated quantities {
    real<lower=0> predictive_dist = chi_square_rng(dof);
    real log_prob = orderstatistics(N, M, q, U);
    for (m in 1:M)
        log_prob += chi_square_lpdf(X[m] | dof);
}
