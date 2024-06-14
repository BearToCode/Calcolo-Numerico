% Sia dato l’insieme dei numeri floating point F(2, 8, −20, 20). Si calcolino il pi`u pic-
% colo e il pi`u grande numero positivo rappresentabile nell’insieme F e se ne riportino
% i valori in base 10.

% F(b, t, L, U)
% b - base
% t - numero di cifre
% L - lower bound
% U - upper bound

x_max = @(b, t, U) b^U * (1 - b^(-t));
x_min = @(b, L) b^(L-1);


fprintf('Numero massimo rappresentabile: %E\n', x_max(2, 8, 20));
fprintf('Numero minimo rappresentabile: %E\n', x_min(2, -20));