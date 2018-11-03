function output_spline(A, N, x)
    output = input('Enter the address of the output file: ','s');
    fileid = fopen(output, 'w');
    fprintf(fileid, 'Spline coefficients:   a*x^3 + b*x^2 + c*x + d\r\n');
    fprintf(fileid, '\t\t\ta\t\t\tb\t\t\tc\t\t\td\r\n');
    for i=1:N
        fprintf(fileid, '(%d) %12.4f%12.4f%12.4f%12.4f\r\n', i-1, A(i, 1), A(i, 2), A(i, 3), A(i, 4));
    end
    
    fprintf(fileid, '\r\nFirst and second derivative at nodes:\r\n');
    u = zeros(N+1, 1);
    v = zeros(N+1, 1);
    x = x';
    
    u(1:N) = 3*A(:, 1).*(x(1:N).^2) + 2*A(:, 2).*x(1:N) + A(:, 3);
    v(1:N) = 6*A(:, 1).*x(1:N) + 2*A(:, 2);
    u(N+1) = 3*A(N, 1).*(x(N+1).^2) + 2*A(N, 2).*x(N+1) + A(N, 3);
    v(N+1) = 6*A(N, 1).*x(N+1) + 2*A(N, 2);
    
    fprintf(fileid, '\t\t\tf''\t\t\tf''''\r\n');
    for i=1:N+1
        fprintf(fileid, '(%d) %12.4f%12.4f\r\n', i-1, u(i), v(i));
    end
    fclose(fileid);
end
