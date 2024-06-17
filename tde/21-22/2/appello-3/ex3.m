clear; clc;

% Si consideri la funzione f(x) = x^3 e il suo interpolante polinomiale a tratti di
% grado 2, ovvero ΠH2 f (x) su 4 sottointervalli equispaziati di [−1, 1] e con tutti i
% nodi equispaziati. Si riporti il valore ΠH2 f (0.75).

f = @(x) x.^3;
a = -1;
b = 1;
n = 2;

nodes = linspace(a, b, 4 + 1);

f_piecewise = poly_piecewise_interp(nodes, f, n, "equispaced");

val = f_piecewise(0.75);

disp(val); % 0.4219
