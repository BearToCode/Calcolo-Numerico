clc; clear;

pentadiag = @(values, n) ...
	diag(values(1) * ones(n-2, 1), -2) + ...
	diag(values(2) * ones(n-1, 1), -1) + ...
	diag(values(3) * ones(n,   1), 0) + ...
	diag(values(4) * ones(n-1, 1), 1) + ...
	diag(values(5) * ones(n-2, 1), 2);

% Si vuole risolvere il sistema lineare Ax = b 
% con il metodo del gradiente e del gradiente precondizionato, utilizzando come precondiziona-
% tore P la parte triangolare inferiore di A.

% 1. Utilizzando la funzione richardson.m implementata nel Laboratorio 06 (nel caso non
% stazionario), si risolva il sistema lineare per n = 5, 6, 7, . . . , 20 con entrambi i metodi. Si
% utilizzi una tolleranza di 10−6 e un numero massimo di iterazioni pari a 5000, partendo
% dal vettore x0 = [0, 0, . . . 0, 0]T ∈ Rn.

toll = 10^-6;
nmax = 5000;

n_values = 5:20;

i = 1;
K_p = zeros(length(n_values), 1);
K_I = zeros(length(n_values), 1);
cond_A = zeros(length(n_values), 1);

for n = n_values
	A = pentadiag([2 1 4 1 2], n);
	b = ones(n, 1);
	P = tril(A);
	x0 = zeros(n, 1);

	[x_I, k_I] = richardson(A, b, eye(n), x0, toll, nmax);
	[x_p, k_p] = richardson(A, b, P, x0, toll, nmax);

	K_I(i) = k_I;
	K_p(i) = k_p;
	cond_A(i) = cond(A);

	fprintf('n = %d\n', n);
	fprintf('Identità: %d iterazioni\n', k_I);
	fprintf('Precondizionato: %d iterazioni\n', k_p);
	fprintf('\n');

	i = i + 1;
end

% 2. Si rappresenti su un grafico in scala logaritmica l’andamento del numero di iterazioni
% in funzione di n.

% Fatto al punto 5.

% 3. Si rappresenti su un grafico il numero di condizionamento della matrice del sistema
% K2(A) in funzione di n.

figure;
plot(n_values, cond_A, 'g', 'LineWidth', 2);
xlabel('n');
ylabel('Condizionamento');
title('Condizionamento della matrice del sistema in funzione di n');
grid on;

%% Utilizzando la funzione Matlabr pcg, si risolvano i seguenti punti:

% 4. Risolvere il sistema lineare Ax = b per n = 5, 6, 7, . . . , 20 ponendo toll = 10−6 e
% nmax = 5000.

K_pcg = zeros(length(n_values), 1);

i = 1;

for n = n_values
	A = pentadiag([2 1 4 1 2], n);
	b = ones(n, 1);
	P = tril(A);
	x0 = zeros(n, 1);

	[x, ~, ~, k] = pcg(A, b, toll, nmax, eye(n), eye(n), x0);
	K_pcg(i) = k;
	fprintf('n = %d\n', n);
	fprintf('Numero di iterazioni: %d\n', k);
	fprintf('\n');
	i = i + 1;
end

% 5. Rappresentare su un grafico in scala logaritmica l’andamento del numero di iterazioni k
% in funzione di n. Confrontare sullo stesso grafico i risultati trovati utilizzando i metodi
% del gradiente, gradiente precondizionato e gradiente coniugato.

figure;
semilogy(n_values, K_I, 'r', 'LineWidth', 2);
hold on;
semilogy(n_values, K_p, 'b', 'LineWidth', 2);
semilogy(n_values, K_pcg, 'g', 'LineWidth', 2);
xlabel('n');
ylabel('Iterazioni');
legend('Identità', 'Precondizionato', 'Gradiente Coniugato');
title('Numero di iterazioni in funzione di n');
grid on;