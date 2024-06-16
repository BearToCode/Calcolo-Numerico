clear; clc;

% Si consideri la funzione f (x) =
% (x/π)^2 se x ∈ [0, π)
% (2 − x/π)^2 se x ∈ [π, 2π)
% e la sua spline cubica interpolante s3(x) definita sui nodi xi = 2π n i,
% per i = 0, 1, . . . , n. Posto n = 5, si riporti il valore di s3(x3).

f = @(x) (x/pi).^2 .* (x < pi) + (2 - x/pi).^2 .* (x >= pi);

a = 0;
b = 2*pi;
n = 5;

nodes = linspace(a, b, n + 1);

val = spline(nodes, f(nodes), 2*pi/5 * 3);

disp(val); % 0.64