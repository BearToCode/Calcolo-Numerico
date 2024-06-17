clear; clc;

% Si considerino n+1 = 6 coppie di dati {(xi, yi)}n
% i=0 = {(0, 4), (1, 4), (2, 1), (3, 1), (4, 0), (5, 0)}.
% Per quali valori a2, a1, a1 ∈ R, lo scarto quadratico Φ(a0, a1, a2) =
% ∑i=[0,n] (a2 xi^2 + a1 xi + a0 − yi)^2 assume valore minimo?

nodes = 0:5;
values = [4, 4, 1, 1, 0, 0];

poly = polyfit(nodes, values, 2);

disp(poly)