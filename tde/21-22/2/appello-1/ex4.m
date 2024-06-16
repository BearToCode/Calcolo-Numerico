 clear; clc;

% Si considerino n+1 = 5 coppie di dati
% {(xi, yi)}n i=0 = {(0, 2), (1, 2), (2, 0), (3, 1), (4, 0)}.
% Per quali valori a0, a1 ∈ R, lo scarto quadratico Φ(a0, a1) =
% ∑ [i=0,n] (a1 xi + a0 − yi)^2 assume valore minimo?

nodes = [0 1 2 3 4];
values = [2 2 0 1 0];
n = 5;

% Equivale a trovare la retta di regressione lineare
poly = polyfit(nodes, values, 1);


% poly =
%    -0.5000    2.0000
