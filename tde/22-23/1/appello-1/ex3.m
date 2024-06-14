% Si considerino 20 sistemi lineari A xj = bj per j = 1, . . . , 20, dove la matrice
% A ∈ R60×60 `e fissata, simmetrica e definita positiva, mentre i vettori bj ∈ R60
% rappresentano diversi termini noti. Qual `e il numero di operazioni stimato per la
% risoluzione di tali sistemi lineari per j = 1, . . . , 20 attraverso l’uso computazional-
% mente pi`u efficiente di un metodo diretto?

% SDP => Choelsky
n_systems = 20;
n = 60;
flops = n^3 / 3 + n_systems * 2 * n^2;
disp(flops);