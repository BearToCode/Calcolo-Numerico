% Sia dato l’insieme dei numeri floating point F(2, t, −15, 15) dipendente dal numero
% di cifre della mantissa t ∈ N. Qual è il valore minimo di t tale per cui l’epsilon
% macchina associato all’insieme F `e inferiore a 10−8?

syms t;
b = 2;
target = 10^(-8);
eps_F = b^(1-t);

sol = solve(eps_F == target, t);

fprintf('Il valore minimo di t è %d\n', ceil(sol));

