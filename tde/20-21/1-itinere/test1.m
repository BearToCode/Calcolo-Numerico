% Sia dato l’insieme dei numeri floating point F(2, 3, −2, U ) dipendente dal parametro
% U ∈ N. Sapendo che il numero massimo rappresentabile (in base 10) con tale
% insieme `e xmax = 14, si determini il valore assunto da U 

% base = 2
% cifre = 3
% lower = -2
% upper = U

% (14)10 = (1110)2

% max = base^upper * (1 - base^(-cifre))
% 14 = 2^x * (1 - 2^(-3))

clc; clear;

syms x
eq = 14 == 2^x * (1 - 2^(-3));

U = solve(eq, x);
fprintf('U = %d\n', U);