clear; clc;

mu = 1;
f  = @(x,t) 0;
a  = 0; us = @(t) 0;
b  = 1; ud = @(t) 0;
g0 = @(x) 7 * sin(pi * x);

h  = 0.5;
dt = 0.2;
tf = 1;

[u, x, t] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, tf, h, dt, 1);

disp(u);
disp(x);
disp(t);