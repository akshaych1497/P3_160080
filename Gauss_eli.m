function X = Gauss_eli(A, b, N)
    X = zeros(N, 0);
    A_aug = [A b'];%b is transposed
    k = 2;
    while(k<=N)
        i = k;
        [~, idx] = max(abs(A_aug((k-1):N, k-1))); % max      |PIVOTING
        idx = idx+k-2;                 %                |
        temp = A_aug(idx, :);          %                |
        A_aug(idx, :) = A_aug(k-1, :); % row swap       |
        A_aug(k-1, :) = temp;          %                |
        while(i<=N)
            A_aug(i, :) = A_aug(i, :) - (A_aug(i, k-1)/A_aug(k-1, k-1))*A_aug(k-1, :);
            i = i+1;
        end
        k = k+1;
    end
    %BACKSUBSTITUTION
    i = N;
    while(i>=1)
        j = N;
        sum = 0;
        while(j>i)
            sum = sum + X(j)*A_aug(i, j);
            j = j-1;
        end
        X(i) = (A_aug(i,N+1)-sum)/A_aug(i, i);
        i = i-1;
    end
end