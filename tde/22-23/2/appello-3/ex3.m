clear; clc;

% Si considerino le coppie di dati nella forma {(xj , yj)}n j=0, tali per cui n + 1 =
% 6 e specificamente {(0, 5), (0.25, 0.25), (0.5, 0.75), (0.75, −1), (1, 2), (1.25, 4)}. Si
% costruisca il polinomio p2(x) di grado 2 approssimante tali dati nel senso dei minimi
% quadrati e si riporti il valore dello scarto quadratico ∑ [j=0,n] (p2(xj) − yj)2.
% Quanto vale invece il valore dello scarto quadratico nel caso in cui si considerino
% solo le prime 6 coppie di dati (ovvero n + 1 = 5)?

nodes = [0 0.25 0.5 0.75 1 1.25];
values = [5 0.25 0.75 -1 2 4];

poly = polyfit(nodes, values, 2);

v1 = sum((polyval(poly, nodes) - values).^2);

nodes = [0 0.25 0.5 0.75 1];
values = [5 0.25 0.75 -1 2];

poly = polyfit(nodes, values, 2);

v2 = sum((polyval(poly, nodes) - values).^2);

disp(v1); % 3.6397
disp(v2); % 3.0286
