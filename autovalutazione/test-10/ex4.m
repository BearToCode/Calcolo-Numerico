clear; clc;

f = @(t, y) -y + 2 * t;
symf = sym(f);
y0 = 1;

syms h;
u_values = eulerbkwsym(symf, 4, y0, h);

disp(simplify(u_values(end)));