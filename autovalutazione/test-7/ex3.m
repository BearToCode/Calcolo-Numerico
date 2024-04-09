clc; clear;

alpha = 3;

syms x
f = (1 - exp(1)^(x-3))*((x^2)/9 - 1);
p = convord(f,x,alpha);

disp(p);