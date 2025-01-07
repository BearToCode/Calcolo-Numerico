clc; clear;

syms n;

lambda_j = @(j, n) 3 + 3*cos(pi * j/(n+1));

lambda_max = 6;
lambda_min = 3+3*cos(pi * n/(n+1));

K = lambda_max/lambda_min;

approx = series(K, n, inf, 'Order', 3);
disp(approx)