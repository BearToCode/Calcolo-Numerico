% Posto n = 100, la matrice A e' la matrice pentadiagonale seguente:
% A = pentadiag ( 1, −8, 14, −8, 1 ) ∈ R100×100.
% Si assegni la matrice A in Matlab e si verifichi che A e' simmetrica e definita pos-
% itiva; si giustifichi la risposta data riportando valori numerici laddove necessario.

clc; clear;

n = 10;
% A = pentadiag(1, -8, 14, -8, 1, 100);
A = diag(ones(n,1) * 14) + ...
    diag(ones(n-1,1) * -8, 1) + ...
    diag(ones(n-1,1) * -8, -1) + ...
    diag(ones(n-2,1), 2) + ...
    diag(ones(n-2,1), -2);

% Verifico che A sia simmetrica
assert(isequal(A, A'));
fprintf('A e'' simmetrica\n');

% Verifico che A sia definita positiva
assert(all(eig(A) > 0));
fprintf('A e'' definita positiva\n');
