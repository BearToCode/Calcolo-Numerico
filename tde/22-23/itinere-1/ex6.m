% Si consideri la funzione f (x) = x − √5, dotata di uno zero α ∈ [0, 5]. Quante
% iterazioni kmin > 0 sono necessarie al metodo di bisezione al fine di garantire un
% errore inferiore a 10−3?

a = 0;
b = 5;
tol = 1e-3;

nmax = ceil(log2((b - a) / tol) - 1);
disp(nmax)