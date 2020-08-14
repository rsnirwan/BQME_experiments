data{
     int N;
     int M;
     vector[M] q;
     vector[M] X;
}
parameters{
    real<lower=0> shape;
    real<lower=0> scale;
}
transformed parameters{
    vector[M] U;
    for (m in 1:M)
        U[m] = frechet_cdf(X[m], shape, scale);
}
model{
    shape ~ normal(0, 100);
    scale ~ normal(0, 100);
    target += orderstatistics(N, M, q, U);
    for (m in 1:M)
        target += frechet_lpdf(X[m] | shape, scale);
}
generated quantities {
    real<lower=0> predictive_dist = frechet_rng(shape, scale);
    real log_prob = orderstatistics(N, M, q, U);
    for (m in 1:M)
        log_prob += frechet_lpdf(X[m] | shape, scale);
}
