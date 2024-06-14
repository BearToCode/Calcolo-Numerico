clc; clear;

% Si consideri il metodo di Newton modificato per l’approssimazione dello zero α = 3
% della funzione f (x) = sin(π/3 * x) * (x − 3)^2. Si applichi opportunamente tale metodo
% partendo dall’iterata iniziale x(0) = 4 e si riportino i valori delle iterate x(1) e x(2)
% cos`ı ottenute.

syms x;

sym_f = sin(pi/3 * x) * (x - 3)^2;
sym_df = diff(sym_f, x);

f = matlabFunction(sym_f);
df = matlabFunction(sym_df);

x0 = 4;
nmax = 5;
tol = 1e-6;

m = mzero(f, 3);
[xvect, it] = newton(x0, nmax, tol, f, df, m);

disp(xvect);

% => 2.8482    3.0004