clear; clc;

a       = 0;
b       = 1;
alpha   = 1;
beta    = -2;
mu      = 1;

f = @(x) exp(3*x) * (-4 + 3*x + 9*x^2);
u_exact = @(x) exp(3*x) * (x - x^2) + 1 - 3*x;

N = 20 - 1; % Numero sottointervalli
h = (b - a) / (N + 1);

%% 2. Si ricavino le espressioni generali della matrice A e del vettore b che compaiono nel
% sistema lineare condensato (6) e ottenuto mediante approssimazione con le differenze
% finite centrate.

[x, u, A, n] = dtr(mu, 0, 0, f, a, b, 'dirichlet', 'dirichlet', alpha, beta, h);

% Plot della funzione esatta e dei risultati ottenuti

xx = linspace(a, b, 1000);
uu = arrayfun(u_exact, xx);

figure(1)
plot(xx, uu, 'DisplayName', 'u(x)');
hold on
plot(x, u, 'o-', 'DisplayName', 'u(x_j)');
hold off
legend('Analitica', 'Numerica')
title('Soluzione esatta e approssimata')
xlabel('x')
ylabel('u(x)')
grid on

%% 4. Si risolva ora il problema per (N + 1) = 10, 20, 40, 80, . . . , 160. Si rappresenti grafica-
% mente, in funzione di h, l’andamento dell’errore. Come varia il condizionamento?

N = [10, 20, 40, 80, 160] - 1;
err = zeros(size(N));
k = zeros(size(N));

for i = 1:length(N)
    h = (b - a) / (N(i) + 1);
    [x, u, A, n] = dtr(mu, 0, 0, f, a, b, 'dirichlet', 'dirichlet', alpha, beta, h);
    u_val = u';
    u_val_exact = arrayfun(u_exact, x);
    
    err(i) = max(abs(u_val - u_val_exact));
    k(i) = condest(A);
end

figure(2)
loglog((b - a) ./ (N + 1), err, 'o-', 'DisplayName', 'Errore')
title('Errore in norma infinito')
xlabel('h')
ylabel('||u - u_{ex}||_{\infty}')
grid on
legend('show')
hold on
% Plot h^2 e h
loglog((b - a) ./ (N + 1), ((b - a) ./ (N + 1)).^2, 'DisplayName', 'h^2')
loglog((b - a) ./ (N + 1), (b - a) ./ (N + 1), 'DisplayName', 'h')
hold off

figure(3)
loglog((b - a) ./ (N + 1), k, 'o-', 'DisplayName', 'Condizionamento')
title('Condizionamento della matrice A')
xlabel('h')
ylabel('k(A)')
grid on
legend('show')
hold on
% Plot h^-2 e h^-1
loglog((b - a) ./ (N + 1), ((b - a) ./ (N + 1)).^(-2), 'DisplayName', 'h^-2')
loglog((b - a) ./ (N + 1), ((b - a) ./ (N + 1)).^(-1), 'DisplayName', 'h^-1')
hold

% Errore commesso con N = 160 -1

err160 = condest(A) * norm(n - A*u(2:end-1)) / norm(n) * norm(u(2:end-1));