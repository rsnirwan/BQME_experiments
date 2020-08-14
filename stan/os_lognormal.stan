data{
     int N;
     int M;
     vector[M] q;
     vector[M] X;
}
parameters{
    real mu;
    real<lower=0> sigma;
}
transformed parameters{
    vector[M] U;
    for (m in 1:M)
        U[m] = lognormal_cdf(X[m], mu, sigma);
}
model{
    mu ~ normal(0, 100);
    sigma ~ normal(0, 100);
    target += orderstatistics(N, M, q, U);
    for (m in 1:M)
        target += lognormal_lpdf(X[m] | mu, sigma);
}
generated quantities {
    real<lower=0> predictive_dist = lognormal_rng(mu, sigma);
    real log_prob = orderstatistics(N, M, q, U);
    for (m in 1:M)
        log_prob += lognormal_lpdf(X[m] | mu, sigma);
}
