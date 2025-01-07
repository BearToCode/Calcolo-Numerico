clc; clear;

alpha = 3;

syms x
f = (1 - exp(x-3))*((x^2)/9 - 1);
p = newtonorder(f,alpha);

disp(p);