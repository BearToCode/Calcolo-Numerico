clear; clc;

n = 149;
m = 2;

x = linspace(0, 1, 150);
rng(1);
y = (3 * x .^ 2 + 0.3 * sin(100 * pi * x) + 0.3 * randn(1, 150))';

poly = regression(x, y, m);

plot(x, y, x, polyval(poly, x));

val = polyval(poly, 1.5);

disp(val);