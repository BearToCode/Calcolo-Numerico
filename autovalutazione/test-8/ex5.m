clear; clc;

% Interpolante lineare a tratti

f = @(x) exp(x) * sin(pi * x);

n = 11;
nodes = linspace(-1, 1, n);

disp(linear_interpolation(f, nodes, 0.7));

x = linspace(-1, 1, 100);
y = arrayfun(f, x);
z = arrayfun(@(x) linear_interpolation(f, nodes, x), x);

plot(x, y, x, z, nodes, arrayfun(f, nodes), 'o');

function val = linear_interpolation(f, nodes, x)
val = 0;
for i = 1:length(nodes) - 1
    if nodes(i) <= x && x <= nodes(i + 1)
        val = f(nodes(i)) + (f(nodes(i + 1)) - f(nodes(i))) / (nodes(i + 1) - nodes(i)) * (x - nodes(i));
        break;
    end
end
end