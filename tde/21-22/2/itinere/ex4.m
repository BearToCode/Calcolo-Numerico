clear; clc;

% Si considerino le coppie di dati nella forma {(xj, yj)}n j=0, tali per cui n + 1 = 5
% e specificamente {(0, 3), (0.25, 0.5), (0.5, 1.5), (0.75, −0.5), (1, 1)}. Si costruisca il
% polinomio p2(x) di grado 2 approssimante tali dati nel senso dei minimi quadrati
% e si riporti il valore dello scarto quadratico ∑ j=[0,n] (p2(xj ) − yj )2

nodes = [0 0.25 0.5 0.75 1];
values = [3 0.5 1.5 -0.5 1];

poly = polyfit(nodes, values, 2);

residual = sum((polyval(poly, nodes) - values).^2);

disp(residual); % 2.4143