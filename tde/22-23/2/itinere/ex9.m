clear; clc;

% Si consideri il seguente problema ai limiti:
% −u′′(x) + 1000 u′(x) = 200        x ∈ (0, 1),
% u(0) = 5, u(1) = 0.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% tecnica Upwind e passo di discretizzazione h = 1/100, ottenendo la soluzione nu-
% merica {uj}N+1 j=0 nei corrispondenti nodi {xj}N+1 j=0 per (N + 1) = 100. Si risolva il
% problema e si riporti il valore della soluzione numerica u99, ovvero l’approssimazione
% di u(x99).

mu    = 1;
eta   = 1000;
sigma = 0;
f     = @(x) 200;
a = 0; a_cond = "dirichlet"; alpha = 5;
b = 1; b_cond = "dirichlet"; beta  = 0;

h = 1/100;

[x, u] = dtr_upwind(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

u99 = u(1 + 99);

disp(u99); % 4.7253