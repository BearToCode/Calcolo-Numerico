clear; clc;

A = [-2 0 0;
    0 -3 1;
    0 -1 -3];

lambdamax = max(eig(A));

hmax = -2 * (real(lambdamax)) / abs(lambdamax)^2;

disp("0 < h < " + hmax)