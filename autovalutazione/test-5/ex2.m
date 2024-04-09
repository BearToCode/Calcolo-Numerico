clc; clear;

A = hilb(3);
K2 = @(X) max(eig(X)) / min(eig(X));
d = (K2(A) - 1) / (K2(A) + 1);

disp(d);

syms x

eq = d^x == 1/200;

solve(eq)