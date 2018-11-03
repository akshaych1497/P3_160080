function plot_spline(x, f, A, N)
    plot(x, f, '.', 'MarkerSize', 10, 'MarkerEdgeColor', 'red', 'LineWidth', 1.5);
    grid;
    for i=1:N
        X = linspace(x(i), x(i+1), 50);
        F = A(i, 1)*X.^3+A(i, 2)*X.^2+A(i, 3)*X+A(i, 4);
        hold on;
        plot(X, F, 'b')
    end    
end
