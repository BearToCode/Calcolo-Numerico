clear; clc;

f = @(x) x .* sin(x);

%% 1. Si disegni il grafico della funzione nell’intervallo [−2, 6].

x = linspace(-2, 6, 1000);
y = f(x);

figure;
plot(x, y);
title('f(x) = x * sin(x)');
xlabel('x');
ylabel('f(x)');
grid on;

%% 2. Si costruiscano i polinomi interpolanti di Lagrange Πnf di grado n = 2, 4, 6 relativi ad
% una distribuzione di nodi equispaziati e rappresentarli graficamente.

ns = [2, 4, 6];
ps = cell(1, length(ns));

colors = ['c', 'g', 'y'];


it = 1;

figure;
plot(x, y, 'DisplayName', 'f(x) = x * sin(x)');
hold on;

for n = ns
    nodes = linspace(-2, 6, n+1); % n+1 nodi
    values = f(nodes);
    p = polyfit(nodes, values, n);
    y = polyval(p, x);
    
    ps{it} = p;
    
    color = colors(it);
    plot(x, y, 'DisplayName', sprintf('P_%d (x)', n), 'Color', color);
    scatter(nodes, values, 'filled', 'DisplayName', sprintf('n=%d', n), 'MarkerFaceColor', color);
    
    it = it + 1;
end

title(sprintf('Interpolante polinomiale di f(x) = x * sin(x) con n=%d', n));
xlabel('x');
ylabel('f(x)');
legend;
grid on;
hold off;

%% 3. Si rappresenti graficamente l’errore ε_n(x) = |f (x) − Πn(x)| e si calcoli la sua norma
% infinito per n = 2, 4, 6:
% ||ε_n(x)||∞ = max x∈[−2,6] |f (x) − Πnf (x)|.

figure;
hold on;

for i = 1:length(ns)
    n = ns(i);
    p = ps{i};
    
    y = f(x);
    y_p = polyval(p, x);
    
    e = abs(y - y_p);
    
    plot(x, e);
    xlabel('x');
    ylabel('ε(x)');
    grid on;
    
    norm_inf = max(e);
    fprintf('||ε_%d(x)||∞ = %f\n', n, norm_inf);
end

