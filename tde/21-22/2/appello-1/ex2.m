clear; clc;

% Si consideri la funzione f (x) = e^3x e il suo interpolante polinomiale I3f (x) su nodi
% di Chebyshev-Gauss-Lobatto in [−1, 1]. Senza costruire esplicitamente I3f (x), si
% fornisca la stima dell’errore di interpolazione ˜e3(f ).

syms x;
f = exp(3*x);
nodes = chebyshev([-1 1], 3+1);

err = approx_interp_err(f, x, nodes);

% err =
%    16.9471
