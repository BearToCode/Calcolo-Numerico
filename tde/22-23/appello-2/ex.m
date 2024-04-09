clear; clc;

% Si consideri il sistema lineare A x = b, dove A ∈ Rn×n `e una matrice simmetrica
% e definita positiva, e x, b ∈ Rn per n ≥ 1.
% In particolare, poniamo n = 100, A corrispondente alla seguente matrice pen-
% tadiagonale
% A = pentadiag ( 1, −4, 6, −4, 1 ) ∈ R100×100,
% mentre b ∈ R100 tale per cui la soluzione esatta del sistema lineare `e x = 1 ∈ R100.

n = 100;
A = mdiag([1 -4 6 -4 1], n);
x_exact = ones(n, 1);
b = A * x_exact;

% 1. Si assegni la matrice A in Matlab e si verifichi che A è simmetrica e definita
% positiva. Inoltre, si calcoli il suo numero di condizionamento spettrale K(A), dopo
% averne dato definizione. Si giustifichi la risposta data riportando tutti i valori
% numerici necessari a giustificare la risposta e i comandi Matlabr usati.

assert(sdp(A));
A_cond = cond(A, 2);

fprintf('Il numero di condizionamento spettrale di A è %e\n', A_cond);

% 2. • Si scriva il problema di minimo associato alla funzione Φ : Rn → R cor-
% rispondente alla soluzione del sistema lineare A x = b di cui sopra.
% • Si riportino il valore di Φ nel punto di minimo e il punto di minimo;.
% • Si indichino con d_i ∈ R100, per i = 1, 2, le direzioni di discesa della funzione
% Φ rispettivamente nei punti y1 = b ∈ R100 e y2 = 3 ∈ R100; per quale delle
% due direzioni i = 1, 2, la norma ‖di‖ `e inferiore?

phi = @(y) 1/2 * y' * A * y - y' * b;
grad_phi = @(y) A * y - b;
dir_discesa = @(y) -grad_phi(y);

phi_min = phi(x_exact);
fprintf('Il valore di phi nel punto di minimo è %e\n', phi_min);
fprintf('Il punto di minimo è x = [1; 1; ...; 1]\n');

y1 = b;
y2 = 3 * ones(n, 1);

d1 = dir_discesa(y1);
d2 = dir_discesa(y2);

norm_d1 = norm(d1);
norm_d2 = norm(d2);

fprintf('La norma della direzione di discesa in y1 è %e\n', norm_d1);
fprintf('La norma della direzione di discesa in y2 è %e\n', norm_d2);

% 3. Si consideri il metodo del gradiente precondizionato per la soluzione del sistema
% lineare indicato con la matrice di precondizionamento seguente:
% P = tridiag ( −1, 2, −1 ) ∈ R100×100.
% Senza applicare esplicitamente l’algoritmo, si stimi il numero di iterazioni k_min
% necessarie a tale metodo iterativo affinché l’errore in norma A si riduca di un
% fattore inferiore a tol = 10−2, ovvero tale che ‖x(kmin) − x‖A / ‖x(0) − x‖A < tol.
% Qual è il valore stimato di ‖x(k_min) − x‖A se x(0) = b? 

P = mdiag([-1 2 -1], n);

% La velocità di convergenza del metodo del gradiente precondizionato dipende dal numero di 
% condizionamento SPETTRALE di P^-1 * A.
% Più il numero di condizionamento è basso, più il metodo converge rapidamente.
% Nello specifico, ||err(k)||_A <= d^k * ||err(0)||_A, dove d è il fattore di riduzione dell'errore.
% d = (cond_s(P^-1 * A) - 1) / (cond_s(P^-1 * A) + 1)

d = (K(P \ A) - 1) / (K(P \ A) + 1);

tol = 1e-2;
k_min = ceil(log(tol) / log(d));
fprintf('Il numero di iterazioni minimo è %d\n', k_min);

err_k_min = d^k_min * normA(b - x_exact, A);
fprintf('Il valore stimato di ||x(k_min) - x||_A è %e\n', err_k_min);

% 4. Per la matrice A e il vettore b assegnati, si applichi il metodo del gradiente precon-
% dizionato implementato nella funzione Matlab richardson.m usando la tolleranza
% sul criterio d’arresto basato sul residuo normalizzato tol = 10−2, il numero mas-
% simo di iterazioni pari a 10^5 e l’iterata iniziale x(0) = b; si consideri la matrice di
% precondizionamento P del Punto 3). Si riportino: i comandi Matlab usati, il nu-
% mero N di iterazioni effettuate, la prima componente della soluzione approssimata
% (x^(N))_1 e il valore del residuo normalizzato r^(N)_norm = ‖r(N)‖ / ‖b‖.

tol = 1e-2;
nmax = 1e5;
x0 = b;

[x, k] = richardson(A, b, P, x0, tol, nmax);

fprintf('Il numero di iterazioni effettuate è %d\n', k);
fprintf('La prima componente della soluzione approssimata è %e\n', x(1));
r_norm = norm(b - A * x) / norm(b);
fprintf('Il valore del residuo normalizzato è %e\n', r_norm);

% 5. Si consideri il metodo del gradiente coniugato applicato alla soluzione del sistema
% lineare A x = b assegnato a partire dal vettore iniziale x(0) = b. Si riportino:
% • le norme delle direzioni di discesa dell’algoritmo ‖p(0)‖, ‖p(1)‖, ‖p(2)‖;
% • i valori dei parametri dinamici α0, α1 e α2 dell’algoritmo;
% • gli errori relativi ‖x(k) − x‖A / ‖x(0) − x‖A effettivamente commessi, per k = 1, 2, 3.

[xk, pk, ak] = conjgrad(A, b, x0, 5, 0);

p0 = pk(:, 1);
p1 = pk(:, 2);
p2 = pk(:, 3);

a0 = ak(1);
a1 = ak(2);
a2 = ak(3);

err1 = normA(xk(:, 2) - x_exact, A) / normA(x0 - x_exact, A);
err2 = normA(xk(:, 3) - x_exact, A) / normA(x0 - x_exact, A);
err3 = normA(xk(:, 4) - x_exact, A) / normA(x0 - x_exact, A);

fprintf('La norma della direzione di discesa in p(0) è %e\n', norm(p0));
fprintf('La norma della direzione di discesa in p(1) è %e\n', norm(p1));
fprintf('La norma della direzione di discesa in p(2) è %e\n', norm(p2));

fprintf('Il valore di alpha0 è %e\n', a0);
fprintf('Il valore di alpha1 è %e\n', a1);
fprintf('Il valore di alpha2 è %e\n', a2);

fprintf("L'errore relativo commesso in k = 1 è %e\n", err1);
fprintf("L'errore relativo commesso in k = 2 è %e\n", err2);
fprintf("L'errore relativo commesso in k = 3 è %e\n", err3);

% 6. Si applichi la decomposizione ai valori singolari alla matrice A ∈ R100×100
% fornita in precedenza, utilizzando opportunamente il comando Matlab svd.
% • Posto k = 25, si assembli la matrice A25 ∈ R100×100 e si riportino i valori
% (A_25)11, (A_25)12 e (A_25)22; si calcoli l’errore relativo ‖A − A_25‖2 / ‖A‖2
% associato.
% • Si stimi il valore dell’indice r ≤ n = 100 tale per cui l’approssimazione Ar
% di A `e tale che ‖A − A_r‖2 / ‖A‖2 < 10−1.

[U, S, V] = svd(A);
k = 25;

A_25 = svdapprox(U, S, V, k);

A_25_11 = A_25(1, 1);
A_25_12 = A_25(1, 2);
A_25_22 = A_25(2, 2);

err_A_25 = norm(A - A_25, 2) / norm(A, 2);

fprintf('Il valore di (A_25)11 è %e\n', A_25_11);
fprintf('Il valore di (A_25)12 è %e\n', A_25_12);
fprintf('Il valore di (A_25)22 è %e\n', A_25_22);
fprintf("L\'errore relativo commesso è %e\n", err_A_25);

% L’errore relativo commesso in tale approssimazione è ‖A − A_k‖2 / ‖A‖2 = σ_k+1 / σ_1.
% I valori singolari sono le singole componenti della matrice S, ordinati in modo decrescente.

tol = 1e-1;
singular_values = diag(S);
r = 0;

for sigma=1:100
    r = r + 1;
    err_A_sigma = singular_values(sigma + 1) / singular_values(1);
    if err_A_sigma < tol
        break;
    end
end

fprintf('Il valore di r è %d\n', r);

% Si consideri ora la seguente funzione Φ : R → R, dove
% Φ(y) = 1/2 ( y^2 + e^y^2 ) − y.
% Si vuole trovare il valore x ∈ R tale che Φ(x) assume valore minimo. Sapendo che
% F(x) = dΦ/dy (x) = 0 `e un’equazione non lineare con F : R → R, si approssimi x
% usando opportunamente il metodo di Newton.
% Si riportino i valori della prima, seconda e terza iterata, ovvero x(1), x(2) e x(3), ottenute
% applicando il metodo di Newton a partire dal vettore iniziale x(0) = 0;

syms y;
sym_phi = 1/2 * (y^2 + exp(y^2)) - y;
sym_F = diff(sym_phi, y);
sym_dF = diff(sym_F, y);

F = matlabFunction(sym_F);
dF = matlabFunction(sym_dF);
x0 = 0;

[xvect] = newton(x0, 3, 0, F, dF);

x1 = xvect(2);
x2 = xvect(3);
x3 = xvect(4);

fprintf('Il valore della prima iterata è %e\n', x1);
fprintf('Il valore della seconda iterata è %e\n', x2);
fprintf('Il valore della terza iterata è %e\n', x3);