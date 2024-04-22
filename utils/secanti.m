function [xvect,it] = secanti(x0, x1, nmax, toll, fun)
%SECANTI: metodo delle secanti per il calcolo degli zeri di una funzione
%
% [xvect,it] = secanti(x0,nmax,toll,fun)
% xvect: vettore delle soluzioni per ciascuna iterata
% it: numero di iterazioni effettuate
% x0: soluzione iniziale
% nmax: numero massimo di iterazioni da effettuare
% toll: tolleranza del risultato
% fun: funzione su cui calcolare lo zero

% se ho uno zero semplice, il metodo converge con p=1.6

    xvect = zeros(nmax + 1, 1);

    xvect(1) = x0;
    xvect(2) = x1;
    it = 1;

    err = toll + 1;
    while it < nmax && err > toll
        it = it + 1;
        
        x    = xvect(it);
        xold = xvect(it - 1);
        q    = (fun(x) - fun(xold)) / (x - xold);
        xnew = x - fun(x)/q;
        
        err           = abs(xnew - x);
        xvect(it + 1) = xnew;
    end

    xvect = xvect(1:it+1);

    if it == nmax
        warning('secanti - Numero massimo di interazioni raggiunto \n');
    end
end



