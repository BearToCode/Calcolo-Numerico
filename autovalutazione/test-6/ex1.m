clear; clc;

syms x

A = [(5+4*x) (10-2*x);
     -2*x     x      ;];

disp(eig(A));