% Data la funzione di iterazione φ(x) = 1/2 e^(2x−1) − x + 1/2 , si valuti l’approssimazione
% x(3) ottenuta applicando 3 passi del metodo delle iterazioni di punto fisso a partire
% da x(0) = 1 e si indichi qual è l’ordine di convergenza atteso per il metodo.

x0 = 1;
phi = @(x) 1/2 * exp(2*x - 1) - x + 1/2;

[succ1] = ptofis(x0, phi, 3, 0, 0, 2);

disp(succ1);

% Per calcolare l'ordine di convergenza del metodo, conviene avere più punti

[succ] = ptofis(x0, phi, 100, 0, 0, 2);

[p] = stimap(succ);

