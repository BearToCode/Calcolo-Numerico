% Si consideri il seguente problema ai limiti:
% −u'(x) + 3 u(x) = 10 sin(πx) x ∈ (0, 1),
% u(0) = 1, u(1) = 0.
% Si approssimi il problema utilizzando il metodo delle differenze finite centrate con
% passo di discretizzazione h = 1/10 ottenendo la soluzione numerica {uj }N +1
% j=0 nei
% corrispondenti nodi {xj }N +1
% j=0 per (N + 1) = 10. Si risolva il problema e si riporti
% il valore della soluzione numerica u2, ovvero l’approssimazione di u(x2).

mu    = 1;
eta   = 0;
sigma = 3;
f     = @(x) 10 * sin(pi * x);
a     = 0;
b     = 1;
alpha = 1;
beta  = 0;
h     = 1/10;

[x, u] = dtr(mu, eta, sigma, f, a, b, 'dirichlet', 'dirichlet', alpha, beta, h);

u2 = u(2 + 1);

disp(u2)