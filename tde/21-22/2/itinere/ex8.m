clear; clc;

% Si consideri il seguente problema ai limiti:
% −u′′(x) + 2 u(x) = 3 + x                      x ∈ (0, 1),
% u(0) = 1, u′(1) = 0.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% passo di discretizzazione h = 1/10 e il metodo delle differenze finite all’indietro (di
% ordine 1) per l’approssimazione di u′(1), ottenendo la soluzione numerica {uj }N +1
% j=0 nei corrispondenti nodi {xj}N+1 j=0 per (N + 1) = 10. Si risolva il problema e si
% riporti il valore della soluzione numerica u10, ovvero l’approssimazione di u(1)

mu    = 1;
eta   = 0;
sigma = 2;
f     = @(x) 3+x;
a = 0; a_cond = "dirichlet"; alpha = 1;
b = 1; b_cond = "neumann";   beta = 0;

h = 1/10;

[x, u] = dtr(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

u10 = u(end);

disp(u10); % 1.4207
