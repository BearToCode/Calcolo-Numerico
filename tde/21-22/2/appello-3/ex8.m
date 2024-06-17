clear; clc;

% Si consideri il seguente problema ai limiti:
% −u′′(x) + 3u(x) = −3x^2 (4 − x^2)     x ∈ (0, 1),
% u(0) = 0, u(1) = 1.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% passo di discretizzazione h = 1/10 ottenendo la soluzione numerica {uj}N+1 j=0 nei
% corrispondenti nodi {xj}N+1 j=0 per (N + 1) = 10. Si risolva il problema e, sapendo
% che la soluzione esatta è u(x) = x^4, si riporti il valore dell’errore corrispondente
% Eh = max j=0,...,N+1 |u(xj) − uj|.

mu    = 1;
eta   = 0;
sigma = 3;
f     = @(x) -3 * x.^2 .* (4 - x.^2);
a = 0; a_cond = "dirichlet"; alpha = 0;
b = 1; b_cond = "dirichlet"; beta  = 1;

h = 1/10;

[x, u] = dtr(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

u_exact = x.^4;
E = max(abs(u_exact - u'));

disp(E); % 0.0019