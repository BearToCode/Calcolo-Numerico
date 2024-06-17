clear; clc;

% Si consideri la funzione f (x) = exp(2(1−x)) e il suo interpolante polinomiale Π6f (x)
% su n + 1 = 7 nodi equispaziati in [0, 2]. Senza costruire l’interpolante Π6f (x), si
% fornisca una stima dell’errore di interpolazione e6(f) = max x∈[0,2] |f (x) − Π6f (x)|.

syms x;
f(x) = exp(2 * (1 - x));
n = 6;

a = 0;
b = 2;

nodes = linspace(a, b, n + 1);

err = approx_interp_err_equispaced(f, x, nodes);

disp(err) % 0.0154
