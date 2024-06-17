clear; clc;

% Siano date le 4 coppie di dati {(0, 2.5), (1, 0.5), (2, 1.5), (3, 0.5)}. Si costruisca
% il polinomio interpolante Π3(x) di tali dati e si riportino i valori di Π3(0.75) e
% dΠ3/dx (0.75).

nodes  = [0 1 2 3];
values = [2.5 0.5 1.5 0.5];

poly = polyfit(nodes, values, 3);
der  = polyder(poly);

poly_val = polyval(poly, 0.75);
der_val  = polyval(der, 0.75);

fprintf("Π3(0.75) = %.4f\n", poly_val);
fprintf("dΠ3/dx (0.75) = %.4f\n", der_val);