% Si consideri la funzione di iterazione 
% φ(x) = x − 1/3 * (1 - e^(1 − e1−3x)) 
% e il suo punto fisso α = 1
% 3 . Qual `e l’ordine di convergenza atteso dal metodo delle iterazioni di punto
% fisso ad α per x(0) “sufficientemente” vicino ad α?

syms x;

phi = x - 1/3 * (1 - exp(1 - 3*x));

p = mzero(phi, 1/3);
disp(p);