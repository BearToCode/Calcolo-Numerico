clc; clear;

f = @(x) 2^(-x) - 1;
a = -1;
b = 4;

bisez(a,b,1e-6,f);