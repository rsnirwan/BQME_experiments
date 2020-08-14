data{
     int N;
     int M;
     vector[M] q;
     vector[M] X;
}
parameters{
    real<lower=0> rate;
}
transformed parameters{
    vector[M] U;
    for (m in 1:M)
        U[m] = exponential_cdf(X[m], rate);
}
model{
    rate ~ normal(0, 100);
    target += orderstatistics(N, M, q, U);
    for (m in 1:M)
        target += exponential_lpdf(X[m] | rate);
}
generated quantities {
    real<lower=0> predictive_dist = exponential_rng(rate);
    real log_prob = orderstatistics(N, M, q, U);
    for (m in 1:M)
        log_prob += exponential_lpdf(X[m] | rate);
}
