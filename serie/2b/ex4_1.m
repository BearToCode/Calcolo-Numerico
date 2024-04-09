clear; clc;

% Si consideri il sistema lineare A x = b, dove A è una matrice pentadiagonale
% A = pentadiag(1, −2, 6, −2, 1) ∈ Rn×n
% e x, b ∈ Rn per n ≥ 1. Si considerino in particolare n = 300 e il termine noto b tale che la
% soluzione esatta sia x = 1

n = 300;
A = mdiag([1, -2, 6, -2, 1], n);

x_exact = ones(n, 1);
b = A * x_exact;

% 1. I metodi di Jacobi e Gauss–Seidel, applicati al sistema lineare Ax = b, risultano con-
% vergenti per ogni scelta dell’iterata iniziale x(0)? Si motivi la risposta definendo tutta
% la notazione utilizzata e riportando i principali comandi Matlabr usati.

%💡 I metodi iterativi convergon se il raggio spettrale della matrice di iterazione è minore di 1

% Jacobi

D = diag(diag(A));
B_jacobi = D \ (D - A);

jacobi_spectral_radius = max(abs(eig(B_jacobi)));
assert(jacobi_spectral_radius < 1);

% Gauss-Seidel

T = tril(A);
B_gauss_seidel = T \ (T - A);

gauss_seidel_spectral_radius = max(abs(eig(B_gauss_seidel)));
assert(gauss_seidel_spectral_radius < 1);

% 2. Dopo aver risposto al Punto 1), quale dei due metodi iterativi utilizzereste per risolvere
% il sistema lineare Ax = b? Si motivi la risposta data.

if gauss_seidel_spectral_radius < jacobi_spectral_radius
  fprintf('Uso Gauss-Seidel\n');
else
  fprintf('Uso Jacobi\n');
end

% => Uso Gauss-Seidel

% 3. Si applichi il metodo iterativo individuato al Punto 2) per risolvere il sistema lineare
% Ax = b usando la funzione Matlabr .m corrispondente. Si consideri l’iterata iniziale
% x(0) = b, la tolleranza sul criterio d’arresto tol = 10−6 e il numero massimo di iterazioni
% nmax=1000.
% Si riportino: i) il numero di iterazioni Nit effettuate; ii) il valore dell’errore relativo e(Nit)rel ;
% iii) il valore del residuo normalizzato r(Nit) norm corrispondente. Si riportino i principali
% comandi Matlabr utilizzati.
% Infine, si fornisca la stima dell’errore ottenuto a partire dal residuo normalizzato r(Nit) norm
% e lo si confronti con l’errore relativo e(Nit) rel.

x0 = b;
tol = 1e-6;
nmax = 1000;
[x, k] = gs(A, b, x0, tol, nmax);

e_rel = norm(x - x_exact) / norm(x_exact);
r_norm = norm(A * x - b) / norm(b);

% errore stimato: ‖e‖ <= K(A) * ‖r‖
e_approx = cond(A) * r_norm;

fprintf('Numero di iterazioni: %d\n', k);
fprintf('Errore relativo: %d\n', e_rel);
fprintf('Residuo normalizzato: %d\n', r_norm);
fprintf('Errore stimato: %d\n', e_approx);

% 4. Si consideri ora il metodo del gradiente per la soluzione del sistema lineare con la
% matrice A. Senza applicare esplicitamente l’algoritmo, si stimi l’errore in norma A,
% ovvero ‖x(k) − x‖_A, dopo k = 20 iterazioni del metodo, sempre considerando x(0) = b.
% Si giustifichi la risposta data definendo tutta la notazione utilizzata.

%💡 ‖e_k‖_A <= d^k ‖e_0‖_A
%   d = (K(A) - 1) / (K(A) + 1)
%   ‖v‖_A = sqrt(v' * A * v)

it = 20;

d = (cond(A) - 1) / (cond(A) + 1);
e0 = x0 - x_exact;
e_approx = d^it * sqrt(e0' * A * e0);

fprintf('Errore stimato dopo 20 iterazioni: %f\n', e_approx);

% 5. Si consideri ora il metodo del gradiente precondizionato per risolvere il sistema li-
% neare associato alla matrice A. In particolare, si consideri la seguente matrice di
% precondizionamento simmetrica e definita positiva:
% P = tridiag ( −1, β, −1 ) ∈ R300×300,
% dipendente dal parametro β > 0. Per quale valore del parametro β a scelta tra 2, 3, 4 e
% 5, il metodo del gradiente precondizionato converge più rapidamente alla soluzione per
% ogni scelta dell’iterata iniziale?

% La velocità di convergenza del metodo del gradiente precondizionato dipende dal numero di condizionamento di P^-1 * A
% Più il numero di condizionamento è basso, più il metodo converge rapidamente

B_values = [2, 3, 4, 5];
cond_values = zeros(1, length(B_values));
d_values = zeros(1, length(B_values));

i = 1;
for beta = B_values
  P = mdiag([-1, beta, -1], n);
  M = P \ A;
  cond_M = K(M);
  cond_values(i) = cond_M;
  d_values(i) = (cond_M - 1) / (cond_M + 1);
  fprintf('Beta: %d, cond(M): %d\n', beta, cond_M);

  i = i + 1;
end


plot(B_values, d_values);
xlabel('Beta');
title('d in funzione di Beta');
grid on;

legend('d(Beta)');

% 6. Si consideri ora il metodo del gradiente coniugato (non precondizionato) per risolvere il
% sistema lineare A x = b, usando opportunamente la funzione Matlab pcg con vettore
% iniziale x(0) = b, tolleranza tol = 10−6 e un opportuno numero massimo di iterazioni.
% Si risolva il problema e si riportino: i) il numero di iterazioni effettuate Nit e ii) l’errore
% ‖x(Nit) − x‖_A corrispondente

x0 = b;
max_iter = 1000;

% Il vettore vuoto => nessun precondizionamento
[x_pcg, ~, ~, k_pcg] = pcg(A, b, 1e-6, max_iter, [], [], x0);

err_pcg = sqrt((x_pcg - x_exact)' * A * (x_pcg - x_exact));

fprintf('Numero di iterazioni: %d\n', k_pcg);
fprintf('Errore: %d\n', err_pcg);
