clc; clear;

syms x g u

phi = (g+1/2)*x + 2*g - 1 + (x+2)^u;
alpha = -2;

dfs(phi, x, 3);