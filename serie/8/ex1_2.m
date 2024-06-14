clear; clc;

% Problema diffusione-reazione

a     = 0;
b     = 1;
alpha = 1;
beta  = exp(3);
mu    = 1;
sigma = @(x) 1 + sin(2*pi*x);
fun   = @(x) exp(3*x) * (sin(2*pi*x) - 8);

u_exact = @(x) exp(3*x);

N = 20 - 1;
h = (b - a) / (N + 1);

[x, u, A, f] = dtr(mu, 0, sigma, fun, a, b, 'dirichlet', 'dirichlet', alpha, beta, h);

disp("A: ");
disp(full(A));

disp("f: ");
disp(f);

% Plot

figure;
plot(x, u, 'o-', x, arrayfun(u_exact, x), 'r');
legend('u', 'u_{exact}');
title('Diffusione-reazione');
xlabel('x');
ylabel('u');
grid on;