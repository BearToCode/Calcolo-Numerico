clear; clc;

% Sia f (x) = sin(3πx) e Πnf(x) il polinomio interpolante di grado n della funzione
% nei nodi non equispaziati x0 = 0, x1 = 0.25, x2 = 0.5, x3 = 1, x4 = 1.25. Si
% riportino i valori dell’errore di interpolazione en(f ) = max
% x∈[0,1.25] |f (x) − Πnf (x)| e della sua stima ˜en(f ).

syms x;
symf = sin(3*pi*x);
f    = @(x) sin(3*pi*x);

nodes = [0, 0.25, 0.5, 1, 1.25];
a = nodes(1);
b = nodes(end);
n = 4;


poly = polyfit(nodes, f(nodes), n);

x_space = linspace(a, b, 1000);
y = f(x_space);
y_hat = polyval(poly, x_space);

en = max(abs(y - y_hat));

disp(en); % 2.0535


% Stima
err_approx = approx_interp_err(symf, x, nodes);
disp(err_approx); % 7.4173