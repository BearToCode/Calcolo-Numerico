clc; clear;

syms x1 x2;
f = [(exp(1)^((x1^2 + x2^2-1)/4) - 1); 
     (x1 + exp(1)^x2 - 2)            ;];


x0 = [2/3; 1/3];

x2 = symnewton(x0, 2, 0, f)