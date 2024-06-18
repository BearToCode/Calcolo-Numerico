clear; clc;

% Si consideri il seguente problema ai limiti:
% −u′′(x) − 50 u′(x) = 0                         x ∈ (0, 1),
% u(0) = 0, u(1) = 3.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% tecnica Upwind e passo di discretizzazione h = 1/10, ottenendo la soluzione nu-
% merica {uj}N+1 j=0 nei corrispondenti nodi {xj}N +1 j=0 per (N + 1) = 10. Si risolva il
% problema e si riporti il valore della soluzione numerica u1, ovvero l’approssimazione
% di u(x1).

mu    = 1;
eta   = -50;
sigma = 0;
f     = @(x) 0;
a = 0; a_cond = "dirichlet"; alpha = 0;
b = 1; b_cond = "dirichlet"; beta = 3;

h = 1/10;

[x, u] = dtr_upwind(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

u1 = u(1+1);

disp(u1); % 2.5