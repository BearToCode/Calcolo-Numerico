clear; clc;

mu    = 1;
sigma = pi^2;
f     = @(x) pi^2 * (x + 2 * sin(pi * x));
a     = 0; zeta  = 1 + pi;
b     = 1; gamma = 1 - pi;
h     = 0.1;

[x, u] = dtr(mu, 0, sigma, f, a, b, "neumann_centered", "neumann_centered", zeta, gamma, h);

disp(u);