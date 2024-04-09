clc; clear;

%% 1. Utilizzando uno script si creino la matrice A (con n = 50), il 
% termine noto b ed il vettore soluzione iniziale x0.

n = 50;

A = diag(ones(1, n) * 4) + ...
    diag(ones(1, n-1) * -1, -1) + ...
    diag(ones(1, n-1) * -1, +1) + ...
    diag(ones(1, n-2) * -1, -2) + ...
    diag(ones(1, n-2) * -1, +2);

b = ones(n, 1) * 0.2;
x0 = zeros(n, 1);

%% 2. Si verifichi che la matrice A sia simmetrica e definita positiva e 
% se ne calcoli il numero di condizionamento senza utilizzare il comando 
% cond.

eigen_values = eig(A);
A_cond = max(eigen_values) / min(eigen_values);


% ATTENZIONE: A deve essere SDP!

%% 4. Si risolva il sistema lineare con il metodo di Richardson
% stazionario non precondizionato (P = I), utilizzando i seguenti 
% parametri di accelerazione: α = 0.2, α = 0.33 ed α = αopt = 2/(λmin+λmax) 
% (parametro di accelerazione ottimale) dove λmin e λmax sono 
% rispettivamente l autovalore minimo e l’autovalore massimo della matrice
% P^-1 A. Per % ciascun valore di α si calcoli il raggio spettrale della 
% matrice di iterazione (I − αP −1A)e si risolva il sistema riportando a 
% video il numero di iterazioni eseguite (si suggerisce di utilizzare 
% nmax = 10000).

P = eye(n);
toll = 10^-4;
nmax = 10^5;
% Sarebbe autovalori di A ma P = I => eig(IA) = eig(A)
alpha_opt = 2 / (max(eigen_values) + min(eigen_values));
[sol_stat, k_stat] = richardson(A, b, P, x0, toll, nmax, alpha_opt);

exact = A \ b;
err_stat = exact - sol_stat;
err_stat_norm = norm(err_stat) / norm(exact);
rho_stat = max(eig(eye(n) - alpha_opt * diag(1./diag(P)) * A));
fprintf("Metodo di Richardson statico:\nerr=%f\niter=%d\nrho=%f\n\n", ...
        err_stat_norm, ...
        k_stat, ...
        rho_stat);

[sol_grad, k_grad] = richardson(A, b, P, x0, toll, nmax);

err_grad = exact - sol_grad;
err_grad_norm = norm(err_stat) / norm(exact);
fprintf("Metodo del gradiente:\nerr=%f\niter=%d\n\n", ...
        err_grad_norm, ...
        k_grad);

%% 5. Si risolva il sistema lineare con il metodo di Richardson
% stazionario utilizzando come precondizionatore la matrice triangolare 
% inferiore di A e come parametro di accelerazione α = 1 (ovvero il metodo
% di Gauss–Seidel), riportando a video il numero di iterazioni eseguite. 
% Calcolare il raggio spettrale della matrice di iterazione corrispondente. 
% Si verifichi infine che il risultato ottenuto è identico a quello che si
% otterrebbe utilizzando la funzione gs.m, che implementa il metodo 
% di Gauss–Seidel.

alpha = 1;
P = tril(A);

[sol_gs, k_gs] = richardson(A, b, P, x0, toll, nmax, alpha);

err_gs = exact - sol_gs;
err_gs_norm = norm(err_gs) / norm(exact);
fprintf("Metodo di Gauss-Seiden:\nerr=%f\niter=%d\n\n", ...
        err_gs_norm, ...
        k_gs);


% 6. Precondizionatore custom

P = diag(ones(n, 1) * 2) + ...
    diag(ones(n-1, 1) * -1, -1) + ...
    diag(ones(n-1, 1) * -1, +1);

[sol_custom, k_custom] = richardson(A, b, P, x0, toll, nmax, alpha_opt);

err_custom = exact - sol_custom;
err_custom_norm = norm(err_custom) / norm(exact);
rho_custom = max(eig(eye(n) - alpha_opt * P^-1 * A));
alpha_opt = 2 / (max(eig(P^-1 * A)) + min(eig(P^-1 * A)));
fprintf("Metodo di R. Staz. con P custom:\nerr=%f\niter=%d\nrho=%f\n\n", ...
        err_custom_norm, ...
        k_custom, ...
        rho_custom);

