% (N+1) points, N splines
function Clamped_spl(x, f, n, d0, dn)
    h = x(2:n+1)-x(1:n); %1-N
    t = ( f(2:n+1)-f(1:n) )./h; %1-N+1     DD
    m = [0, 2*( h(1:n-1)+h(2:n) ), 0]; % 1- N+1
    u = [0, 6*( t(2:n)-t(1:n-1) ), 0]; % 1 - (N+1)
    
    
    m(1) = 2*h(1);
    m(n+1) = 2*h(n);
    u(1) = 6*(t(1) - d0);
    u(n+1) = 6*(dn - t(n));
    
    v = Thomas([0, h(1:n)], m(1:n+1), [h(1:n), 0], u(1:n+1), n+1);
    
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