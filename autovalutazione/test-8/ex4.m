clear; clc;

% Media mobile semplice

med = @(values) 1 / (length(values)) * sum(values);

data = [997, 1975, 2153, 2722, 2431, 2546, 1782, 1040, 1670];

disp(med(data(5-3:5+3)));