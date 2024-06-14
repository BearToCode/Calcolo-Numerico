clear; clc;

% Si consideri il seguente problema ai limiti con condizioni di Neumann:
% −u′′(x) + u = 1 x ∈ (0, 1),
% u′(0) = 0, u′(1) = 1.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% passo di discretizzazione h = 1/10 e il metodo delle differenze finite in avanti e
% all’indietro (di ordine 1) per l’approssimazione, rispettivamente, di u′(0) e u′(1),
% ottenendo la soluzione numerica {uj}N+1 j=0 nei corrispondenti nodi {xj}N+1 j=0 per
% (N + 1) = 10. Si risolva il problema e si riporti il valore della soluzione numerica
% u10, ovvero l’approssimazione di u(1).

mu    = 1;
eta   = 0;
sigma = 1;
f     = @(x) 1;
a = 0; a_cond = "neumann"; alpha = 0;
b = 1; b_cond = "neumann"; beta  = 1;

h = 1/10;

[~, u] = dtr(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);

disp(u(end)); % 2.4482
