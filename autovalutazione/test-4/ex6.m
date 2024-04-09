A = mdiag([-1 -3 8.1 -3 -1], 100);
P = @(b) mdiag([-1 b -1], 100);

x = linspace(2, 2.5, 100);
y = zeros(100, 1);
K2 = @(X) max(eig(X)) / min(eig(X));
PK = @(x) K2(P(x)^-1 * A);

for i = 1:100
    y(i) = (PK(2 + i/100 * 0.5) - 1) / (PK(2 + i/100 * 0.5) + 1);
end

plot(x, y);