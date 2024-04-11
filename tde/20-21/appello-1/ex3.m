% Si considerino 10 sistemi lineari A xj = bj per j = 1, . . . , 10, dove la matrice
% A ∈ R80×80 `e fissata, triangolare inferiore e non singolare, mentre i vettori bj ∈ R80
% rappresentano diversi termini noti. Qual `e il numero di operazioni richiesto per la
% risoluzione di tali sistemi lineari per j = 1, . . . , 10 attraverso l’uso computazional-
% mente piu; efficiente di un metodo diretto?

% Uso sostituzione in avanti
n = 80;
n_sistemi = 10;

flops = n^2 * n_sistemi;
disp(flops);