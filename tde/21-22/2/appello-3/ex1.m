clear; clc;

% Data la funzione f (x) = sin(x + √7), si costruisca il suo polinomio interpolante
% Π3f (x) su nodi equispaziati nell’intervallo [0, π] e si riportino i valori di dΠ3f/dx (π)
% e d2Π3f/dx2 (π).

f = @(x) sin(x + sqrt(7));
a = 0;
b = pi;

n = 3;

nodes = linspace(a, b, n + 1);

poly = polyfit(nodes, f(nodes), n);
dpoly = polyder(poly);
d2poly = polyder(dpoly);

val1 = polyval(dpoly, pi);
val2 = polyval(d2poly, pi);

disp(val1); % 1.1290
disp(val2); % 1.3454