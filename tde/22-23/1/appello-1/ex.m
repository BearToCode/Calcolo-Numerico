% Si consideri il sistema lineare A x = b, dove A ∈ Rn×n `e una matrice non singolare,
% e x, b ∈ Rn per n ≥ 1. In particolare, poniamo n = 100, A corrispondente alla
% seguente matrice pentadiagonale
% A = pentadiag ( 1, −4, 21, −20, 2 ) ∈ R100×100,
% b ∈ R100 tale per cui la soluzione esatta del sistema lineare `e x = 2 ∈ R100.

n = 100;
A = mdiag([1 -4 21 -20 2], n);
x_exact = 2*ones(n,1);
b = A*x_exact;

% Si consideri il seguente metodo iterativo dipendente dal parametro ω ∈ R, con
% ω > 0: data l’iterata inziale x(0) ∈ Rn
% 1/ω T x(k+1) = b − (A + (1/ω − 2) T) x(k) per k = 0, 1, . . .
% dove T ∈ Rn×n `e la matrice triangolare inferiore estratta da A (non singolare).
% Si riporti l’espressione della matrice di iterazione associata al metodo prece-
% dente in funzione di ω. Si applichi poi il metodo al sistema lineare assegnato
% determinando i valori di ω ∈ R tale per cui la convergenza `e garantita per ogni
% x(0) ∈ Rn, oltre al valore ottimale ωopt.

T = tril(A);

syms w;
symB = (2*w - 1) * eye(n) - w * T^-1 * A;
B = matlabFunction(symB);

w_values = linspace(0, 2, 1000);
spectral_radius = arrayfun(@(w) max(abs(eig(B(w)))), w_values);

% Plot spectral radius
% figure;
% plot(w_values, spectral_radius);
% xlabel('w');
% ylabel('spectral radius');

[min_spectral_radius, idx] = min(spectral_radius);
w_opt = w_values(idx);

fprintf('Optimal w: %f, spec: %f\n', w_opt, min_spectral_radius);
