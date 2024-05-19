clear; clc;

f = @(x) (5 + 2 ^ x);

x_v = 0;
h = 1/4;

diff_f = @(x) (-3 * f(x) + 4 * f(x + h) - f(x + 2 * h)) / (2 * h);

diff_f(x_v)