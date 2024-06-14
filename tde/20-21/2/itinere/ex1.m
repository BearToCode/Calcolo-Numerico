clear; clc;

% Si consideri la funzione f(x) = e^(2x+sin(π x)) e il suo interpolante polinomiale
% Π5f (x) su n + 1 = 6 nodi equispaziati in [−1, 1]. Si riportino il valore massimo
% dell’errore e5(f) = max(x∈[−1,1]) |f (x) − Π5f(x)| e il punto x ∈ [−1, 1] dove questo è
% realizzato.

f = @(x) exp(2*x + sin(pi*x));

n = 5;

a = -1;
b = 1;

nodes = linspace(a, b, n+1);
values = arrayfun(f, nodes);

p = polyfit(nodes, values, n);

% Valutazione dell'errore
x = linspace(a, b, 1000);

y = arrayfun(f, x);
y_p = polyval(p, x);

e = abs(y - y_p);

[norm_inf, index] = max(e);
x_max = x(index);
fprintf('||ε_%d(%f)||∞ = %f\n', n, x_max, norm_inf);
