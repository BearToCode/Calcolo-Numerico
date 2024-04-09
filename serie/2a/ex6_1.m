clc; clear;

tridiag = @(values, n) ...
	diag(values(1) * ones(n-1, 1),  1) + ...
	diag(values(2) * ones(n, 1), 0) + ...
	diag(values(3) * ones(n-1, 1), -1);

A = tridiag([-1, 2, -1], 10);

% 1. Sapendo che gli autovalori di A sono λ_j(A) = 2 + 2 cos(π j/n+1)
% per j = 1, . . . , n, dove
% λ1(A) > λ2(A) > · · · > λn(A), si stimi il numero di condizionamento spettrale K(A) di
% A in funzione di n per n → +∞.

tridiag_eig = @(n) 2 + 2 * cos(pi * (1:n) / (n+1));

% max_eig(n) = 2 + 2 * cos(pi * 1 / (n+1)); => 2 + 2 * cos(0) = 4
% min_eig(n) = 2 + 2 * cos(pi * n / (n+1)); => 2 + 2 * cos(pi) = 0
% cond = 4 / 0??

% Diverge?? WTF

% 2. Si utilizzi Matlab per calcolare K(A) in funzione di n, con n = 10, 20, 30, . . . , 100, e
% si confronti il risultato ottenuto con la stima precedente.

for i = 10:10:100
	A = tridiag([-1, 2, -1], i);
	K = cond(A);

	fprintf('n = %d\n', i);
	fprintf('K(A) = %f\n', K);
end

% 3. Quale metodo diretto è computazionalmente conveniente utilizzare per risolvere il si-
% stema lineare A x = b assegnato? Si motivi la risposta data riportando il nume-
% ro di operazioni impiegate da tale metodo in funzione di n. Perché tale metodo è
% computazionalmente più conveniente rispetto al metodo della fattorizzazione LU?

% Metodo di Thomas
flops = @(n) 8 * n - 7;

% 4. Sempre per la matrice A tridiagonale assegnata, si illustri un possibile algoritmo com-
% putazionalmente conveniente per il calcolo del determinante di A. Si riporti il numero
% di operazioni impiegate dall’algoritmo proposto in funzione di n

A_det = prod(tridiag_eig(10));
fprintf('Determinante di A = %f\n', A_det);