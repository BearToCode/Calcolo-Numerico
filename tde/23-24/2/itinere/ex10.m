clear; clc;


mu    = 1;
eta   = 30;
sigma = 0;
f     = @(x) 3;

local_peclet = @(h) (abs(eta) * h) / (2 * mu);

h = 1/10;
mu_h = 1 * (local_peclet(h) + (2 * local_peclet(h)) / (exp(2*local_peclet(h)) - 1));

a = 0; a_cond = "dirichlet"; alpha = 0;
b = 1; b_cond = "dirichlet"; beta  = 1;

[x, u] = dtr_upwind(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

u9 = u(1+9);

disp(u9);

%% DA CORREGGERE!!!