function err = approx_err_interp(symf, var, nodes)
% APPROX_ERR_INTERP stima dell'errore di interpolazione su un intervallo
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

x_space = linspace(a, b, 1000);

symdf  = diff(symf, var, n+1);
df     = matlabFunction(symdf);

symw = omega(nodes, n);
w    = matlabFunction(symw);

y_df = arrayfun(df, x_space);
y_w  = arrayfun(w, x_space);

max_df = max(abs(y_df));
max_w  = max(abs(y_w));

err = 1 / factorial(n+1) * max_df * max_w;
end

function f = omega(nodes, n)
syms x;
f = 1;
for i = 1:n+1
    f = f * (x - nodes(i));
end
end