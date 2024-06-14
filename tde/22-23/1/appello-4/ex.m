clc; clear;


% 1. Sapendo che per la generica matrice A ∈ Rn×n il suo determinante è det (A) =
% 1 + n (γ − 1), si determinino le condizioni necessarie e sufficienti sul parametro
% γ ∈ R affinchè sia garantita l’esistenza e unicità della fattorizzazione LU di A
% senza pivoting

% det(A) = 1 + n (γ - 1)
% det(A) != 0

% => 1 + n (γ - 1) != 0; γ != 1 - 1/n ogni 1 <= n <= 100

% 2. Quale metodo diretto `e computazionalmente conveniente utilizzare per risolvere il
% generico sistema lineare A x = b con la matrice A data in Eq. (1)? Si motivi la
% risposta data.
% Si considerino ora 10 sistemi lineari Aj xj = b, dove Aj ∈ Rn×n corrisponde
% alla matrice data in Eq. (1) con un valore di γj che consente l’applicazione del
% metodo diretto precedente. Qual `e il numero di operazioni necessario per la
% risoluzione tramite il metodo diretto indicato per j = 1, . . . , 10? Si motivi det-
% tagliatamente la risposta data.

% tridiagonale => Thomas
% #operazioni fattorizzazione = 3(n-1)
% #operazioni risoluzione = 2(n-1) + 3(n-1) + 1

n_systems = 10;
syms size;
flops = 3 * (size - 1) + (2 * (size - 1) + 3 * (size - 1) + 1) * n_systems;
fprintf('Numero di operazioni necessarie per la risoluzione dei 10 sistemi:\n');
disp(simplify(flops))

% 3. Si ponga ora n = 3 per il sistema lineare con matrice A ∈ R3×3 data in Eq. (1).
% Per quali valori di γ > 0 `e garantita la convergenza dei metodi di Jacobi e di
% Gauss–Seidel alla soluzione x ∈ R3 per ogni scelta dell’iterata iniziale x(0) ∈ R3?

n = 3;
syms g;
Ag = [g -1 0; 
      -1 2 -1; 
      0 -1 2];
B_jacobi = diag(diag(Ag)) \ (diag(diag(Ag)) - Ag);
B_gs = eye(n) - tril(Ag) \ Ag;

spectral_radius_jacobi = max(abs(eig(B_jacobi)));
spectral_radius_gs = max(abs(eig(B_gs)));

fplot(spectral_radius_jacobi, [0, 10]);
hold on;
grid on;
fplot(spectral_radius_gs, [0, 10]);
fplot(1, [0, 10]);
hold off;

close all;

% => g > 2/3

% 4. Si pongano ora n = 100 e γ = 10 per il sistema lineare A x = b per la matrice
% A ∈ R100×100 data in Eq. (1), simmetrica e definita positiva.
% Si consideri il metodo del gradiente per la soluzione di tale sistema lineare.
% Senza applicare esplicitamente l’algoritmo, si stimi l’errore in norma A, ovvero
% ‖x(k) − x‖A, dopo k = 10000 iterazioni del metodo, considerando x(0) = b ∈ R100.
% Si giustifichi la risposta data definendo tutta la notazione utilizzata e riportando i
% comandi Matlabr usati.

gamma = 10;
n = 100;
A10 = A(gamma, n);
k = 10000;
x_exact = ones(n, 1);
b = A10 * x_exact;
x0 = b;

% ||e_k||A <= d^k ||e_0||A, cond d = (K(P^-1 * A) - 1) / (K(P^-1 * A) + 1
d = (K(eye(n) \ A10) - 1) / (K(eye(n) \ A10) + 1);
err_exp = d^k * normA(x0 - x_exact, A10);

fprintf('Stima errore relativo: %e\n', err_exp);

% 5. Si consideri ora il metodo del gradiente precondizionato per risolvere il sistema
% lineare associato alla matrice A con i dati di cui al Punto 4). In particolare, si
% consideri la seguente matrice di precondizionamento simmetrica e definita positiva:
% P = tridiag ( −1, β, −1 ) ∈ R100×100,
% dipendente dal parametro β > 0. Per quale valore del parametro β a scelta tra
% 2, 4, 6, 8 e 10, il metodo del gradiente precondizionato converge pi`u rapidamente
% alla soluzione per ogni scelta dell’iterata iniziale x(0)?

P = @(beta) mdiag([-1 beta -1], n);
beta_values = [2, 4, 6, 8, 10];

d = @(P) (K(P \ A10) - 1) / (K(P \ A10) + 1);
d_values = arrayfun(@(beta) d(P(beta)), beta_values);

[min_d, min_d_idx] = min(d_values);
min_beta = beta_values(min_d_idx);

fprintf('Il valore di beta che minimizza d è: %d\n', min_beta);

% 6. Si definisca un algoritmo computazionalmente efficiente per stimare il numero di
% condizionamento spettrale K(A^−1) della matrice inversa di A data al Punto 4),
% ovvero A^−1, anch’essa simmetrica e definita positiva. Si riporti inoltre il numero di
% operazioni effettuato per l’approssimazione di K(A^−1) con l’algoritmo proposto.
% Si riporti l’algoritmo Matlabr e lo si applichi opportunamente alla stima di
% K(A^−1) riportando tutti i comandi Matlabr utilizzati e i risultati ottenuti.

% Gli autovalori di A^-1 sono 1./autovalori di A
% Quindi K(A^-1) = K(A)

% => guarda sdpcond.m


% 7. Si consideri ora il seguente sistema di equazioni non lineari per n = 100.
% F(x) = A x + 1 − e−x/50 = 0, dove F : R100 → R100 e la matrice A `e stata 
% definita precedentemente al Punto 4).
% Si approssimi lo zero α = 0 ∈ R100 usando la funzione Matlabr algoritmo.m
% implementata, scegliendo x(0) = (0.1, 0.1, . . . , 0.1)T ∈ R100 e B0 = A.
% Si riportino i valori della prima componente della prima, seconda e terza iter-
% ata, ovvero (x(1))1, (x(2))1 e (x(3))1, ottenute applicando il metodo.

f = @(x) A10 * x + 1 - exp(-x / 50);
x0 = ones(n, 1) * 0.1;
B0 = A10;

approx_1 = approx_zero(f, x0, B0, 1);
approx_2 = approx_zero(f, x0, B0, 2);
approx_3 = approx_zero(f, x0, B0, 3);

fprintf('Prima componente prima iterata: %f\n', approx_1(1));
fprintf('Prima componente seconda iterata: %f\n', approx_2(1));
fprintf('Prima componente terza iterata: %f\n', approx_3(1));

function zero = approx_zero(f, x0, B0, nmax)
    k = 0;
    prev_x = x0;
    prev_B = B0;
    while k < nmax
        k = k + 1;

        delta = prev_B \ -f(prev_x);
        x = prev_x + delta;
        z = f(x) - f(prev_x) - prev_B * delta;
        B = prev_B + 1 / dot(delta, delta) * (z * delta');

        prev_x = x;
        prev_B = B;
    end

    zero = prev_x;
end

function mat = A(gamma, n)
    mat = mdiag([-1 2 -1], n);
    mat(1, 1) = gamma;
end