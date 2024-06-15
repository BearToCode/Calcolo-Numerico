clear; clc;

% Si consideri la funzione di Runge f (x) = 2/(1 + x^2) e il suo interpolante polinomiale
% Πnf (x) di grado n su n + 1 nodi di Chebyshev–Gauss–Lobatto in [−3, 3]. Dopo
% aver definito l’errore di interpolazione come Enf (x) = max
% x∈[−1,1] |f (x) − Πnf (x)|, si riporti il valore atteso di lim n→+∞ Enf (x).


% I nodi di chebychev garantiscono una convergenza uniforme dell'interpolazione

err = 0;