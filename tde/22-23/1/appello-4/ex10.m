% Si considerino il sistema di funzioni non lineari F(x) : R2 → R2, dove x =
% (x1, x2)T ∈ R2 e F(x) = (x1 x2 − 2, −x1 + x1 * e^x2−1)T ∈ R2, e l’approssimazione
% dello zero α = (2, 1)T ∈ R2 di F(x) tramite il metodo di Newton. Posta l’iterata
% iniziale x(0) = (3, 2)T , si applichino due iterazioni del metodo e si riporti l’iterata
% x(2) così ottenuta.

syms x1 x2;

F = [x1 * x2 - 2; -x1 + x1 * exp(x2 - 1)];
x0 = [3; 2];

x2 = symnewton(x0, 2, 0, F, [x1 x2], []);
disp(x2); % [2; 1]