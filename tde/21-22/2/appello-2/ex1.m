clear; clc;

% Data la funzione f (x) = sin(x + √5), si costruisca il suo polinomio interpolante
% Π3f (x) su nodi di Chebyshev–Gauss–Lobatto nell’intervallo [0, π] e si riportino i
% valori di Π3f (1) e dΠ3f/dx (1).

f = @(x) sin(x + sqrt(5));
a = 0;
b = pi;
n = 3;

nodes = chebyshev([a, b], n+1);
values = f(nodes);

poly = polyfit(nodes, values, n);
dpoly = polyder(poly);

f1 = polyval(poly, 1);
df1 = polyval(dpoly, 1);

disp(f1);
disp(df1);

% -0.0822
% -0.9372