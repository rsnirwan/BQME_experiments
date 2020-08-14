data {
    int M;
    vector[M] q;
    vector[M] X;
}
parameters {
    real mu;
    real<lower=0> sigma;
    real<lower=0> sigma_noise;
}
model {
    mu ~ normal(0,100);
    sigma ~ normal(0,100);
    sigma_noise ~ normal(0,0.02);
    for (m in 1:M) {
        real tmp = normal_cdf(X[m], mu, sigma);
        q[m] ~ normal(tmp, sigma_noise);
    }
}
