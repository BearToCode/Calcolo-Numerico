%% Sostituzione in avanti Lx = b 
% Funziona solo con matrici L triangolari inferiori

% esempio:

L = [1 0 0; ...
     2 3 0; ...
     4 5 6];
b = [1; 2; 3];

x = fwsub(L, b);
assert(isequal(x, L \ b));

%% Sostituzione all'indietro Ux = b
% Funziona solo con matrici U triangolari superiori

% esempio:

U = [1 2 3; ...
     0 4 5; ...
     0 0 6];
b = [1; 2; 3];

x = bksub(U, b);
assert(isequal(x, U \ b));

%% Metodo di fattorizzazione di Gauss

% Caso A fattorizzabile A = LU
A = [3  1 -1; ...
     2 -1  1; ...
     1  1  1];
b = [4; 2; 4];

[L, U] = lu(A);
y = fwsub(L, b); % Ly = b
x = bksub(U, y); % Ux = y
assert(isequal(x, A \ b));

% Caso generale con pivoting LU = PA
A = [1  1  1; ...
     1  1  2; ...
     1  2  3];
b = [3; 4; 6];

[L, U, P] = lu(A);
y = fwsub(L, P * b); % Ly = Pb
x = bksub(U, y); % Ux = y
assert(isequal(x, A \ b));

% Pivoting totale

A = [0  4  1; ...
     0  0  2; ...
     1  2  3];
b = [1; 2; 3];

A = sparse(A);

[L, U, P, Q] = lu(A);

y = fwsub(L, P * b); % Ly = Pb
z = bksub(U, y); % Uz = y
x = Q * z;
assert(isequal(x, A \ b));

%% Teorema di condizione necessaria e sufficiente per l'esistenza 
%% della fattorizzazione LU

% Tutte le sottomatrici A_i di A invertibile devono essere non singolari

A = [0  4  1; ...
     0  0  2; ...
     1  2  3];
assert(~factorizable(A));

A = [1  5  1; ...
     7  1  2; ...
     1  2  2];
assert(factorizable(A));

%% Condizioni sufficienti per la fattorizzazione LU
% 1. A deve essere simmetrica e definita positiva
% 2. A deve essere a dominanza streatta per righe
% 2. A deve essere a dominanza streatta per colonne

%% Metodo di Cholesky
% A deve essere SDP <=> esiste unica R triangolare superiore tale che A = R'R

A = [6  1  1; ...
     3  7  2; ...
     1  2  3];
R = chol(A);

% #operazioni fattorizzazione = n^3 / 3
% #operazioni risoluzione = 2 * n^2

%% Metodo di Thomas
% A deve essere tridiagonale e ammette fattorizzazione LU allora
%     | a_1 c_1   0 |        | 1   0   0 |       | γ_1 c_1 0   |
% A = | e_2 a_2 c_2 | => L = | β_2 1   0 | , U = | 0   γ_2 c_2 |
%     | 0   e_3 a_3 |        | 0   β_3 1 |       | 0   0   γ_3 |
%
% Dove γ_1 = a_1,
%      β_i = e_i / γ_i-1,
%      γ_i = a_i - β_i * c_i-1
%      per i = 2, 3, ..., n
%
% Posso poi risolvere il sistema Ax = b con due sostituzioni in avanti e 
% indietro semplificate

% #operazioni fattorizzazione = 3(n-1)
% #operazioni risoluzione = 2(n-1) + 3(n-1) + 1

A = [1 2 0 0; ...
     3 4 5 0; ...
     0 6 7 8; ...
     0 0 9 10];
b = [1; 2; 3; 4];

[L, U, x] = thomas(A, b);
assert(all(abs(x - (A \ b)) < 1e-10));

%% Funzioni %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fwsub -> in utils
% bksub -> in utils
% factorizable -> in utils
% thomas -> in utils