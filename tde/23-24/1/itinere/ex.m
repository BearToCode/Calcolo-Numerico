clc; clear;

n = 10;

A = mdiag([1 -13 24 -13 1], n);
x_exact = ones(n, 1);
b = A * x_exact;

% 1.

% Per determinare la convergenza dei due metodi studio il raggio spettrale delle loro matrici di iterazione.
% Infatti i metodi convergono <=> rho(B) < 1

% Matrice di iterazione di Jacobi
B_jacobi = diag(diag(A))^-1  * (diag(diag(A)) - A);
% Matrice di iterazione di Gauss Seidel
B_gs = eye(n) - tril(A)^-1 * A;

% Raggi spettrali
spectral_radius_jacobi = max(abs(eig(B_jacobi)));
spectral_radius_gs = max(abs(eig(B_gs)));

fprintf('Raggio spettrale di Jacobi: %f\n', spectral_radius_jacobi); % 1.110815 > 1
fprintf('Raggio spettrale di Gauss-Seidel: %f\n', spectral_radius_gs); % 0.937348 < 1 ok

% => Converge solo Gauss Seidel

x0 = zeros(n, 1);
tol = 10^(-6);

% Applico Gauss Seidel
[x_gs, k_gs] = gs(A, b, x0, tol, 1000);

% Calcolo residuo normalizzato
res_norm = norm(b - A*x_gs) / norm(b);

fprintf("Iterazioni effettuate: %d\n", k_gs); % 184
fprintf("Residuo normalizzato: %e\n", res_norm); % 9.727333e-07

% Errore stimato = Residuo normalizzato * condizionamento di A
err_exp = res_norm * K2(A); % Funzione allegata
% Errore relativo reale
err_rel = norm(x_exact - x_gs) / norm(x_exact);

fprintf('Errore relativo: %e\n', err_rel); % 6.556313e-06
fprintf('Stima errore relativo: %e\n', err_exp); % 6.460634e-05 > 6.556313e-06 ok

% 2.

P1 = eye(n);
P2 = mdiag([-12 25 -12], n); % TODO: Funzione allegata
P3 = mdiag([-1 2 -1], n);

% La velocità di convergenza del gradiente precondizionato dipende dal valore d,
% determinato nel seguente modo:
d = @(P) (K2(P^-1 * A) - 1) / (K2(P^-1 * A) + 1);
% Infatti ||e_k||A <= d^k ||e_0||A

d1 = d(P1);
d2 = d(P2);
d3 = d(P3);

fprintf("d1=%f\n", d1); % 0.970334
fprintf("d2=%f\n", d2); % 0.465856
fprintf("d3=%f\n", d3); % 0.180562

% => Uso P3, che ha d minore
P = P3;

x0 = zeros(n, 1);
tol = 10^(-6);

[x_grad, k_grad] = richardson(A, b, P, x0, tol, 1000);
err_grad = norm(x_grad - x_exact);

fprintf("Iterazioni effettuate: %d\n", k_grad); % 8
fprintf("Errore: %e\n", err_grad); % 5.934538e-07

% 3.

% In aritmetica esatta converge al più in n iterazioni

x0 = zeros(n, 1);
tol = 10^-6;

[x_pcg, ~, ~, k_pcg] = pcg(A,b,tol,100,[],[],x0);
err_pcg = norm(x_pcg - x_exact);

fprintf("Iterazioni effettuate: %d\n", k_pcg); % 5
fprintf("Errore: %e\n", err_pcg); % 1.727102e-15

% 4.

[D] = qrbasic(A, 0, 3); % Funzione allegata
% approssimazione del nono autovalore con qr
eig9_qr = D(9);

tol = 10^-3;
x0 = zeros(n, 1);
for i = 1:n
    if mod(i, 2) == 0
        x0(i) = 1;
    else
        x0(i) = -1;
    end
end

[eig9,x,iter] = invpowershift(A, eig9_qr, tol, 1000, x0);
fprintf("eig9 = %f\n", eig9); % 3.058905
fprintf("iter =");
disp(iter); % 3
fprintf("x =");
disp(x);

% 5.

% Funzione e gradiente
phi = @(y) sin(1/n * y' * y) + 1/2 * y' * A * y;
grad = @(y) 2/n * cos(1/n * y' * y) * y + A * y;
x0 = ones(n, 1);
tol = 10^-3;

[xvect, it] = steepest_descent(grad, n, x0, tol, 100);

fprintf("Operazioni eseguite: %d\n", it); % 35

x1 = xvect(:, 2);
x2 = xvect(:, 3);
xend = xvect(:, end);

fprintf("x11 = %f\n", x1(1)); % -0.210806
fprintf("x21 = %f\n", x2(1)); % 0.348320
fprintf("xend1 = %f\n", xend(1)); % 0.000086

function [xvect, it] = steepest_descent(grad, n, x0, tol, nmax)
gamma = 0.1;
err   = tol + 1;
x     = x0;
% Salvo le varie x ottenute
xvect = zeros(n, nmax + 1);
xvect(:, 1) = x0;

it = 0;
while err > tol && it < nmax
    it = it + 1;
    
    x_prev = x;
    x = x - gamma * grad(x);
    
    gamma = (abs((x - x_prev)' * (grad(x) - grad(x_prev)))) / ...
        (norm(grad(x) - grad(x_prev))^2);
    
    err = norm(grad(x));
    xvect(:, it + 1) = x;
end

% Rimuovo parte non utilizzata
xvect = xvect(:, 1:it + 1);
end