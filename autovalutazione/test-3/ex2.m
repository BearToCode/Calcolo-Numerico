syms g

assume(g > 0);

A = [2*g         sqrt(3)*g/2;
     sqrt(3)*g/2 g          ;];

eigs = eig(A);
eigs(2) / eigs(1)