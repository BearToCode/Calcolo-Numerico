% Si consideri il metodo di Richardson stazionario per risolvere il sistema lineare
% Ax = b, dove:
%    | 4 3 2 0 | 
% A= | 3 4 1 1 | e b = (6, 4, 6, 2)^T
%    | 2 1 4 2 | 
%    | 0 1 2 4 |
% usando il parametro ottimale α_opt. Si risolva il sistema usando la funzione Matlab 
% richardson.m, con il vettore x0 = (1, 1, 1, 1)^T come valore iniziale e una tolleranza
% pari a 10−5. Si riportino il valore di αopt e il numero di interazioni N necessarie a
% raggiungere la convergenza.

A = [4 3 2 0;
     3 4 1 1;
     2 1 4 2;
     0 1 2 4];
b = [6; 4; 6; 2];

eigen_values = eig(A);
a_opt = 2 / (max(eigen_values) + min(eigen_values));

P = eye(4);
x0 = [1; 1; 1; 1];
toll = 1e-5;
nmax = 1000;

[x, k] = richardson(A, b, P, x0, toll, nmax, a_opt);
fprintf('alpha_opt = %f\n', a_opt);
fprintf('N = %d\n', k);