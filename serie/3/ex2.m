clc; clear;

% 2. Applicare la funzione invpower alla matrice ottenuta con il comando toeplitz( 1 : 4 ),
% usando tolleranza pari a 10−6, numero massimo di iterazioni pari a 100 e vettore
% iniziale x(0) = (1, 2, 3, 4)T . Provare poi ad usare la funzione invpower ponendo
% x(0) = (1, 1, 1, 1)T e commentare il risultato.

A = toeplitz(1:4);

[mu, x, k] = invpower(A, 1e-6, 100, [1; 2; 3; 4]);
fprintf('mu = %f\n', mu);
fprintf('k = %d\n', k);
fprintf('x = \n');
disp(x);

[mu, x, k] = invpower(A, 1e-6, 100, [1; 1; 1; 1]);
fprintf('mu = %f\n', mu);
fprintf('k = %d\n', k);
fprintf('x = \n');
disp(x);