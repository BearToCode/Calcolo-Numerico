% Si consideri la matrice A =
% 6 −1 0
% −1 4 −1
% 0 −1 2
% Si applichi il metodo delle potenze
% (dirette) per l’approssimazione di λ1(A) a partire dal vettore iniziale x(0) = 1. Si
% riportino i valori delle approssimazioni λ(0) e λ(3) di tale autovalore.

A = [6 -1 0; -1 4 -1; 0 -1 2];
x0 = [1; 1; 1];

[~, ~, ~, lambda_vect] = eigpower(A, 0, 3, x0);
disp(lambda_vect);