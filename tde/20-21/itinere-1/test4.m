% Sia data una matrice A =
% 5 −1 −1
% 0 4 −2
% 0 γ 3
% 
% dipendente da un parametro γ ∈ R
% con γ != −6. Si determinino i valori di tale parametro γ ∈ R tali per cui il metodo
% di Gauss–Seidel applicato alla soluzione di un sistema lineare A x = b converge
% per ogni scelta dell’iterata iniziale.

clc; clear;

% Criteri convergenza(sufficienti)

% A diagonale dominante per righe
% A SDP

% Criteri convergenza(necessari e sufficienti)

% Radice spettrale di I - (D - E)^-1 * A < 1

syms gamma

A = [5 -1    -1; ...
     0  4    -2; ...
     0  gamma 3;];

D = diag(diag(A));
E = -tril(A,-1);

eigen_values = eig(eye(3) - (D - E) \ A);
% eigen_values = [0, 0, -gamma/6];
% => abs(-gamme/6) < 1 => -6 < gamma < 6
