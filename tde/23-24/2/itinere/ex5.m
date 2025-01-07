clear; clc;

syms x;
f_sym(x) = sin(x)^2 * cos(x);

a = 0;
b = pi/2;

I_ex = 1/3;

d4f_sym(x) = diff(f_sym, x, 4);
d4f = matlabFunction(d4f_sym);

% Trovo il massimo di d4f in [a b]

x = linspace(a, b, 1000);
y = arrayfun(d4f, x);

max_y = max(y);

% Risolvo

syms H;
% solve(-(b-a)/2880 * H^4 * max_y == 1e-8, H)
% 52

M = 52;

f = matlabFunction(f_sym);

I = simpcomp(a, b, M, f);

disp(abs(I - I_ex));