function I = glquad(a, b, N, n, f)
%% glquad: formula di quadratura di Gauss–Legendre composita completa
%  INPUT:
%   a: estremo inferiore dell'intervallo
%   b: estremo superiore dell'intervallo
%   N: numero di sottointervalli
%   n: grado del polinomio di Legendre
%   f: funzione da integrare
%  OUTPUT:
%   I: approssimazione dell'integrale

poly = compute_poly(n + 1);

nodes   = compute_nodes(poly);
weights = compute_weights(nodes, poly);

h = (b - a) / N;

I = 0;

for i = 1:N
    x0 = a + (i - 1) * h;
    xn = a + i * h;
    
    shifted_nodes = (nodes + 1) / 2 * (xn - x0) + x0;
    I = I + h / 2 * normalized(shifted_nodes, weights, f);
end

end

function I = normalized(nodes, weights, f)
I = sum(weights .* f(nodes));
end

function nodes = compute_nodes(poly)
nodes = roots(sym2poly(poly));
end

function weights = compute_weights(nodes, poly)
poly_diff = sym2poly(diff(poly));
diff_values = polyval(poly_diff, nodes);
weights = 2 ./ ((1 - nodes.^2) .* (diff_values.^2));
end

function poly = compute_poly(k)
syms x;
if k == 0
    poly = 1;
    return;
elseif k == 1
    poly = x;
    return;
end

poly = (2 * k - 1) / k * x * compute_poly(k - 1) - (k - 1) / k * compute_poly(k - 2);
end