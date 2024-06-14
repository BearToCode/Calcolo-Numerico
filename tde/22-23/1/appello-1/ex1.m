% Dato l’insieme dei numeri floating point F(2, 3, −4, 4), si calcolino i due numeri
% positivi pi`u grandi appartenenti a tale insieme e se ne riportino i valori in base 10.
% F(b, t, L, U)

b = 2;
t = 3;
L = -4;
U = 4;

x_max = @(b, t, U) b^U * (1 - b^(-t));
max1 = x_max(b, t, U);

%   t
% -----
% 1 1 1 X X X
%       | 
%       0

% =>
max2 = max1 - b^(U-t);
