% La convergenza del metodo della fattorizzazione QR per l’approssimazione degli
% autovalori reali e distinti {λi} di una matrice A ∈ Rn×n `e tanto piu' rapida, tanto
% minore è il valore max i=2,...,n { λi/λi−1 }
% Posto n = 5 e sapendo che A ha autovalori
% reali e distinti λ1 = 10, λ2 = 8, λ3 = 6, λ4 e λ5 = 3, si determini per quali valori
% di λ4 ∈ (λ5, λ3) la convergenza del metodo della fattorizzazione QR risulta essere
% la piu' rapida.

lambda1 = 10;
lambda2 = 8;
lambda3 = 6;
lambda5 = 3;

syms lambda4;

prev_ratio = lambda4 / lambda3;
next_ratio = lambda5 / lambda4;

assume(lambda4 < lambda3);
assume(lambda4 > lambda5);

fplot(prev_ratio, [lambda5 - 1, lambda3 + 1]);
hold on;
grid on;
fplot(next_ratio, [lambda5 - 1, lambda3 + 1]);
hold off;

solve(prev_ratio == next_ratio) % => 3sqrt(2)