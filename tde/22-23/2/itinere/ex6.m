clear; clc;

% Si consideri l’approssimazione dell’integrale I(f) = ∫[a,b] f(x) dx, dove f ∈ C∞([a, b]),
% tramite una formula di quadratura composita accurata di ordine p = 2 rispetto
% all’ampiezza H dei sottointervalli. Sapendo che per M1 = 20 sottointervalli equis-
% paziati di [a, b] si ha un errore pari a e1(f) = 10−1, per quanti sottointervalli M2
% si ha un errore stimato e2(f) = 10−3?

p = 2;
M1 = 20;
e1 = 10^(-1);
M2 = M1 * (e1 / 10^(-3))^(1/p);

disp(M2);