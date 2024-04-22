function [x] = gaussnewton(x0,F,J,nmax)
%GAUSSNEWTON metodo di Gauss-Newton per ricerca zeri sistema di equazioni
%non lineari
%   x0: soluzione iniziale.
%   F: sistema di funzioni non lineari.
%   J: matrice Jacobiana di F

    x    = x0;
    iter = 0;
    while nmax > iter
        iter = iter+1;
        B = J(x);
        delta = (B' * B) \ (-B' * F(x));
        x = x + delta;
    end
end