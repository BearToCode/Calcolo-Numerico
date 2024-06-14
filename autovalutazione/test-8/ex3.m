clear; clc;

% Costante di Lebesgue, nodi di Chebyshev

n = 3;
a = 0;
b = 1;

nodes = chebyshev([a, b], n + 1);
disp(nodes)
lambda3 = lebesgue(nodes, linspace(a, b, 100));
disp(lambda3);