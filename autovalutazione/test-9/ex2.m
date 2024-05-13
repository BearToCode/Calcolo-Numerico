syms x beta gamma;

tol = 10^-2;

f = exp(-x) - beta * x + gamma;

a = -1;
b = 1;

% Trovo il massimo della derivata seconda
% d2f = exp(-x)

max = exp(1);

% Stima dell'errore

syms M;

H = (b - a) / M;

eq = (b - a) / 24 * H^2 * max == tol;

M = solve(eq, M);
disp(M);