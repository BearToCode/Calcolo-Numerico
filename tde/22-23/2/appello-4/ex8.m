clear; clc;

% Si consideri il seguente problema ai limiti:
% −2 u′′(x) + 8 u′(x) + 4(4 − x) u(x) = 0               x ∈ (0, 4),
% u(0) = 3, u′(4) = 0.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% passo di discretizzazione h = 1/10 e il metodo delle differenze finite all’indietro (di
% ordine 1) per l’approssimazione di u′(4), ottenendo la soluzione numerica {uj}N+1 j=0
% nei corrispondenti nodi {xj}N+1 j=0 per (N + 1) = 40. Si risolva il problema e si
% riporti il valore della soluzione numerica u40, ovvero l’approssimazione di u(4).

mu    = 2;
eta   = 8;
sigma = @(x) 4 * (4 - x);
f     = @(x) 0;
a = 0; a_cond = "dirichlet"; alpha = 3;
b = 4; b_cond = "neumann"; beta = 0;

h = 1/10;

[x, u] = dtr(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

u40 = u(end);

disp(u40);