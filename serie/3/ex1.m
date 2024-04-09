clear; clc;

% 1. 1. Costruire una matrice di connessione A ∈ R100×100 (dove N = 100 rappresenta il numero
% di pagine) che soddisfa la proprietà:
% a_ij = 1 / #p_j se esiste un link dalla pagina p_j alla pagina p_i 
% a_ij = 0 altrimenti.
% dove #p_j è il numero di link presenti sulla pagina p_j
%
% (Suggerimento: scrivere una matrice di elementi ai,j = 0, 1 dove uno indica l’esistenza
% di un link dalla pagina pj alla pagina pi e zero l’assenza di link. Se non si vuole studiare
% un caso reale, questa matrice pu`o essere generata in modo casuale tramite la funzione
% Matlabr randi. Successivamente modificare A (normalizzando le colonne) in modo
% che rispetti la proprietà).

N = 100;
A = randi([0,1], N, N);
for i = 1:N
    if sum(A(:,i)) > 0
        A(:,i) = A(:,i) / sum(A(:,i));
    end
end

% 2. Costruire una matrice di connessione B ∈ R5×5 relativa a 5 pagine web rappresentato
% in Fig. 2 (si segua il suggerimento al punto precedente).

B = [0   0   0   1   0  ;
	 1   0   0   0   0  ;
	 0   1   0   0   0  ;
	 0   1   0   0   1  ;
	 1   1   1   1   0  ;];
for i = 1:5
	if sum(B(:,i)) > 0
		B(:,i) = B(:,i) / sum(B(:,i));
	end
end

% 4. Tramite la funzione eigpower si verifichi che A e B ammettono 1 come autovalore di
% modulo massimo e si calcoli il corrispondente autovettore (PageRank). Si assuma una
% tolleranza di 10−6, un numero massimo di iterazioni pari a 100 ed un vettore iniziale
% x(0) = (1/N, 1/N, . . . 1/N )T 

tol = 10^-6;
max_iter = 100;

[lambda_A, v_A, iter_A] = eigpower(A, tol, max_iter, ones(N,1) / N);
[lambda_B, v_B, iter_B] = eigpower(B, tol, max_iter, ones(5,1) / 5);