clear; clc;

% Si consideri la funzione f(x) = sin(πx) e il suo interpolante polinomiale Π3f (x)
% su nodi equispaziati in [−1, 1]. Senza costruire esplicitamente Π3f (x), si fornisca
% la stima dell’errore di interpolazione e3_approx(f).

syms x;
f = sin(pi*x);
n = 3;
nodes = linspace(-1, 1, n+1);
err_approx = approx_interp_err_equispaced(f, x, nodes);

disp(err_approx);
