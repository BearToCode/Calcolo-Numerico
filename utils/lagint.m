function f = lagint(nodes, values)
%% LAGINT: Interpolante di Lagrange
% nodes: nodi di interpolazione
% values: valori della funzione nei nodi
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