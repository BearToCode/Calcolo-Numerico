function poly = regression(nodes, values, m)
%% REGRESSION: Regressione polinomiale
%
% poly = regression(nodes, values, m)
%
% Input:
% - nodes: nodi, vettore colonna
% - values: valori, vettore colonna
% - m: grado del polinomio
%
% Output:
% - poly: polinomio di grado m che approssima i dati
assert(length(nodes) == length(values));

n = length(nodes) - 1;
V = zeros(n + 1, m + 1);
for i = 1:n+1
    for j = 1:m+1
        V(i, j) = nodes(i) ^ (j-1);
    end
end
A = V' * V;
q = V' * values;

a = A \ q;
poly = flip(a);
end