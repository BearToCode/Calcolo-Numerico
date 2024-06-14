% Si consideri la funzione di iterazione φ(x) = 1/x e^γ(x−1) dipendente dal parametro
% γ ∈ R e dotata del punto fisso α = 1. Per quali valori di γ il metodo delle iterazioni
% di punto fisso converge per ogni scelta di x(0) “sufficientemente” vicino ad α?

a = 1;
syms gamma x;

phi = 1/x * exp(gamma * (x - 1));
dphi = diff(phi, x);

% Sobstiture x = 1
dphi = subs(dphi, x, a);
disp(simplify(dphi)); % gamma - 1
fplot(abs(dphi), [-3, 3], 'LineWidth', 2);

% abs(gamma) < 1
% 0 < gamma < 2