clear; clc;

% Si considerino n+1 = 5 coppie di dati {(xi, yi)}n i=0 = {(0, 1), (1, 1), (2, 2), (3, 2), (4, 3)}
% e la retta di regressione ˜f1(x) costruita su tali dati. Si riporti il valore ˜f1(4).

nodes  = [0 1 2 3 4];
values = [1 1 2 2 3];

poly = polyfit(nodes, values, 1);

f1 = polyval(poly, 4);

disp(f1); % 2.8