% (N+1) points, N splines
function NKnot_spl(x, f, n)
    h = x(2:n+1)-x(1:n); %1-N
    t = ( f(2:n+ 1)-f(1:n) )./h; %1-N+1     DD
    m = [0, 2*( h(1:n-1)+h(2:n) )]; % 1- N+1
    u = [0, 6*( t(2:n)-t(1:n-1) ), 0]; % 1 - (N+1)
    
    
    A = diag([0, m(2:n), 0]);
    for i = 2:n-1
        A(i, i+1) = h(i);
        A(i+1, i) = h(i);
    end
    A(2, 1) = h(1);
    A(n, end) = h(n);
    A(1, 1:3) = [-h(2), (h(1)+h(2)), -h(1)];
    A(end, n-1:n+1) = [-h(n), (h(n-1)+h(n)), -h(n-1)];
    v = Gauss_eli(A, u, n+1);
    
    a = zeros(n, 1);
    b = zeros(n, 1);
    c = zeros(n, 1);
    d = zeros(n, 1);
    for i = 1:n
        a(i) = (v(i+1)-v(i))/(6*h(i));
        b(i) = (x(i+1)*v(i)-x(i)*v(i+1))/(2*h(i));
        c(i) = (v(i+1)*x(i)^2-v(i)*x(i+1)^2)/(2*h(i)) + t(i) - (v(i+1)-v(i))*h(i)/6;
        d(i) = (x(i+1)*f(i)-x(i)*f(i+1))/h(i) + (x(i)*v(i+1)-x(i+1)*v(i))*h(i)/6 + (v(i)*x(i+1)^3-v(i+1)*x(i)^3)/(6*h(i));  
    end
    
      
    coeff = [a b c d];
    output_spline(coeff, n, x)
    plot_spline(x, f, coeff, n);
end