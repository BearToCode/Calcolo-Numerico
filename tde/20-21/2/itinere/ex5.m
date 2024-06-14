% Si consideri l’approssimazione dell’integrale I(f) = ∫ [a,b] f(x) dx, dove f ∈ C∞([a, b]),
% tramite una formula di quadratura composita. Sapendo che per M1 = 10 sot-
% tointervalli equispaziati di [a, b] si ha un errore pari a e1(f) = 10−1, mentre per
% M2 = 100 sottointervalli si ha un errore e2(f ) = 10−4, si stimi l’ordine di accu-
% ratezza p della formula.

M1 = 10;
e1 = 10^-1;

M2 = 100;
e2 = 10^-4;

h1 = M1^-1;
h2 = M2^-1;

p = log10(e2 / e1) / log10(h2 / h1);

disp(p);