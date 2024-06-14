clear; clc;

mu  = 1;
eta = -100;
a   = -1; alpha = 7;
b   = +1; beta  = 0;
f   = @(x) 0;

h = 0.2;

[x, u] = dtr_upwind(mu, eta, 0, f, a, b, "dirichlet", "dirichlet", alpha, beta, h);

disp(u);