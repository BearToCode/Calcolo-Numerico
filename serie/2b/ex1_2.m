clc
clear

n = 7;

% 1. Costruire la matrice A e il termine noto b.

A = diag(9 * ones(n, 1)) + ...
    diag(-3 * ones(n-1, 1), -1) + ...
    diag(-3 * ones(n-1, 1), 1) + ...
    diag(ones(n-2, 1), -2) + ...
    diag(ones(n-2, 1), 2);

b = [7 4 5 5 5 4 7]';

% 2. La matrice A è a dominanza diagonale stretta per righe?

A_diag = diag(abs(A));
A_exdiag = sum(abs(A), 2) - diag(abs(A));
if A_diag > A_exdiag
    disp('A è diagonale dominante stretta per righe');
else
    disp('A non è diagonale dominante stratta per righe');
end

% 3. La matrice A è simmetrica definita positiva?

if isequal(A,A') && max(eig(A)) < 0 
    disp('La matrice è simmetrica definita positiva')
end

% 5. Si ponga x(0) = [0, 0, ..., 0]T , toll = 10−6 e nmax = 1000.
% Si calcoli la soluzione tramite la funzione gs.

x0 = zeros(n, 1);
toll = 10^-6;
nmax = 1000;

[x_gs, k_gs] = gs(A, b, x0, toll, nmax);

%% 6. Si calcoli la soluzione del sistema anche con il metodo di Jacobi,
% e si confrontino il numero di iterazioni necessarie per arrivare a 
% convergenza per i due metodi. Commentare i risultati.

[x_j, k_j] = jacobi(A, b, x0, toll, nmax);

fprintf("Gauss-Seiden:\nk: %d\n", k_gs);
fprintf("Jacobi:\nk: %d\n", k_j);

% Calcolo raggi spettrali
D_inv = diag(1 ./ diag(A));
Bj = eye(n) - D_inv*A;
T = tril(A);
Bgs = eye(n) - T \ A;

rho_j = max(abs(eig(Bj)));
rho_gs = max(abs(eig(Bgs)));

fprintf("Raggio spettrale Jacobi: %f\n", rho_j);
fprintf("Raggio spettrale Gauss-Seiden: %f\n", rho_gs);

% Stime approssimate
k_min_j = ceil(log(toll)/log(rho_j));
k_min_gs = ceil(log(toll)/log(rho_gs));

fprintf("# operazioni stimate Jacobi: %d\n", k_min_j);
fprintf("# operazioni stimate Gauss-Seiden: %d\n", k_min_gs);




