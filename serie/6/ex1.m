clear; clc;

a = 0;
b = .8;

syms symx;

symf = cosh(symx - .5);
f = matlabFunction(symf);

x = linspace(a, b, 100);
y = f(x);

V_exact = pi * ((sinh(1) + sinh(3/5)) / 4 + 2/5);
plot(x, y, 'b', 'LineWidth', 2);

%% Approssimazioni

N = 1:20;
symf_int = pi * f(symx).^2;
f_int = matlabFunction(symf_int);

V_pmc = zeros(1, N(end));
V_tc  = zeros(1, N(end));
V_sc  = zeros(1, N(end));
V_gc  = zeros(1, N(end));

for n=N
    V_pmc(n) = pmedcomp(a, b, n, f_int);
    V_tc(n)  = trapcomp(a, b, n, f_int);
    V_sc(n)  = simpcomp(a, b, n, f_int);
    V_gc(n)  = gausscomp(a, b, n, f_int);
end

%% Plot approssimazioni

figure;
plot(N, V_pmc, '*', 'LineWidth', 2);
hold on;
plot(N, V_tc, '*', 'LineWidth', 2);
plot(N, V_sc, '*', 'LineWidth', 2);
plot(N, V_gc, '*', 'LineWidth', 2);
plot(N, V_exact * ones(1, N(end)), 'LineWidth', 2);
legend('Punto medio composita', 'Trapezi composita', 'Simpson composita', 'Gauss composita', 'Esatta');
xlabel('N');
ylabel('V');

%% Stima errore

symd2f = diff(symf_int, 2);
symd4f = diff(symf_int, 4);

d2f = matlabFunction(symd2f);
d4f = matlabFunction(symd4f);

% Stima dell'errore del punto medio composito
err_approx_pmc = @(N, x) (b - a) / 24 * ((b-a) / N)^2 * max(abs(d2f(x)));
% Stima dell'errore dei trapezi compositi
err_approx_tc = @(N, x) (b - a) / 12 * ((b-a) / N)^2 * max(abs(d2f(x)));
% Stima dell'errore di Simpson composito
err_approx_sc = @(N, x) (b - a) / (16 * 180) * ((b-a) / N)^4 * max(abs(d4f(x)));

tol = 1e-5;
x = linspace(a, b, 1000);

% Numero minimo di sottointervalli per avere errore inferiore a tol
N_pmc = ceil(sqrt(((b-a)^3 * max(abs(d2f(x))) / (24 * tol))));
N_tc = ceil(sqrt(((b-a)^3 * max(abs(d2f(x))) / (12 * tol))));
N_sc = ceil(((b-a)^5 * max(abs(d4f(x))) / (16 * 180 * tol))^(1/4));

fprintf('N_pmc: %d\n', N_pmc);
fprintf('N_tc: %d\n', N_tc);
fprintf('N_sc: %d\n', N_sc);

%% Plot errore, loglog

err_pmc = abs(V_pmc - V_exact);
err_tc = abs(V_tc - V_exact);
err_sc = abs(V_sc - V_exact);
err_gc = abs(V_gc - V_exact);

h = (b - a) ./ N;

figure;
loglog(h, err_pmc, '*', 'LineWidth', 2);
hold on;
loglog(h, err_tc, '*', 'LineWidth', 2);
loglog(h, err_sc, '*', 'LineWidth', 2);
loglog(h, err_gc, '*', 'LineWidth', 2);
legend('Punto medio composita', 'Trapezi composita', 'Simpson composita', 'Gauss composita');
xlabel('h');
ylabel('Errore');
