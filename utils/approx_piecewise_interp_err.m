function err = approx_piecewise_interp_err(f_sym, var, nodes)
% APPROX_PIECEWISE_INTERP_ERR   : stima dell'errore di interpolazione lineare a tratti su un intervallo
%
% Input:
% - f_sym: funzione simbolica
% - var: variabile simbolica
% - node: nodi di interpolazione
%
% Output:
% - err: stima dell'errore di interpolazione

a = nodes(1);
b = nodes(end);

% Verifico che i nodi siano equispaziati
if ~all(diff(nodes) - (nodes(2) - nodes(1)) < 1e-12)
    error('I nodi non sono equispaziati');
end

H = nodes(2) - nodes(1);

df_sym = diff(f_sym, var, 2);
df     = matlabFunction(df_sym);

x_space = linspace(a, b, 1000);
y_space = arrayfun(df, x_space);

max_df = max(abs(y_space));

err = H^2 / 8 * max_df;
end
