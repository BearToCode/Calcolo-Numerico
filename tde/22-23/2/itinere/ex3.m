clear; clc;

% Si consideri la funzione f (x) = sin(π x) e il suo interpolante polinomiale lineare a
% tratti ΠH1 f (x) su 4 sottointervalli equispaziati di [0, 2]. Si riporti il valore ΠH1 f (1.6).

f = @(x) sin(pi * x);
nodes = linspace(0, 2, 5);

val = linear_interpolation(f, nodes, 1.6);
% Altrimenti con interp1


disp(val);


function val = linear_interpolation(f, nodes, x)
val = 0;
for i = 1:length(nodes) - 1
    if nodes(i) <= x && x <= nodes(i + 1)
        val = f(nodes(i)) + (f(nodes(i + 1)) - f(nodes(i))) / (nodes(i + 1) - nodes(i)) * (x - nodes(i));
        break;
    end
end
end