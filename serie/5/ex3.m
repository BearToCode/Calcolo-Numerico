clear; clc;

syms x;
symf = -x^3 + 3*x^2 - 2;
I = [0, 2];

% Si scriva l’espressione analitica delle funzioni di base
% lagrangiane per la terna di punti x0 = 0, x1 = 1/2 e
% x2 = 2 e si costruisca il polinomio interpolatore di
% lphi associato.

x = [0, 1/2, 2];

ks = 1:length(x);
phis = arrayfun(@(k) lphi(x, k), ks);

% Plot

figure;
hold on;

for i = 1:length(ks)
    fplot(phis(i), I, 'DisplayName', sprintf('φ_{%d}(x)', i));
end

legend;
xlabel('x');
ylabel('f(x)');
grid on;

% Si calcoli il polinomio interpolatore di Lagrange

values = arrayfun(@(x) subs(symf, x), x);
pol = lf(x, values);

% Plot

figure;
fplot(symf, I, 'DisplayName', 'f(x)');
legend;
hold on;
fplot(pol, I, 'DisplayName', 'p(x)');
xlabel('x');
ylabel('f(x)');
grid on;

%% se x0 = 0, x1 = e−√2, x2 = 3−√0.5 e x3 = 2?
% grado 3 => stesso polinomio di partenza

x = [0, exp(-sqrt(2)), 3^(-sqrt(0.5)), 2];

ks = 1:length(x);
phis = arrayfun(@(k) lphi(x, k), ks);

% Plot

figure;
hold on;

for i = 1:length(ks)
    fplot(phis(i), I, 'DisplayName', sprintf('φ_{%d}(x)', i));
end

legend;
xlabel('x');
ylabel('f(x)');
grid on;

% Si calcoli il polinomio interpolatore di Lagrange

values = arrayfun(@(x) subs(symf, x), x);
pol = lf(x, values);


function f = lf(nodes, values)
f = 0;

for i = 1:length(nodes)
    f = f + values(i) * lphi(nodes, i);
end
end

function phi = lphi(nodes, k)
syms x;
phi = 1;
for i = 1:length(nodes)
    if i ~= k
        phi = phi * (x - nodes(i)) / (nodes(k) - nodes(i));
    end
end
end