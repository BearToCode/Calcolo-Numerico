clear; clc;

% Si consideri l’integrale I(f) = ∫[0,6] f(x) dx, dove f(x) = x^3, e la sua approssi-
% mazione tramite la formula di quadratura Iq (f) = 3 (f(3 + c) + f(3 − c)) dipen-
% dente dal parametro c > 0. Per quale valore di c si ottiene che Iq (f) ≡ I(f)?

f = @(x) x.^3;
I = integral(f, 0, 6);

syms c;
Iq = 3 * (f(3 + c) + f(3 - c));
assume(c > 0);
c = solve(Iq == I, c);
disp(c); % 0