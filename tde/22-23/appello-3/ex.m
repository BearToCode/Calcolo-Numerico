clc; clear;

% Si consideri il sistema lineare A x = b, dove A `e una matrice pentadiagonale
% A = pentadiag(3, −1, 8, −1, 3) ∈ R500×500
% e x, b ∈ R500. Si consideri in particolare il termine noto b tale che la soluzione
% esatta sia x = 1 ∈ R500.

n = 500;
A = mdiag([3 -1 8 -1 3], n);
x_exact = ones(n, 1);
b = A * x_exact;

% 1. I metodi di Jacobi e Gauss–Seidel, applicati al sistema lineare Ax = b, risultano
% convergenti per ogni scelta dell’iterata iniziale x(0)? Si motivi la risposta definendo
% tutta la notazione utilizzata e riportando i principali comandi Matlabr usati.
% Quale dei due metodi iterativi utilizzereste per risolvere il sistema lineare? Si
% motivi la risposta data alla luce della teoria.

B_jacobi = diag(diag(A))^-1  * (diag(diag(A)) - A);
B_gs = eye(n) - tril(A)^-1 * A;

spectral_radius_jacobi = max(abs(eig(B_jacobi)));
spectral_radius_gs = max(abs(eig(B_gs)));

fprintf('Raggio spettrale di Jacobi: %f\n', spectral_radius_jacobi); % => 0.999936
fprintf('Raggio spettrale di Gauss-Seidel: %f\n', spectral_radius_gs); % => 0.587801

% Convergono entrambi, anche se Gauss-Seidel converge più velocemente.

% 2. Si applichi il metodo iterativo selezionato al Punto 1) per risolvere il sistema lineare
% Ax = b usando la funzione Matlab corrispondente. Si consideri l’iterata
% iniziale x(0) = b, la tolleranza sul criterio d’arresto tol = 10−6 e il numero massimo
% di iterazioni nmax=1000.
% Si riportino: i) il numero di iterazioni Nit effettuate; ii) il valore dell’errore
% relativo e(Nit)_rel ; iii) il valore del residuo normalizzato r(Nit) norm corrispondente.
% Infine, si fornisca la stima dell’errore relativo ottenuta a partire dal residuo
% normalizzato r(Nit)
% norm e la si confronti con l’errore relativo e(Nit)
% rel.

x0 = b;
tol = 1e-6;
nmax = 1000;

[x_gs, it_gs] = gs(A, b, x0, tol, nmax);
err_rel = norm(x_gs - x_exact) / norm(x_exact);
res_norm = norm(A * x_gs - b) / norm(b);

err_exp = res_norm * K2(A);

fprintf('Numero di iterazioni: %d\n', it_gs);
fprintf('Errore relativo: %e\n', err_rel);
fprintf('Residuo normalizzato: %e\n', res_norm);
fprintf('Stima errore relativo: %e\n', err_exp);

% 3. Si consideri ora il metodo del gradiente per la soluzione del sistema lineare con la
% matrice A simmetrica e definita positiva. Senza applicare esplicitamente l’algoritmo,
% si stimi l’errore in norma A, ovvero ‖x(k) −x‖A, dopo k = 50 iterazioni del metodo,
% sempre considerando x(0) = b. Si giustifichi la risposta data definendo tutta la
% notazione utilizzata.

k = 50;

% Precondizionamento (in questo caso non necessario)
P = eye(n);

% Fattore di abbattimento
d = @(A, P) (K2(P^-1 * A) - 1) / (K2(P^-1 * A) + 1);

err0 = normA(x0 - x_exact, A);

err_exp = d(A, P)^k * err0;

fprintf('Stima errore relativo con gradiente: %f\n', err_exp);


% 4. Si consideri ora il metodo del gradiente precondizionato per risolvere il sistema
% lineare associato alla matrice A. In particolare, si consideri la seguente matrice di
% precondizionamento simmetrica e definita positiva:
% P = tridiag ( −1, β, −1 ) ∈ R500×500,
% dipendente dal parametro β > 0. Per quale valore del parametro β a scelta tra 10,
% 12, 14, 16 e 18, il metodo del gradiente precondizionato converge piu' rapidamente
% alla soluzione per ogni scelta dell’iterata iniziale x(0)?

beta_values = [10, 12, 14, 16, 18];
d_values = zeros(1, length(beta_values));

i = 1;
for beta = beta_values
    P = mdiag([-1 beta -1], n);
    d = (K(P^-1 * A) - 1) / (K(P^-1 * A) + 1);
    d_values(i) = d;

    i = i + 1;
end

min_d = min(d_values);
min_beta = beta_values(d_values == min_d);

fprintf('Il valore di beta che minimizza il fattore di abbattimento è %d con d = %f\n', min_beta, min_d);

% 5. Si definisca un algoritmo computazionalmente efficiente per stimare il numero di
% condizionamento spettrale K(A) della matrice A che preveda l’uso dei metodi delle
% potenze e potenze inverse. Si riporti inoltre il numero di operazioni effettuato per
% l’approssimazione di K(A) con l’algoritmo proposto.

K_approx = @(A, tol, nmax, x0) eigpower(A, tol, nmax, x0) / invpower(A, tol, nmax, x0);
tol = 1e-6;
nmax = 1000;
x0 = ones(n, 1);
err = K_approx(A, tol, nmax, x0) - K(A);

% 6. Si consideri il metodo delle iterazioni QR per l’approssimazione degli autovalori di
% A. Si utilizzi opportunamente la funzione Matlabr qrbasic.m per approssimare
% l’autovalore λ2(A). Si riportino i valori delle approssimazioni λ(1)_2 , λ(2)_2 e λ(100)_2 

lambda_approx_1 = qrbasic(A, 0, 1);
lambda_approx_2 = qrbasic(A, 0, 2);
lambda_approx_100 = qrbasic(A, 0, 100);

fprintf('Autovalore approssimato con 1 iterazione: %f\n', lambda_approx_1(2));
fprintf('Autovalore approssimato con 2 iterazioni: %f\n', lambda_approx_2(2));
fprintf('Autovalore approssimato con 100 iterazioni: %f\n', lambda_approx_100(2));

% 7. Si consideri il metodo delle potenze inverse per approssimare l’autovalore λ500(A).
% Si applichi il metodo, a partire dall’iterata iniziale x(0) = 1 ∈ R500, modificando
% opportunamente la funzione invpower.m per stimare l’ordine e il fattore di con-
% vergenza asintotico ottenuti applicando tale metodo iterativo per 100 iterazioni.

x0 = ones(n, 1);

[~, ~, ~, lambdavec] = invpower(A, 0, 100, x0);
stimap(lambdavec);