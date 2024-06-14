clear; clc;

mu  = 3;
eta = -100;
a   = -1; alpha = 5;
b   =  1; beta  = 0;

local_peclet = @(h) (abs(eta) * h) / (2 * mu);

% Per differenze finite centrate, il numero di Peclet deve essere minore di 1

h_critical = fzero(@(h) local_peclet(h) - 1, 0);

disp(h_critical);

xx = linspace(a, b, 100);

plot(xx, local_peclet(xx));