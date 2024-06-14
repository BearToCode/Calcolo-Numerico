clear; clc;

% Si consideri la funzione f (x) = e^sin(2x) sull’intervallo [−1, 1] e
% si determini il polinomio Πnf (x) interpolante tale funzione nei
% nodi {xi}n i=0 equispaziati con passo h = 0.25, essendo x0 = −1 e xn = 1.
% Quanto vale n? Fissato tale valore, si determini l’errore commesso,
% max x∈[−1,1] |f (x) − Πnf (x)|.

f = @(x) exp(sin(2*x));

x0 = -1;
xn = 1;
h  = 0.25;
n  = (xn - x0) / h;

nodes  = x0:h:xn;
values = f(nodes);

poly = polyfit(nodes, values, n);

x = linspace(x0, xn, 1000);
y = f(x);
p = polyval(poly, x);

err = max(abs(y - p));

disp(n);   % 8
disp(err); % 0.0131
