clear; clc;

mu    = 2;
f     = @(x) 10 * x^2;
a     = 0;
b     = 1;
alpha = 0;
beta  = 4;
h     = 0.1;

[x, u] = dtr(mu, 0, 0, f, a, b, "dirichlet", "dirichlet", alpha, beta, h);

disp(u);