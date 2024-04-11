%% Metodo iterativo in forma generale

% X_k+1 = B * X_k + g

%% Teorema di condizione necessaria e sufficiente per la convergenza

% Il metodo interativo converge se e solo se il raggio spettrale di B è minore di 1

%% Metodi iterativi per decomposizione additiva

% A = P + (A - P), P invertibile
% => Ax = b, (P + (A - P))x = b, Px + (A - P)x = b
% => Px = (P - A)x + b                                  (a)
% => x = P^-1(P - A)x + P^-1b

% Sostituendo B = P^-1(P - A) e g = P^-1b, si ottiene il metodo iterativo
% X_k+1 = B * X_k + g

%% Metodo di Jacobi

% P_jacobi = diag(A)

% Per evitare di calcolare l'inversa di P, uso la forma (a)
% del metodo iterativo. Divido per per le componenti diagonali

% Dx_k+1 = (D - A)x_k + b
% Con D = diag(a_11, a_22, ..., a_nn)

% La matrice di iterazione è B = D^-1(D - A)

% Converge <=> raggio spettrale di B < 1
% Stima errore: ||e_k|| = rho^k * ||e_0||
% OPPURE:       ||e_k|| <= K2(A) * res_k

% Esempio

A = [1 0 0;
     4 2 0;
     0 5 3];
b = [1; 1; 1];

x0 = [0; 0; 0];
toll = 1e-6;
nmax = 1000;

[x, ~] = jacobi(A, b, x0, toll, nmax);

assert(all(abs(A \ b - x) < toll));

%% Teorema di cond. sufficienti per la convergenza del metodo di Jacobi

% Se A è una matrice diagonale dominante stretta per righe, allora il metodo converge

%% Metodo di Gauss-Seidel

%     | a_11 0    0    |   | 0     0     0 |   | 0 -a_12 -a_13 |
% A = | 0    a_22 0    | - | -a_21 0     0 | - | 0 0     -a_23 |
%     | 0    0    a_33 |   | -a_31 -a_32 0 |   | 0 0     0     |
%            D                     E                    F

% P_gs = D - E <== triangolare inferiore

% x_k+1 = (D - E)^-1 * A * x_k + b

% La matrice di iterazione è B = I - T^-1 * A
% Con T = D - E = tril(A)

% Converge <=> raggio spettrale di B < 1
% Stima errore: ||e_k|| <= rho^k * ||e_0||
% OPPURE:       ||e_k|| <= K2(A) * res_k

% Esempio

A = [1 0 0;
	 4 2 0;
	 0 5 3];
b = [1; 1; 1];

x0 = [0; 0; 0];
toll = 1e-6;
nmax = 1000;

[x, ~] = gs(A, b, x0, toll, nmax);

assert(all(abs(A \ b - x) < toll));

%% Teorema di cond. sufficienti per la convergenza del metodo di Gauss-Seidel

% 1. Se A è una matrice diagonale dominante per righe, allora il metodo converge
% 2. Se A è simmetrica e definita positiva, allora il metodo converge

%% Metodi di Richardson (precondizionati)

% Dato precondizionatore P, si può scrivere la matrice di iterazione come:
% Se stazionario: B_a = I - a * P^-1 * A
% Se dinamico: B_k = I - a_k * P^-1 * A

%% Convergenza di Richardson stazionario

% Data A non singolare, il metodo di Richardson converge se:
% a|λ_i(P^-1 * A)| < 2 Re(λ_i(P^-1 * A)), per ogni i = 1, ..., n

% Se A e P sono SDP, allora λ_i(P^-1 * A) sono reali e positivi, quindi
% il metodo converge se 0 < a < 2 / λ_max(P^-1 * A) 

%% Richardson dinamico (Metodo del gradiente)

% a dipende da k secondo la formula:
% a_k = (r_k^T * r_k) / (r_k^T * A * r_k)

%% Teorema di convergenza del metodo del gradiente

% Il metodo del gradiente PRECONDIZIONATO converge (per A SDP) per qualsiasi scelta x_0 e vale
% ||e_k||A <= d^k ||e_0||A, cond d = (K(P^-1 * A) - 1) / (K(P^-1 * A) + 1

%% Metodo del gradiente coniugato

% Imponiamo che la nuova direzione di discesa sia ortogonale a tutte le precedenti.
% Non rientra nella categoria dei metodi di Richardson.
% Converge al più in n iterazioni, dove n è la dimensione di A.

C = @(P) (sqrt(cond(P^-1 * A)) - 1) / (sqrt(cond(P^-1 * A)) + 1);
% ||e^k|| <= (2* C^k) / (1 + c^2k) ||e^0||

%% Funzioni %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% norma della matrice A (norma dell'energia)
norm_A = @(x) sqrt(x' * A * x);

% jacobi -> in utils
% gs -> in utils