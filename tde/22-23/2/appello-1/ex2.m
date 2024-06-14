clear; clc;

% Si consideri la funzione f(x) = 4x^4 − 4 e il suo interpolante polinomiale a tratti
% di grado 2, ovvero ΠH_2 f(x) su 4 sottointervalli equispaziati di [−1, 1] e con tutti i
% nodi equispaziati. Si riporti il valore ΠH_2 f(−0.75).

f = @(x) 4 * x.^4 - 4;
n = 2;
nodes = linspace(-1, 1, 5);

f_interp = poly_piecewise_interp(nodes, f, n, "equispaced");
result = f_interp(-0.75);

disp(result); % -2.7344