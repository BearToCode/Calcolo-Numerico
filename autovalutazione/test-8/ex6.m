clear; clc;

a = 0;
b = 2 * pi;

f = @(x) x / pi * (x < pi) + (2 - x / pi)^2 * (x >= pi);

n = 4;

nodes = linspace(a, b, n+1 +1);
nodes = nodes(1:end-1); % Remove last element, as it is periodic

ft = dft(nodes, arrayfun(f, nodes));

fplot(ft, [a, b]);

hold on;
x = linspace(a, b, 100);
y = arrayfun(f, x);
plot(x, y);
plot(nodes, arrayfun(f, nodes), 'o');
hold off;