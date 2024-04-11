% Si consideri la funzione f (x) = log(x/3)*sin(πx) e il metodo di Newton approssi-
% mare lo zero α = 3. Scelto x(0) “sufficientemente” vicino ad α, qual `e l’ordine di
% convergenza p atteso per il metodo?

syms x;
f = log(x/3)*sin(pi*x);
a = 3;

p = newtonorder(f, a);
disp(p)