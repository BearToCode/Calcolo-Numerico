function [xvect, it] = newton(x0, nmax, tol, fun, dfun, mol)
%
% [xvect, it] = newton(x0, nmax, tol, fun, dfun, mol)
%
% Metodo di newton per l'approssimazione di uno zero di una funzione
%
% Parametri di ingresso:
% x0         Vettore iniziale
% nmax       Numero massimo di iterazioni
% tol        Tolleranza
% fun        Funzione di cui si cerca lo zero
% dfun       Derivata della funzione di cui si cerca lo zero
% mol        Molteplicita' dello zero.
%
% Parametri di uscita:
% xvect      Vettore contenente tutte le iterate
%            xvect = [ x0, x1, x2, ... ] dimensione ( it + 1 )
% it         Numero di iterazioni effettuate

% warning('newton - Controlla gli indici dei vettori!');

if nargin < 6
    mol = 1;
end

it = 0;
xvect = zeros(1, nmax + 1);
xvect(1) = x0;
err = tol + 1;
prev_x = x0;

while err > tol
    if it >= nmax
        warning('newton - raggiunto il numero massimo di iterazioni')
        break;
    end
    
    it = it + 1;
    
    if dfun(prev_x) == 0
        warning('newton - derivata nulla')
        break;
    end
    
    x = prev_x - mol * fun(prev_x) / dfun(prev_x);
    err = abs(x - prev_x);
    xvect(it + 1) = x;
    prev_x = x;
end

xvect = xvect(1:it+1);
end