functions{
    real orderstatistics(int N, int M, vector q, vector U){
        real lpdf = 0;
        lpdf += lgamma(N+1) - lgamma(N*q[1]) - lgamma(N-N*q[M]+1);
        lpdf += (N*q[1]-1)*log(U[1]);
        lpdf += (N-N*q[M])*log(1-U[M]);
        for (m in 2:M){
            lpdf += -lgamma(N*q[m]-N*q[m-1]);
            lpdf += (N*q[m]-N*q[m-1]-1)*log(U[m]-U[m-1]);
        }
        return lpdf;
    }
}
