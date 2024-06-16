% Si consideri il sistema lineare A x = b, dove A ∈ Rn×n `e una matrice simmetrica
% e definita positiva, e x, b ∈ Rn per n ≥ 1.
% In particolare, poniamo n = 100, A corrispondente alla seguente matrice pen-
% tadiagonale
% A = pentadiag ( 1, −11, 20, −11, 1 ) ∈ R100×100,
% mentre b ∈ R100 tale per cui la soluzione esatta del sistema lineare `e x = 2 ∈
% R100.

n = 100;
A = mdiag([1, -11, 20, -11, 1], n);
x_exact = 2 * ones(n, 1);
b = A * x_exact;

% 1. Si assegni la matrice A in Matlabr e si verifichi che A è simmetrica e definita
% positiva. Inoltre, si calcoli il suo numero di condizionamento spettrale K(A), dopo
% averne dato definizione. Si giustifichi la risposta data riportando valori numerici
% laddove necessario.

assert(sdp(A));
A_cond = K(A);

% 2. Si scriva il problema di minimo associato alla funzione Φ : Rn → R cor-
% rispondente alla soluzione del sistema lineare A x = b di cui sopra.
% Si riportino, oltre ai comandi Matlab: il valore di Φ nel punto di minimo
% e il punto di minimo; la norma ‖d‖ della direzione di discesa d ∈ R100 della
% funzione Φ nel punto y = 1∈R100.

phi = @(y) 1/2 * y' * A * y - y' * b;
grad_phi = @(y) A * y - b;
dir_discesa = @(y) -grad_phi(y);

fprintf("Il punto di minimo è x = [2; 2; ...; 2]\n");
phi_min = phi(x_exact);
fprintf("Il valore di phi nel punto di minimo è %e\n", phi_min);

y = ones(n, 1);
d = dir_discesa(y);
norm_d = norm(d);
fprintf("La norma della direzione di discesa in y è %e\n", norm_d);

% 3. Si consideri il metodo del gradiente per la soluzione del sistema lineare indicato.
% Senza applicare esplicitamente l’algoritmo, si stimi il numero di iterazioni kmin
% necessarie a tale metodo iterativo affinché l’errore in norma A si riduca di un
% fattore inferiore a tol = 10−3, ovvero tale che ‖x(kmin) − x‖A / ‖x(0) − x‖A < tol. Qual è
% il valore stimato di ‖x(kmin) − x‖A se x(0) = b?

% ||e_k||A <= d^k ||e_0||A, cond d = (K(P^-1 * A) - 1) / (K(P^-1 * A) + 1
d = (K(A) - 1) / (K(A) + 1);
% tol = d^kmin
tol = 1e-3;
kmin = ceil(log(tol) / log(d));

fprintf("Il numero di iterazioni necessarie è %d\n", kmin);

x0 = b;
err_kmin = d^kmin * normA(x0 - x_exact, A);

fprintf("Il valore stimato di ||x(kmin) - x||A è %e\n", err_kmin);

% 4. Per la matrice A e il vettore b assegnati, si applichi il metodo del gradiente im-
% plementato nella funzione Matlab richardson.m usando la tolleranza sul criterio
% d’arresto basato sul residuo normalizzato tol = 10^−3, il numero massimo di iter-
% azioni pari a 10^5 e l’iterata iniziale x(0) = b. Si riportino: il numero N di
% iterazioni effettuate, la prima componente della soluzione approssimata
% x1 =(x(N))_1 e il valore del residuo normalizzato r(N)_norm = ‖r(N)‖ / ‖b‖ .

tol = 1e-3;
nmax = 1e5;
x0 = b;

[x, k] = richardson(A, b, eye(n), x0, tol, nmax);

x1 = x(1);
r = b - A*x;
r_norm = norm(r) / norm(b);

fprintf("Il numero di iterazioni effettuate è %d\n", k);
fprintf("La prima componente della soluzione approssimata è %e\n", x1);
fprintf("Il valore del residuo normalizzato è %e\n", r_norm);

% 6. Si consideri ora il metodo del gradiente precondizionato per risolvere un sistema
% lineare associato alla matrice A. In particolare si consideri la seguente matrice di
% precondizionamento dipendente dal parametro β ∈ R:
% P = tridiag ( −β, 2, −β ) ∈ R100×100.
% Per quale valore di βopt ∈ [ 1/2 , 1]
% il metodo del gradiente precondizionato converge
% piu' rapidamente alla soluzione per ogni scelta dell’iterata iniziale? Per il valore
% βopt selezionato, quanto vale il fattore di abbattimento dell’errore ‖x(k) − x‖A/‖x(0) − x‖A
% dopo k = 10 iterazioni del metodo per ogni x(0) ∈ R100?

P = @(beta) mdiag([-beta, 2, -beta], n);
d = @(P) (K2(P^-1 * A) - 1) / (K2(P^-1 * A) + 1);

beta_values = linspace(1/2, 1, 1000);
d_values = arrayfun(@(beta) d(P(beta)), beta_values);
% plot(beta_values, d_values);

[~, idx] = min(d_values); % => beta_opt = 1
beta_opt = beta_values(idx);

fprintf("Il valore di beta ottimale è %f\n", beta_opt);

abbattimento = d(P(beta_opt))^10; % FIXME: non corrisponde alla risposta

fprintf("Il fattore di abbattimento dell'errore dopo 10 iterazioni è %e\n", abbattimento);

% 6. Si consideri il metodo del gradiente coniugato applicato alla soluzione del sistema
% lineare A x = b assegnato a partire dal vettore iniziale x(0) = b. Si riportino:
% • le norme delle direzioni di discesa dell’algoritmo ‖p(0)‖, ‖p(1)‖, ‖p(2)‖;
% • gli angoli θ(1) e θ(2) formati rispettivamente tra le direzioni di discesa p(0) e p(1) e tra p(1) e p(2);
% • l’errore relativo ‖x(3) − x‖A / ‖x(0) − x‖A
% effettivamente commesso.

x0 = b;
[xk, pk, ~, ~] = conjgrad(A, b, x0, 3, 0);

p0 = pk(:, 1);
p1 = pk(:, 2);
p2 = pk(:, 3);

theta1 = acosd(dot(p0, p1) / (norm(p0) * norm(p1)));
theta2 = acosd(dot(p1, p2) / (norm(p1) * norm(p2)));

x0 = b;
x3 = xk(:, 4);

err_rel = normA(x3 - x_exact, A) / normA(x0 - x_exact, A);

fprintf("Le norme delle direzioni di discesa sono %e, %e, %e\n", norm(p0), norm(p1), norm(p2));
fprintf("Gli angoli tra le direzioni di discesa sono %e, %e\n", theta1, theta2);
fprintf("L'errore relativo commesso è %e\n", err_rel);

%% 7. Si consideri ora il seguente sistema di equazioni non lineari
% F(x) = A x + e−2x − 1 = 0,
% dove F : R100 → R100 e la matrice A `e stata definita precedentemente.
% Si approssimi lo zero α = 0 ∈ R100 del precedente sistema di equazioni non
% lineari implementando opportunamente il metodo di Newton in Matlabr .
% Si riportino:
% • l’espressione della generica matrice Jacobiana JF(x);
% • i valori della prima componente della prima, seconda e terza iterata, ovvero
% (x(1))1, (x(2))1 e (x(3))1, ottenute applicando il metodo di Newton a partire
% dal vettore iniziale x(0) = (0.3, 0.3, . . . , 0.3)T ∈ R100;
% • i comandi Matlabr usati.

syms x [n 1];

x0 = 0.3 * ones(n, 1);
F = A*x + exp(-2*x) - 1;

% Jacobiana automatica
% [~, ~, xvect] = symnewton(x0, 3, 0, F);

% Jacobiana manuale
JF = A - 2*diag(exp(-2*x));
[~, ~, xvect] = symnewton(x0, 3, 0, F, JF);