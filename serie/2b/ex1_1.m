clc
clear

n = 100;
R1 = 1;
R2 = 2;

A = diag(-R2 * ones(n, 1)) + ...
    diag(R1 * ones(n-1, 1), -1);

A(1, :) = ones(1, n);

%% 1. Memorizzare la matrice in formato pieno e determinare il numero di
% elementi non nulli tramite il comando nnz e visualizzare il pattern di 
% sparsità della matrice con il comando spy. Verificare la diversa 
% occupazione di memoria nel caso la matrice fosse convertita in formato
% spars

fprintf("Elementi non nulli: %d\n", nnz(A));

A_sparse = sparse(A);

A_info = whos('A');
A_size = A_info.bytes;
A_sparse_info = whos('A_info');
A_sparse_size = A_sparse_info.bytes;

fprintf("A size: %d bytes\nA_sparse size: %d bytes\n", ...
        A_size, A_sparse_size);

%% 2. Si calcoli la fattorizzazione LU della matrice A
% (funzione lu di Matlabr ); cosa si può osservare confrontando il pattern
% di sparsità delle matrici L e U con quello di A? Che fenomeno si è 
% verificato?

[L, U] = lu(A);
figure
spy(L);
title('L')
figure
spy(U);
title('U');
figure
spy(A)
title('A');

%% 3. Si costruiscano esplicitamente le matrici di iterazione
% BJ = D−1 (D − A) e BGS = T −1 (T − A) associate rispettivamente ai
% metodi di Jacobi e Gauss–Seidel, a partire dallo splitting della 
% matrice A. Si calcolino i relativi raggi spettrali ρ(BJ ) e ρ(BGS ), 
% utilizzando il comando eig. La condizione necessaria e sufficiente per 
% la convergenza del metodo iterativo è soddisfatta in entrambi i casi?

D_inv = diag(1 ./ diag(A));
Bj = eye(n) - D_inv*A;

T = tril(A);
% Bgs = eye(n) - inv(T) * A;
Bgs = eye(n) - T \ A;

% Raggio spettrale
rho_j = max(abs(eig(Bj)));
rho_gs = max(abs(eig(Bgs)));

if rho_j >= 1
    fprinf("Il raggio spettrale di Jacobi è >= 1!\n");
end

if rho_gs >= 1
    fprintf("Il raggio spettrale di Gauss-Seiden è >= 1!\n");
end

%% 5. Utilizzare la funzione scritta al punto precedente per determinare 
% la soluzione del sistema lineare Ax = b, con b vettore di
% dimensione n:
% b = [2, 1, · · · , 1]T .
% Si ponga x(0) = [0, 0, ..., 0]T , toll = 10−6 e nmax = 1000.

b = ones(n, 1);
b(1) = 2;

x0 = zeros(n, 1);
toll = 10^-6;
nmax = 1000;

[x,k] = jacobi(A, b, x0, toll, nmax)