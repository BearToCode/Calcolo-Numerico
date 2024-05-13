function I = clenshawcurtis(n_half, f)
%% clenshawcurtis: formula di quadratura di Clenshaw-Curtis su intervallo -1, 1
I = a(0, f);

for k = 1:n_half
    I = I + a(2 * k, f) / (1 - (2*k)^2);
end
end

function v = a(k, f)
v = 2 / pi * integral(@(theta) f(cos(theta)) .* cos(k .* theta), 0, pi);
end