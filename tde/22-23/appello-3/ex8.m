% Date le due curve nel piano definite da
% x^2 + y^2 − 2 = 0
% e^x−2 + y^3 − 2 = 0,
% si vuole calcolare il punto di intersezione tra di esse contenuto nel primo quadrante
% utilizzando il metodo di Newton per sistemi non lineari. Si fornisca l’espressione
% della matrice Jacobiana del sistema di equazioni non lineari e l’approssimazione
% ottenuta con il metodo a partire dal punto iniziale x(0) = (1, 1)T considerando una
% tolleranza sul residuo pari a 10−6

syms x y;
f1 = x^2 + y^2 - 2;
f2 = exp(x-2) + y^3 - 2;

f = [f1; f2];
J = jacobian(f, [x, y]);

disp(J);

x0 = [1; 1];
tol = 1e-6;

[x] = symnewton(x0, 100, tol, f);

disp(x);