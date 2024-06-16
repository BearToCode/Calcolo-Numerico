clear; clc;

% Si consideri la funzione f(x) = exp(x) nell’intervallo [−1, 3] e il suo interpolante
% lineare a tratti ΠH1 f(x) su intervalli di uguale ampiezza H = 1. Quanto vale
% l’approssimazione di ∫[-1,3] ΠH1 f(x) dx tramite la formula dei trapezi composita con
% H = 1?

f = @(x) exp(x);
a = -1;
b = 3;
H = 1;

n = (b - a) / H;

nodes = linspace(a, b, n+1);

piecewise_f = poly_piecewise_interp(nodes, f, 2, "equispaced");

I = trapcomp(a, b, n, piecewise_f);

disp(I); % 21.3340