clear; clc;

% Siano date le n+1 = 5 coppie di dati {(0, 2), (0.25, 0.5), (0.5, −0.5), (0.75, 0.5), (1, 3)}.
% Quanto vale ∫[0,1] ΠH1(x) dx ?

nodes = [0 0.25 0.5 0.75 1];
values = [2 0.5 -0.5 0.5 3];

f = poly_piecewise_interp(nodes, values, 1, "equispaced");

integral = integral(@(x) f(x), 0, 1);

fprintf("∫[0,1] ΠH1(x) dx = %.4f\n", integral);