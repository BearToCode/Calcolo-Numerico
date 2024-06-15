function err = approx_interp_err_equispaced(symf, var, nodes)
% APPROX_INTERP_ERR_EQUISPACED: stima dell'errore di interpolazione su un intervallo
%
% Input:
% - symf: funzione simbolica
% - var: variabile simbolica
% - node: nodi di interpolazione
%
% Output:
% - err: stima dell'errore di interpolazione

n     = length(nodes) - 1;
a     = nodes(1);
b     = nodes(end);

% Verifico che i nodi siano equispaziati
if ~all(diff(nodes) - (nodes(2) - nodes(1)) < 1e-12)
    error('I nodi non sono equispaziati');
end

x_space = linspace(a, b, 1000);

symdf  = diff(symf, var, n+1);
df     = matlabFunction(symdf);
y_df = arrayfun(df, x_space);
max_df = max(abs(y_df));

err = 1 / (4 * (n+1)) * ((b - a) / n)^(n+1) * max_df;
end
