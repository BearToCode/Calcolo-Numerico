% Si considerino 10 sistemi lineari A xj = bj per j = 1, . . . , 10, dove la matrice
% A ∈ R90×90 `e fissata, tridiagonale e a dominanza diagonale stretta per righe,
% mentre i vettori bj ∈ R90 rappresentano diversi termini noti. Qual `e il numero
% di operazioni richiesto per la risoluzione di tali sistemi lineari per j = 1, . . . , 10
% attraverso l’uso computazionalmente pi`u efficiente di un metodo diretto?

% Uso metodo di thomas
sistemi = 10;
n = 90;

% solo una fattorizzazione
fact = 3 * (n-1);
fw = 2 * (n-1);
bk = 3 * (n-1) + 1;

tot = fact + sistemi * (fw + bk);
disp(tot);