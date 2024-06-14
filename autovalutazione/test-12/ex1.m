clc; clear;

A = [-4  1; 2 -3];
f = @(t, y) A * y;

t0 = 0;
tf = 1;
y0 = [7; 2];

h = 0.1;
Nh = (tf - t0) / h;

[~, u_h] = eulerfwd_systems(f, [t0 tf], y0, Nh);
disp(u_h)

[~, u_h] = eulerbkw_systems(f, [t0 tf], y0, Nh);
disp(u_h)
