clc; clear;

syms x

A = [4 -1;
     -1 x;];
assume(x > 1);
b = [1;1];

x0 = [0;0];

r0 = b - A*x0;
p0 = r0;
a0 = (p0' * r0) / (p0' * A * p0);
r1 = r0 - a0 * A * r0;
b0 = (p0' * A * r1) / (p0' * A * p0);
p1 = r1 - b0 * p0;

disp(simplify(p1));