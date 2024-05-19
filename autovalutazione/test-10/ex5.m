clear; clc;

f = @(t, y) -(1 + t/2) * y;
y0 = 3;

h = 0.1;

[~, u_values] = eulerbkw_fixedpt(f, h, y0, h);

u1 = u_values(2);

disp(u1);