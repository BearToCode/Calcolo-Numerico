% Si consideri la funzione f(x) = 2 |sin(π x)| e il suo interpolante polinomiale quadratico
% a tratti ΠH2 f(x) su 4 sottointervalli equispaziati di [0, 4]. Si riporti il valore
% ΠH2 f (1.75).

f = @(x) 2 * abs(sin(pi * x));
n = 2;

n_intervals = 4;

a = 0;
b = 4;

intervals = linspace(a, b, n_intervals + 1);

target = 1.75;

% Trovo l'intervallo in cui si trova il punto target
i = 1;
while i <= n_intervals && intervals(i + 1) < target
    i = i + 1;
end

start = intervals(i);
finish = intervals(i + 1);

% Aggiungo i nodi di interpolazione
nodes = linspace(start, finish, n + 1);
values = arrayfun(f, nodes);

% Calcolo il polinomio di interpolazione
p = polyfit(nodes, values, n);

% Valuto il polinomio in target
result = polyval(p, target);

disp(result);
