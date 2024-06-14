% La radice n-sima di un numero reale positivo A ∈ R+ pu`o essere approssimata con
% il seguente algoritmo iterativo: dato x0 ∈ R+, xk+1 = 1/n * ((n − 1 )x_k + A/x_k^(n−1))
% per k = 0, 1, . . .. Quante iterazioni di questo algoritmo sono necessarie per ottenere
% una stima di 5 √146 con un errore assoluto inferiore a 10−3 per x0 = 1?

x0 = 1;
A = 146;
n = 5;
tol = 10^(-3);

[x, k] = radice_n_sima(A, n, x0, tol);
disp(k);

function [x, k] = radice_n_sima(A, n, x0, tol)
    x = x0;
    k = 0;
    while abs(x - (A)^(1/n)) > tol
        x = 1/n * ((n - 1) * x + A/x^(n-1));
        k = k + 1;
    end
end