% (N+1) points, N splines
function Periodic_spl(in_data, out_data, n)
    h = in_data(2:n+1)-in_data(1:n); %1-N
    t = ( out_data(2:n+ 1)-out_data(1:n) )./h; %1-N+1     DD
    m = [0, 2*( h(1:n-1)+h(2:n) )]; % 1- N+1
    u = [0, 6*( t(2:n)-t(1:n-1) ), 0]; % 1 - (N+1)
    
    v = zeros(n+1, 1); %1-N+1
    A = diag(m(2:n));
    for i = 2:n-1
        A(i-1, i) = h(i);
        A(i, i-1) = h(i);
    end
    A(1, end) = h(1);
    A(end, 1) = h(n);
    v(2:n) = Gauss_eli(A, u(2:n), n-1);
    v(1) = v(n);
    v(n+1) = v(2);
    
    a = zeros(n, 1);
    b = zeros(n, 1);
    c = zeros(n, 1);
    d = zeros(n, 1);
    for i = 1:n
        a(i) = (v(i+1)-v(i))/(6*h(i));
        b(i) = (in_data(i+1)*v(i)-in_data(i)*v(i+1))/(2*h(i));
        c(i) = (v(i+1)*in_data(i)^2-v(i)*in_data(i+1)^2)/(2*h(i)) + t(i) - (v(i+1)-v(i))*h(i)/6;
        d(i) = (in_data(i+1)*out_data(i)-in_data(i)*out_data(i+1))/h(i) + (in_data(i)*v(i+1)-in_data(i+1)*v(i))*h(i)/6 + (v(i)*in_data(i+1)^3-v(i+1)*in_data(i)^3)/(6*h(i));  
    end
    
    coeff = [a b c d];
    output_spline(coeff, n, in_data)
    plot_spline(in_data, out_data, coeff, n);
end