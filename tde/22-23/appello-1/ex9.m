% Si vuole calcolare l’intersezione tra le funzioni f (x) = e^(−x^2/2) e g(x) = sin(x) per
% x ∈ [0, 2] utilizzando il metodo delle iterazioni di punto fisso con una tolleranza di
% 10−8 sul residuo. Si fornisca l’espressione di un’opportuna funzione di iterazione,
% l’iterata iniziale scelta, l’approssimazione del punto di intersezione ottenuto e il
% numero di iterazioni effetuate.

f = @(x) exp(-x.^2 / 2);
g = @(x) sin(x);

phi = @(x) x - (g(x) - f(x));

x0 = 1;
a = 0;
b = 2;

[succ] = ptofis(x0, phi, 1000, 1e-8, a, b);