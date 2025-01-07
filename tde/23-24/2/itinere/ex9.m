clear; clc;

syms alpha f;
mu = 1;
a  = 0;
b  = 1;

h = 1/3;

x = a:h:b;
N = length(x) - 2;

A = mu / h^2 .* mdiag([-1 2 -1], N);
f_v = f * ones(N, 1);

f_v(1) = f_v(1) + alpha * (mu/h^2);
% f_v(end) = f_v(end) + beta;

u = A \ f_v;