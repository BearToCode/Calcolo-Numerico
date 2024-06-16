clear; clc;

% Si consideri il seguente problema ai limiti di diffusione-trasporto:
% −u′′(x) + u′(x) = 200 x ∈ (0, 1),
% u(0) = 0, u(1) = β,
% dipendente dal parametro β > 0. Si supponga di approssimare tale problema
% utilizzando il metodo delle differenze finite centrate e passo di discretizzazione h >
% 0, ottenendo cos`ı la soluzione numerica {uj}N+1 j=0 nei corrispondenti nodi {xj}N+1 j=0 .
% Assumendo che la soluzione esatta u ∈ C4([0, 1]) sia nota e che l’errore per h = h1 = 10−2
% sia Eh1 = max j=0,...,N +1 |u(xj ) − uj | = 4 · 10−3, per quale valore di h2 `e
% possibile ottenere un valore stimato dell’errore Eh2 = 10−3?

p = 2;
E1 = 4 * 10^(-3);
E2 = 10^(-3);
h1 = 10^(-2);

h2 = (E2 / E1)^(1/p) * h1; % 0.050