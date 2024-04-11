% Si consideri la matrice di Pascal definita da A = pascal(5)∈ R5×5. Si applichi il
% metodo delle iterazioni QR per l’approssimazione degli autovalori di A con una tol-
% letanza di 10−2. Si riportino i valori in formato format long delle approssimazioni
% degli autovalori di modulo minimo e massimo ottenuti.

A = pascal(5);
tol = 10^-2;
nmax = 1000;

format long;

[eigs] = qrbasic(A, tol, nmax);
disp(eigs);

format default;