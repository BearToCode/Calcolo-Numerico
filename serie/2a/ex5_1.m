clear
clc

% Utilizzare opportunamente i comandi Matlab ones e diag per costruire una
% matrice A ∈ Rn×n con n = 20 tale che, a1,i = 1 e ai,1 = 1 per 
% i = 1, . . . , n, aii = 4 per i = 2, . . . , n ed infine ai,i+1 = −1 e
% ai+1,i = −1 per i = 2, . . . , n − 1. Tutti gli altri coefficienti di A
% sono nulli. Tale matrice si dice sparsa poiché il numero degli elementi
% non-nulli di A è O(n)  n2, dunque molto elevato. Per visualizzare la 
% posizione degli elementi non nulli di A si utilizzi il comando spy.
% Calcolare inoltre la fattorizzazione LU di A. Utilizzare il comando spy 
% per determinare se le matrici L ed U siano o meno sparse. A vostro 
% parere, le caratteristiche di sparsità dei fattori L e U sono 
% vantaggiose o svantaggiose?

n = 100;

A = zeros(n, n);
for i = 1:n
    A(1, i) = 1;
    A(i, 1) = 1;
end

for i = 2:n
    A(i, i) = 4; 
end

for i = 2:n-1
    A(i, i+1) = -1;
    A(i+1, i) = -1;
end

[L, U, P] = lu(A);
figure
spy(A);
title("A");
figure
spy(L);
title("L");
figure
spy(U);
title("U");

A_sparse = sparse(A);
L_sparse = sparse(L);
U_sparse = sparse(U);

% usa whos per vedere lo spazio occupato

% Q: pivoting per colonne
[L, U, P, Q] = lu(A_sparse);

%% Plotta con A sparse, molto meno spazio occupato
figure
spy(A);
title("A");
figure
spy(L);
title("L");
figure
spy(U);
title("U");
