clear; clc;

x0 = 0;
x1 = 1/5;
x2 = 4/5;
x3 = 1;

nodes = [x0, x1, x2, x3];

% Polinomio di lagrange associato al nodo x2
phi2_sym = lphi(nodes, 3);

phi2 = matlabFunction(phi2_sym);

% Massimo valore assunto da phi2 in [0 1]

x = linspace(0, 1, 1000);
y = phi2(x);

max_y = max(y);

fprintf('Massimo valore assunto da phi2 in [0 1]: %f\n', max_y);

% Valore assunto da phi2 in 1/5
val = phi2(1/5);

fprintf('Valore assunto da phi2 in 1/5: %f\n', val);

% Funzione caratteristica di Lagrange
function phi = lphi(nodes, k)
syms x;
phi = 1;
for i = 1:length(nodes)
    if i ~= k
        phi = phi * (x - nodes(i)) / (nodes(k) - nodes(i));
    end
end
end