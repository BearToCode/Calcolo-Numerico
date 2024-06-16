clear; clc;

% Si consideri il seguente problema ai limiti:
% −u′′(x) + (1 + 19 x) u(x) = 5      x ∈ (0, 1),
% u′(0) = u′(1) = 0.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% passo di discretizzazione h = 1/10 e il metodo delle differenze finite in avanti
% e all’indietro (di ordine 1) per l’approssimazione di u′(0) e u′(1), ottenendo la
% soluzione numerica {uj }N +1
% j=0 nei corrispondenti nodi {xj }N +1
% j=0 per (N + 1) = 10.
% Si risolva il problema e si riporti il valore della soluzione numerica u5, ovvero
% l’approssimazione di u(0.5).

mu    = -1;
eta   = 0;
sigma = @(x) 1 + 19*x;
f     = @(x) 5;
a = 0; a_cond = "neumann"; alpha = 0;
b = 1; b_cond = "neumann"; beta  = 0;

h = 1/10;

[x, u] = dtr(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

disp(u(1 + 5)); % 0.5195