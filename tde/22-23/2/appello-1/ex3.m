clear; clc;

% Siano dati i seguenti nodi di interpolazione x0 = 0, x1 = 1 e x2 = 2, e si indichino
% con ϕi(x), i = 0, 1, 2 i polinomi caratteristici di Lagrange riferiti a tali nodi. Quanto
% vale l’approssimazione dell’integrale ∑[i=0,2] ∫[x0,x2] ϕi(x) dx
% ottenuta con la formula del trapezio semplice?

nodes = [0, 1, 2];
integral = 0;

for i = 1:length(nodes)
    poly = matlabFunction(lphi(nodes, i));
    integral = integral + trapcomp(nodes(1), nodes(3), 1, poly);
end

disp(integral); % 2


function phi = lphi(nodes, k)
syms x;
phi = 1;
for i = 1:length(nodes)
    if i ~= k
        phi = phi * (x - nodes(i)) / (nodes(k) - nodes(i));
    end
end
end