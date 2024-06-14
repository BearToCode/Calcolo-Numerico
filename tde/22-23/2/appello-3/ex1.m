clear; clc;

% Siano date le 3 coppie di dati {(0, 4), (0.5, 3), (1, 1.25)}. Si costruisca il polinomio
% interpolante Π2(x) di tali dati e si riportino i valori di Π2(0.75) e dΠ2/dx (0.75).

nodes = [0 0.5 1];
values = [4 3 1.25];

poly = polyfit(nodes, values, 2);
dpoly = polyder(poly);

v1 = polyval(poly, 0.75);
v2 = polyval(dpoly, 0.75);

disp(v1);
disp(v2);

%  2.2188
% -3.5000