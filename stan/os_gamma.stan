data{
     int N;
     int M;
     vector[M] q;
     vector[M] X;
}
parameters{
    real<lower=0> shape;
    real<lower=0> rate;
}
transformed parameters{
    vector[M] U;
    for (m in 1:M)
        U[m] = gamma_cdf(X[m], shape, rate);
}
model{
    shape ~ normal(0, 100);
    rate ~ normal(0, 100);
    target += orderstatistics(N, M, q, U);
    for (m in 1:M)
        target += gamma_lpdf(X[m] | shape, rate);
}
generated quantities {
    real<lower=0> predictive_dist = gamma_rng(shape, rate);
    real log_prob = orderstatistics(N, M, q, U);
    for (m in 1:M)
        log_prob += gamma_lpdf(X[m] | shape, rate);
}
