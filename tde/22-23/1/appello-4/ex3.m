% Si considerino 10 sistemi lineari A xj = bj per j = 1, . . . , 10, dove la matrice
% A ∈ R90×90 `e non singolare e triangolare inferiore, mentre i vettori bj ∈ R90
% rappresentano diversi termini noti. Qual è il numero di operazioni necessario per
% la risoluzione di tali sistemi lineari per j = 1, . . . , 10 attraverso un metodo diretto
% computazionalmente efficiente?

% => Uso sostituzione in avanti
n = 90;
n_systems = 10;
flops = n_systems * n^2;

fprintf('Il numero di operazioni necessario per la risoluzione di tali sistemi lineari è: %d\n', flops);