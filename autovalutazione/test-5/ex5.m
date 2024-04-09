clc; clear;

syms x

A = [10 -2;
     -2  x;];

assume(x>0);

ev = eig(A);

disp(ev);

