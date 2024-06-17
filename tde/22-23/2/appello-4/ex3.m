clear; clc;

% Si considerino le coppie di dati nella forma {(xj , yj)}n tali per cui n + 1 = 5 e
% specificamente {(0, 4), (0.5, 0.25), (1, 0.5), (1.5, −1.5), (2, 4)}. Si costruisca il
% polinomio p3(x) di grado 3 approssimante tali dati nel senso dei minimi quadrati
% e si riporti il valore dello scarto quadratico
% ∑ j=[0,n] (p3(xj ) − yj)2 .
% Quanto vale invece il valore dello scarto quadratico nel caso in cui si considerino
% solo le prime quattro coppie di dati (ovvero n + 1 = 4) per costruire p3(x)?

nodes = [0 0.5 1 1.5 2];
values = [4 0.25 0.5 -1.5 4];

poly = polyfit(nodes, values, 3);

v1 = sum((polyval(poly, nodes) - values).^2);

nodes = [0 0.5 1 1.5];
values = [4 0.25 0.5 -1.5];

poly = polyfit(nodes, values, 3);

v2 = sum((polyval(poly, nodes) - values).^2);

disp(v1); % 3.6571
disp(v2); % 0