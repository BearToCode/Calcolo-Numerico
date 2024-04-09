% Si considerino 30 sistemi lineari A xj = bj per j = 1, . . . , 30, dove la matrice
% A ∈ R20×20 `e invertibile e tale che (A)ij = 0, per i > j e per i < j − 1, mentre i
% vettori bj ∈ R20 rappresentano diversi termini noti. Qual è il numero di operazioni
% richiesto per la risoluzione di tali sistemi lineari per j = 1, . . . , 30 attraverso l’uso
% computazionalmente pi`u efficiente di un metodo diretto?

n = 20;
n_systems = 30;

A = rand(n, n);

for i = 1:n
    for j = 1:n
        if i > j || i < j - 1
            A(i, j) = 0;
        end
    end
end

spy(A);

% => La matrice ha solo la diagonale principale e una sopra la diagonale
% => Come la matrice U di una fattorizzazione LU del metodo di Thomas

flops = n_systems * (3 * (n - 1) + 1);
disp(flops);