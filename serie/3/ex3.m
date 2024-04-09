clear; clc;

B = [10 -1   1   0;
     1   1  -1   3;
     2   0   2  -1;
     3   0   1   5;];

%% 1. Usare la function gershcircles per localizzare gli autovalori.
gershcircles(B);

%% 2. Calcolare gli autovalori con la function eig di Matlab
eigen_values = eig(B);

%% 3. Usare la function invpower per calcolare l’autovalore di modulo minimo.
[min_eigen_value, min_eigen_vector, iter] = invpower(B, 1e-6, 1000, [1; 1; 1; 1]);   

%% 4. utilizzando un valore di shift opportuno dedotto dai cerchi di Gershgorin, utilizzare
% la function invpowershift per calcolare gli autovalore di modulo minimo, e
% confrontare il numero di iterazioni necessario con il metodo delle potenze dirette.

tol = 1e-6;
nmax = 1000;
x0 = rand(4, 1);

% Fatto un po' a caso perché abbiamo visto con eig che sono complessi coniugati
mu1 = 1i;
[lambda1, x1, iter1] = invpowershift(B, mu1, tol, nmax, x0);

mu2 = -1i;
[lambda2, x2, iter2] = invpowershift(B, mu2, tol, nmax, x0);

fprintf("Primo autovalore: %f, %fi\n", lambda1, lambda1/1i);
fprintf("Secondo autovalore: %f, %fi\n", lambda2, lambda2/1i);

%% 5. utilizzando un valore di shift opportuno dedotto dai cerchi di Gershgorin, utilizzare
% la function invpowershift per calcolare l'autovalore di modulo maxssimo, e
% confrontare il numero di iterazioni necessario con il metodo delle potenze dirette.

mu_max = 12;
[lambda_max, x_max, iter_max] = invpowershift(B, mu_max, tol, nmax, x0);

fprintf("Autovalore di modulo massimo: %f\n", lambda_max);
fprintf("Numero di iterazioni: %d\n", iter_max);

% Confronto con eigpower

[lambda_max_eig, x_max_eig, iter_max_eig] = eigpower(B, tol, nmax, x0);

fprintf("Autovalore di modulo massimo con eigpower: %f\n", lambda_max_eig);
fprintf("Numero di iterazioni con eigpower: %d\n", iter_max_eig);