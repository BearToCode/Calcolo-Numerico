function [xvect, it] = corde(a, b, x0, nmax, tol, fun)
%CORDE: metodo delle corde per il calcolo di radici di funzioni non lineari
%
% [xvect, it] = corde(a, b, x0, nmax, tol, fun)
%
% Parametri di ingresso:
% a          Estremo sinistro dell'intervallo
% b          Estremo destro dell'intervallo
% x0         Vettore iniziale
% nmax       Numero massimo di iterazioni
% tol        Tolleranza
% fun        Funzione di cui si cerca lo zero
%
% Parametri di uscita:
% xvect      Vettore contenente tutte le iterate
%            xvect = [ x0, x1, x2, ... ] dimensione ( it + 1 )
% it         Numero di iterazioni effettuate

    warning('corde - Controlla gli indici dei vettori!');

    it = 0;
    xvect = zeros(1, nmax + 1);
    xvect(1) = x0;
    err = tol + 1;

    while err > tol && it < nmax
        it = it + 1;
        xvect(it + 1) = xvect(it) - fun(xvect(it)) / ((fun(b)-fun(a))/(b-a));
        err = abs(xvect(it + 1) - xvect(it));
    end

    xvect = xvect(1:it+1);

    if it == nmax
        warning('corde- Numero massimo di interazioni raggiunto\n');
    end
end