clear; clc;

syms x;

mu    = 1;
eta   = 0;
sigma = 0;
sym_f = exp(3*x) * (-4 + 3*x + 9*x^2);
f     = matlabFunction(sym_f);
a     = 0;
b     = 1;
alpha = 1;
gamma = -exp(3);

sym_u_exact = exp(3*x) * (x - x^2) + 1;
u_exact     = matlabFunction(sym_u_exact);

%% 1. Verificare che u_exact è soluzione esatta del problema con i dati indicati

% fplot(-mu * diff(sym_u_exact, x, 2) + eta * diff(sym_u_exact, x) + sigma * sym_u_exact - sym_f) % 0 ok
assert(u_exact(a) == alpha);
assert(mu * subs(diff(sym_u_exact), x, a) == alpha);


%% 2. Si ricavino le espressioni generali della matrice A e del vettore b che compaiono nel
% sistema lineare condensato ottenuto mediante approssimazione con le differenze
% finite centrate e lo schema per l’approssimazione di u′(xN + 1).

%% 3. Si scriva uno script o funzione Matlabr per risolvere il problema ai limiti di cui al
% punto 2) con (N + 1) = 100. Confrontare in un grafico la soluzione approssimata con
% quella esatta uex.

h = 1/100;
[x, u, A_dtr, b_dtr] = dtr(mu, eta, sigma, f, a, b, "dirichlet", "neumann_centered", alpha, gamma, h);

xx = linspace(a, b, 1000);

figure;
hold on;
plot(xx, u_exact(xx), 'DisplayName', 'u_{ex}');
plot(x, u, 'DisplayName', 'u_{app}');
legend;
hold off;

%% 4. Si risolva ora il problema con lo schema di cui al punto 2) per (N+1) = 50, 100, 200, 400, 800.
% Si rappresenti graficamente, in funzione di h, l’andamento dell’errore (7). Si confronti
% il risultato ottenuto con quanto previsto dalla teoria.

h_values = 1 ./ [50, 100, 200, 400, 800];
errors = zeros(size(h_values));

for i = 1:length(h_values)
    h = h_values(i);
    [x, u, A_dtr, b_dtr] = dtr(mu, eta, sigma, f, a, b, "dirichlet", "neumann_centered", alpha, gamma, h);
    u_exact_values = u_exact(x);
    errors(i) = norm(u' - u_exact_values, inf);
end

figure;
loglog(h_values, errors, 'DisplayName', 'Errore');
hold on;
loglog(h_values, h_values.^2, 'DisplayName', 'h^2');
legend;
hold off;


