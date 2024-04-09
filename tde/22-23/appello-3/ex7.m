% Si consideri la funzione f (x) = log(x + 5/2) * cos(πx) e il metodo di Newton per
% l’approssimazione degli zeri α1 e α2 ∈ [−2, 0]. Si valuti per ciascuno degli zeri α1 e
% α2 quale sia l’ordine di convergenza p atteso per il metodo partendo da dati iniziali
% “sufficientemente” vicini a ciascuno degli zeri.

syms x;
symf = log(x + 5/2) * cos(pi*x);

a1 = -1.5;
a2 = -1/2;

p1 = newtonorder(symf, a1);
p2 = newtonorder(symf, a2);

fprintf('Ordine di convergenza per alpha1: %d\n', p1);
fprintf('Ordine di convergenza per alpha2: %d\n', p2); 