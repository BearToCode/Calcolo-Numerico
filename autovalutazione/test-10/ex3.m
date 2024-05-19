clear; clc;

f = @(t, y) -y + 2 * t;
y0 = 1;

syms h;
u_values = eulerfwdsym(f, 4, y0, h);

disp(simplify(u_values(4)));
