% Si consideri la funzione di iterazione φ(x) = (2 − x + γ x(x − 1))/γ(x − 1) , dipendente dal
% parametro γ ∈ R tale che γ > 0 e dotata del punto fisso α = 2. Per quali valori di
% γ il metodo delle iterazioni di punto fisso converge ad α, scegliendo l’iterata iniziale
% “sufficientemente” vicina a α? Per quale valore di γ l’ordine di convergenza atteso
% dal metodo `e p = 2?

a = 2;

syms x gamma;
sym_phi = (2 - x + gamma*x*(x - 1))/(gamma*(x - 1));
sym_dphi = diff(sym_phi, x);

% Sostituisco x = a 
sym_dphi_a = subs(sym_dphi, x, a);
disp(simplify(sym_dphi_a)); % => (gamma - 1)/gamma => gamma > 1/2
figure;
fplot(abs(sym_dphi_a), [0.25, 2]);

% p = 2 impongo derivata prima = 0
solve(sym_dphi_a == 0, gamma) % => gamma = 1