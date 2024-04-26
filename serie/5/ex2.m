clear; clc;

f = @(x) sin(1 / (1+x^2));
I = [-2*pi, 2*pi];

x = linspace(I(1), I(2), 1000);

%% 1. Si calcolino i polinomi di Lagrange Πnf (x) di grado n = 2, 4, 8, 10 relativi ad una
% distribuzione di nodi equispaziati nell’intervallo I. Si confrontino i grafici dei Πnf (x)
% con quello della funzione f (x).

ns = [2, 4, 8, 10];
ps = cell(1, length(ns));

it = 1;

figure(1);
plot(x, arrayfun(f, x), 'DisplayName', 'f(x) = sin(1 / (1+x^{2}))');
hold on;

for n = ns
    nodes = linspace(I(1), I(2), n+1); % n+1 nodi
    values = arrayfun(f, nodes);
    p = polyfit(nodes, values, n);
    y = polyval(p, x);
    
    ps{it} = p;
    
    plot(x, y, 'DisplayName', sprintf('P_%d (x)', n));
    
    it = it + 1;
end

title(sprintf('Interpolante polinomiale di f(x) = x * sin(x) con n=%d', n));
xlabel('x');
ylabel('f(x)');
legend;
grid on;
hold off;

%% 2. Calcolare per n = 2, 4, 8, 10 la norma infinito dell’errore εn(x) (definito come nel-
% l’esercizio 1) e rappresentarla su un grafico in funzione del grado n. Che fenomeno si
% osserva?

figure(2);
hold on;

errs = zeros(1, length(ns));

for i = 1:length(ns)
    n = ns(i);
    p = ps{i};
    
    y = arrayfun(f, x);
    y_p = polyval(p, x);
    
    e = abs(y - y_p);
    
    plot(x, e);
    xlabel('x');
    ylabel('ε(x)');
    grid on;
    
    norm_inf = max(e);
    errs(i) = norm_inf;
    fprintf('||ε_%d(x)||∞ = %f\n', n, norm_inf);
end

figure(3);
plot(ns, errs);
xlabel('n');
ylabel('||ε_{n}(x)||_∞');
grid on;

%% 3. Ripetere i punti 1) e 2) utilizzando la distribuzione di nodi di Chebyshev, definiti per
% un generico intervallo [a, b] come segue:
% xk := (b − a)/2 * tk + (a + b)/2 ,
% dove tk := − cos(πk/n), per k = 0, . . . , n.
% Si commentino i risultati ottenuti.

t = @(n, k) -cos(pi * k / n);
chebyshev = @(a, b, n, k) (b - a) / 2 * t(n, k) + (a + b) / 2;

ps = cell(1, length(ns));

figure(4);
plot(x, arrayfun(f, x), 'DisplayName', 'f(x) = sin(1 / (1+x^{2}))');
hold on;

it = 1;

for n = ns
    nodes = arrayfun(@(k) chebyshev(I(1), I(2), n, k), 0:n);
    values = arrayfun(f, nodes);
    p = polyfit(nodes, values, n);
    y = polyval(p, x);
    
    ps{it} = p;
    
    plot(x, y, 'DisplayName', sprintf('P_%d (x)', n));
    
    it = it + 1;
end

title(sprintf('Interpolante polinomiale su nodi di Chebyshev di f(x) = x * sin(x) con n=%d', n));
xlabel('x');
ylabel('f(x)');
legend;
grid on;
hold off;

figure(5);

errs = zeros(1, length(ns));

for i = 1:length(ns)
    n = ns(i);
    p = ps{i};
    
    y = arrayfun(f, x);
    y_p = polyval(p, x);
    
    e = abs(y - y_p);
    
    plot(x, e);
    hold on;
    xlabel('x');
    ylabel('ε(x)');
    grid on;
    
    norm_inf = max(e);
    errs(i) = norm_inf;
    fprintf('||ε_%d(x)||∞ = %f\n', n, norm_inf);
end
hold off;

figure(6);
plot(ns, errs);
xlabel('n');
ylabel('||ε_{n}(x)||_∞');
grid on;
