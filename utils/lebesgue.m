function l = lebesgue(nodes, interval)
n = length(nodes);
phis = arrayfun(@(k) lphi(nodes, k), 1:n);
f = @(x) sum(arrayfun(@(k) abs(subs(phis(k), x)), 1:n));
y = arrayfun(f, interval);
plot(interval, y);
l = max(y);
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