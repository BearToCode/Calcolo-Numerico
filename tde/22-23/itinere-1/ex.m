clc; clear;

% Si consideri il sistema lineare A x = b, dove A ∈ Rn×n `e una matrice simmetrica
% e definita positiva, e x, b ∈ Rn per n ≥ 1. In particolare, si pongano: n = 225,
% A ∈ R225×225 assegnata con il comando Matlabr seguente

n = 225;
A = full(gallery('poisson', 15));
b = ones(n, 1) * 2;

% 1. Si verifichi che la matrice A `e simmetrica e definita positiva giustificando tutti i
% passaggi. Quale metodo diretto `e computazionalmente conveniente applicare per
% risolvere il sistema lineare Ax = b assegnato? Si giustifichi dettagliatamente la
% risposta e si riporti in numero di operazioni stimato.

assert(sdp(A), 'A non è definita positiva');

% Conviene applicare la fattorizzazione di Cholesky, in quanto A è simmetrica e
% definita positiva. La fattorizzazione di Cholesky ha complessità O(n^3/3)

n_fact = n^3 / 3;
n_op = 2 * n^2; 
n_tot = n_fact + n_op;
fprintf('Numero di operazioni stimato: %d\n', n_tot);

% 2. Punto 2) — 3 pt
% Si applichi tramite Matlab il metodo diretto di cui al Punto 1) alla soluzione del
% sistema lineare Ax = b riportando tutti i passaggi svolti. Dopo aver ottenuto la
% soluzione numerica x ∈ Rn, si stimi laerrore relativo ottenuto erel = ‖x −̂ x‖ / ‖x‖
% Si definisca tutta la notazione usata e si riportino tutti i comandi Matlab utilizzati.

R = chol(A);
y = fwsub(R', b);
x = bksub(R, y);

A_cond = cond(A);
res = norm(b - A * x);
err_rel = A_cond * res / norm(b);

fprintf('Condizionamento di A: %e\n', A_cond);
fprintf('Errore relativo: %e\n', err_rel);

% 3. Si consideri ora il metodo di Jacobi per la soluzione del sistema lineare Ax = b.
% Si verifichi che il metodo di Jacobi converge per ogni scelta dell’iterata iniziale
% x(0) ∈ Rn e, senza applicare il metodo, si stimi il fattore di abbattimento dell’errore
% ‖x(k) − x‖ / ‖x(0) − x‖ dopo k = 100 iterazioni del metodo. Si motivi dettagliatamente la
% risposta, definendo la notazione e riportando i comandi Matlab usati.

D = diag(diag(A));
B = D^-1 * (D - A);
assert(max(abs(eig(B)) < 1), 'Il metodo di Jacobi non converge');

k = 100;
norm2 = norm(B, 2);
abbattimento = norm2^k;

fprintf('Fattore di abbattimento: %f\n', abbattimento);

% 4. Si consideri ora il metodo del gradiente per la soluzione del sistema lineare Ax = b
% a cui `e associata la funzione energia Φ : Rn → R, dove Φ(y) := 1/2 y^T A y − y^ T b.
% Scelta l’iterata inziale x(0) = b, si calcolino e si riportino i valori Φ(x(0)) e
% Φ(x(1)), essendo x(1) l’iterata ottenuta applicando un’iterazione del metodo del
% gradiente.

phi = @(y) 1/2 * y' * A * y - y' * b;

x0 = b;
toll = 1e-6;
P = eye(n);

[x1] = richardson(A, b, P, x0, toll, 1);

phi_x0 = phi(x0);
phi_x1 = phi(x1);

fprintf('Valore di phi(x0): %f\n', phi_x0);
fprintf('Valore di phi(x1): %f\n', phi_x1);

% 5. Si consideri ora il metodo del gradiente precondizionato con matrici di precon-
% dizionamento P1 = tridiag( −1, 4, −1 ) ∈ Rn×n e P2 ∈ Rn×n ottenuta tramite i seguenti comandi Matlab :
% >> R2 = ichol( sparse( A ) ); P2 = R2’ * R2;
% Senza applicare esplicitamente il metodo, si determini per quale delle due ma-
% trici di precondizionamento il metodo del gradiente precondizionato converge più 
% rapidamente a x per ogni scelta di x(0). Per la matrice di precondizionamento per 
% cui il metodo converge pi`u rapidamente, si stimi il fattore di abbattimento 
% dell’errore ‖x(k) − x‖A / ‖x(0) − x‖A
% dopo k = 20 iterazioni del metodo. Si motivi dettagliatamente la risposta, definendo la no-
% tazione e riportando i comandi Matlabr usati.

P1 = mdiag([-1, 4, -1], n);
R2 = ichol(sparse(A));
P2 = R2' * R2;

cond_2 = @(A) sqrt(max(abs(eig(A' * A))) / min(abs(eig(A' * A)))); % Uguale a cond
% Se SDP = rapporto lambda max e min

d = @(P) (cond_2(P^-1 * A) - 1) / (cond_2(P^-1 * A) + 1);

d1 = d(P1);
d2 = d(P2);

fprintf('Fattore di abbattimento P1: %f\n', d1);
fprintf('Fattore di abbattimento P2: %f\n', d2);

if d1 < d2
    P = P1;
else
    P = P2;
end

% cond2 = @(A) sqrt(max(eig(A' * A)) / min(eig(A' * A))); == cond(A, 2)

abbattimento = d(P)^20;
fprintf('Fattore di abbattimento: %f\n', abbattimento); % FIXME: fatt. abb. con P2 = 0.0188


% 6. Si consideri il metodo delle potenze per approssimare l’autovalore λ1(A). Si ap-
% plichi il metodo, a partire dall’iterata iniziale x(0) = 1 ∈ Rn, modificando op-
% portunamente la funzione eigpower.m per stimare l’ordine e il fattore di conver-
% genza asintotico ottenuti applicando tale metodo iterativo. Si riportino i comandi
% Matlabr usati e si giustifichi il risultato ottenuto.

x0 = ones(n, 1);
tol = 1e-6;
nmax = 1000;

[~, ~, ~, lambda_vect] = eigpower(A, tol, nmax, x0);
stimap(lambda_vect);

% 7. QR con shift

[eigs1] = qrshift(A, 1e-6, 1);
[eigs2] = qrshift(A, 1e-6, 2);
[eigs20] = qrshift(A, 1e-6, 20);

eig2_1 = eigs1(2);
eig2_2 = eigs2(2);
eig2_20 = eigs20(2);

fprintf('Autovalore 2° - 1: %f\n', eig2_1);
fprintf('Autovalore 2° - 2: %f\n', eig2_2);
fprintf('Autovalore 2° - 20: %f\n', eig2_20);
