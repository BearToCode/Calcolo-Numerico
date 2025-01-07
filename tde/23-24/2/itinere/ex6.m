clear; clc;

x = [10.71 11.15 11.19];

% Derivata prima con differenze finite centrate
h = 0.1;
v = (11.19 - 10.71) / (2*h);

% Derivata seconda con differenze finite centrate
h = 0.1;
a = (11.19 - 2 * 11.15 + 10.71) / h^2;