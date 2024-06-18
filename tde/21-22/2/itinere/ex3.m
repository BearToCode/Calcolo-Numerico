clear; clc;

% Si consideri la funzione f (x) = sin(π x) e il suo interpolante polinomiale lineare a
% tratti ΠH1 f (x) su 4 sottointervalli equispaziati di [0, 2]. Si riporti il valore ΠH1 f (1.6).

f = @(x) sin(pi * x);
nodes = linspace(0, 2, 4+1);


f_piecewise = poly_piecewise_interp(nodes, f, 1, "equispaced");

val = f_piecewise(1.6);

disp(val); % -0.8