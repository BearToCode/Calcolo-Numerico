% Si considerino 30 sistemi lineari A xj = bj per j = 1, . . . , 30, dove la matrice
% A ∈ R20×20 `e triangolare superiore e non singolare, mentre i vettori bj ∈ R20
% rappresentano diversi termini noti. Qual `e il numero di operazioni richiesto per la
% risoluzione di tali sistemi lineari per j = 1, . . . , 30 attraverso l’uso computazional-
% mente pi`u efficiente di un metodo diretto?

% Uso sostituzione all'indietro
n = 20;
n_sistemi = 30;

flops = n^2 * n_sistemi;
disp(flops);