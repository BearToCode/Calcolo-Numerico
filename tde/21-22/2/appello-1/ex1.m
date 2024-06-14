clear; clc;

% Data la funzione f (x) = sin(x + √2) si costruisca il suo polinomio interpolante
% Π3f (x) sull’intervallo [0, π] e si riportino i valori di Π3f (2) e dΠ3f
% dx (2).

f = @(x) sin(x + sqrt(2));

nodes = linspace(0, pi, 4);
values = f(nodes);

poly = polyfit(nodes, values, 3);
dpoly = polyder(poly);

val1 = polyval(poly, 2);
val2 = polyval(dpoly, 2);

disp(val1);
disp(val2);