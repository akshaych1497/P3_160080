% N - number of unknowns
function X = Thomas(l, d, u, b, N)
    alpha = zeros(N, 0);
    beta = zeros(N, 0);
    X = zeros(N, 0);
    i = 2;
    alpha(1) = d(1);
    beta(1) = b(1);
    while(i<=N)
        alpha(i) = d(i) - l(i)*u(i-1)/alpha(i-1);
        beta(i) = b(i) - l(i)*beta(i-1)/alpha(i-1);
        i = i+1;
    end
    X(N) = beta(N)/alpha(N);
    i = i-2;
    while(i>=1)
       X(i) = ( beta(i)-u(i)*X(i+1) )/alpha(i);
       i = i-1;
    end
end