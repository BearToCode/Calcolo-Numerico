clc; clear;

nodes = linspace(-2, 2, 6);

f = @(x) 1 - exp(sin(x));

values = arrayfun(f, nodes);

lagrange_interpolation_sym = lagint(nodes, values);
lagrange_interpolation = matlabFunction(lagrange_interpolation_sym);

error = @(x) abs(f(x) - lagrange_interpolation(x));

x = linspace(-2, 2, 1000);

plot(x, error(x));

[err_max, idx] = max(error(x));
x_max = x(idx);

fprintf('Massimo errore: %f\n', err_max);
fprintf('In corrispondenza di x = %f\n', x_max);