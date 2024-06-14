% Si considerino la matrice A =
% 5 0 0
% 3 2 0
% 4 1 1.9999999
% e il metodo della fattorizzazione QR per l’approssimazione dei suoi autovalori. 
% Si applichi il metodo, si determini il numero di iterazioni necessarie per raggiungere 
% una tolleranza di 10−6 e lo si riporti insieme all’approssimazione dell’autovalore 
% λ3(A) così ottenuta.

A = [5 0 0; 
     3 2 0; 
     4 1 1.9999999];
tol = 10^-6;

[eigs, iter] = qrbasic(A, tol, 100000000);
lambda3 = eigs(3);

fprintf('Autovalore λ3(A) = %f\n', lambda3);
fprintf('Iterazioni necessarie = %d\n', iter);