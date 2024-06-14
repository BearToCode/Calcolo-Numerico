clc; clear;

syms x;
symf = (exp(x) - 1) * x^2;
symdf = diff(symf);

f = matlabFunction(symf);
df = matlabFunction(symdf);

a = 0;
m = mzero(symf, a);

x0 = 1.4;
tol = 10^-6;


[xvect, it] = newton(x0, 3, tol, f, df, m);

disp(xvect);