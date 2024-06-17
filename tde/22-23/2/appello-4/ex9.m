clear; clc;

% Si consideri il seguente problema ai limiti:
% −2 u′′(x) + 400 u′(x) = 5       x ∈ (0, 1),
% u(0) = 0, u(1) = 4.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% tecnica Upwind e passo di discretizzazione h = 1/10, ottenendo la soluzione nu-
% merica {uj}N+1 j=0 nei corrispondenti nodi {xj}N+1 j=0 per (N + 1) = 10. Si risolva il
% problema e si utilizzi la soluzione così ottenuta per determinare l’approssimazione
% di u′(1) tramite le differenze finite all’indietro.

mu    = 2;
eta   = 400;
sigma = 0;
f     = @(x) 5;
a = 0; a_cond = "dirichlet"; alpha = 0;
b = 1; b_cond = "dirichlet"; beta = 4;

h = 1/10;

[x, u] = dtr_upwind(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

u_diff1 = (u(end) - u(end-1)) / h;

disp(u_diff1); % 37.9887