clear; clc;

a     = 0;
b     = 1;
alpha = 0;
beta  = 1;
mu    = 1;
eta   = 1;
fun   = @(x) 0;

u_exact = @(x) (exp(eta/mu*x) - 1) / (exp(eta/mu) - 1);

N = 20 - 1;
h = (b - a) / (N + 1);
x_nodes = linspace(a, b, N + 2);


[x, u] = dtr(mu, eta, 0, fun, a, b, 'dirichlet', 'dirichlet', alpha, beta, h);

x_disp = linspace(a, b, 1000);
plot(x_disp, u_exact(x_disp), 'DisplayName', 'Soluzione esatta');
hold on;
plot(x, u, 'o-', 'DisplayName', 'Soluzione approssimata');
hold off;
legend;

%% 4. Oscillazioni
mu = 1e-2;
u_exact = @(x) (exp(eta/mu*x) - 1) / (exp(eta/mu) - 1);

[x, u] = dtr(mu, eta, 0, fun, a, b, 'dirichlet', 'dirichlet', alpha, beta, h);


x_disp = linspace(a, b, 1000);
plot(x_disp, u_exact(x_disp), 'DisplayName', 'Soluzione esatta');
hold on;
plot(x, u, 'o-', 'DisplayName', 'Soluzione approssimata');
hold off;
legend;

%% 5. Si risolva ora il problema con i dati di cui al punto 4) per (N + 1) = 30, 60, 120, 240, 480.
% Si rappresenti graficamente, in funzione di h, l’andamento dell’errore

N_values = [30, 60, 120, 240, 480];
h_values = (b - a) ./ (N_values + 1);

errors = zeros(size(N_values));

for i = 1:length(N_values)
    N = N_values(i);
    h = h_values(i);
    x_nodes = linspace(a, b, N + 2);
    [x, u] = dtr(mu, eta, 0, fun, a, b, 'dirichlet', 'dirichlet', alpha, beta, h);
    u_exact = @(x) (exp(eta/mu*x) - 1) / (exp(eta/mu) - 1);
    u_exact_values = u_exact(x);
    errors(i) = max(abs(u' - u_exact_values));
end

loglog(h_values, errors, 'o-', 'DisplayName', 'Errore');
xlabel('h');
ylabel('Errore');
title('Errore in funzione di h');
grid on;
% Aggiungo h^2 per confronto
hold on;
loglog(h_values, h_values.^2, 'DisplayName', 'h^2');
legend('show');
hold off;

% Da finire...