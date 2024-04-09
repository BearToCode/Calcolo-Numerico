A = hilb(4);
K2 = @(X) max(eig(X)) / min(eig(X));
d = (K2(A) - 1) / (K2(A) + 1);

disp(d);

syms x

eq = d^x == 10^-3;

solve(eq)
