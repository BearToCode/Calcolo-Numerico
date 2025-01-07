clear; clc;

mu    = 1;
eta   = -2;
sigma = 1;
f     = @(x) 2 * (sin(x) + cos(x));
a = 0; a_cond = "dirichlet"; alpha = 1;
b = 1; b_cond = "neumann";   beta  = -sin(1);

h = 1/50;

[x, u] = dtr(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

e_exact = @(x) cos(x);

% Calcolo errore

e = arrayfun(e_exact, x) - u';

disp(max(abs(e)));