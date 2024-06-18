clear; clc;

% Siano date le 3 coppie di dati {(0, 2), (0.5, 1), (1, 1.5)}. Si costruisca il polinomio
% interpolante Π2(x) di tali dati e si riportino i valori di Π2(0.25) e dΠ2/dx (0.25).

nodes = [0 0.5 1];
values = [2 1 1.5];

poly = polyfit(nodes, values, 2);
dpoly = polyder(poly);

val1 = polyval(poly, 0.25);
val2 = polyval(dpoly, 0.25);

disp(val1); % 1.3125
disp(val2); % -2