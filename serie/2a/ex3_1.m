clear
clc

N = 20;
n = N - 1;
L = 20; % [m]
K = 100; % [N/m]

A = diag(ones(n,1) .* -2) + ...
    diag(ones(n-1,1), -1) + ...
    diag(ones(n-1,1),  1);

b = zeros(n,1);
b(n) = K * L;

[L, U, x] = thomas(A, b);


