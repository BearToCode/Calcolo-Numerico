clear; clc;

t0    = 0;
tf    = 1;
y0    = [1 1 1]';
f     = @(t, y) [-exp(-t) * y(1) + y(2); -y(2) + t; y(1) - 2 * y(3)];
h     = 0.1;
theta = 0.5;

[t_h, u_h] = theta_systems(f, [t0 tf], y0, (tf - t0) / h, theta);

disp('t_h = ');
disp(t_h);
disp('u_h = ');
disp(u_h);