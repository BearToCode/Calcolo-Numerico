function fn = poly_piecewise_interp(nodes, f, n, strategy)
%% POLY_PIECEWISE_INTERP Interpolazione polinomiale a tratti
%
% Input:
% - nodes: nodi di interpolazione
% - f: funzione da interpolare o vettore, se n = 1
% - n: grado del polinomio di interpolazione
% - strategy: strategia di scelta dei nodi di interpolazione
%             - "equispaced": nodi equispaziati
%             - "chebyshev": nodi di Chebyshev
%
% Output:
% - fn: funzione di interpolazione

avb_strategies = ["equispaced", "chebyshev"];
if ~ismember(strategy, avb_strategies)
    error("Parametro strategy non valido. I valori ammessi sono: 'equispaced', 'chebyshev'");
end

if isvector(f)
    assert(n == 1, "Se f è un vettore, n deve essere 1");
    values = f;
    f = @(node) values(nodes == node);
end

fn = @(x) arrayfun(@(x) eval_poly_piecewise_interp(nodes, f, n, x, strategy), x);
end

function y = eval_poly_piecewise_interp(nodes, f, n, x, strategy)
n_intervals = length(nodes) - 1;
for i = 1:n_intervals
    start = nodes(i);
    finish = nodes(i + 1);
    
    if x >= start && x <= finish
        if strcmp(strategy, "equispaced")
            nodes_i = linspace(start, finish, n + 1);
        elseif strcmp(strategy, "chebyshev")
            nodes_i = chebyshev([start, finish], n + 1);
        end
        poly = polyfit(nodes_i, arrayfun(f, nodes_i), n);
        y    = polyval(poly, x);
        return;
    end
end
error("x non appartiene a nessun intervallo");
end