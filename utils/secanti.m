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

    it=1;
    xvect(it)=x1;
    it=2;
    q=(fun(x1)-fun(x0))/(x1-x0);
    xvect(it)=x1-fun(x1)/q;
    err=abs(xvect(it)-xvect(it-1));
    while (it<nmax && err>toll)
        x=xvect(it);
        xold=xvect(it-1);
        it=it+1;
        q=(fun(x)-fun(xold))/(x-xold);
        xvect(it)=x-fun(x)/q;
        err=abs(xvect(it)-xvect(it-1));
    end

    if(it<nmax)
        fprintf('Convergenza al passo k: %d\n',it);
    else
        fprintf('Numero massimo di interazioni raggiunto \n');
    end
    fprintf('Radice calcolata: %f \n',xvect(end))
end



