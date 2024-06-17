function [succ,it] = fixedpt_systems(x0, phi, nmax, toll)
% FIXEDPT_SYSTEMS: metodo del punto fisso per sistemi di equazioni
%
% [succ,it] = fixedpt_systems(x0,phi,nmax,toll);
%
% Input:
% - x0      Punto di partenza
% - phi     Funzione di punto fisso (definita inline o anonimous)
% - nmax    Numero massimo di iterazioni
% - toll    Tolleranza sul test d'arresto
%
% Output:
% - xvect   Vett. contenente tutte le iterate calcolate
%           (l'ultima componente e' la soluzione)
% - it      Iterazioni effettuate

succ = zeros(length(x0), nmax + 1);
succ(:, 1) = x0;

x          = x0;
x          = phi(x);
succ(:, 2) = x;

err  = toll+1;
it   = 1;
while (err >= toll && it < nmax)
    xold          = x;
    x             = phi(x);
    succ(:, it+1) = x;
    err           = norm(x-xold);
    
    it = it + 1;
end

succ = succ(:, 1:it);

if it >= nmax
    warning('fixedpt_systems: numero massimo di iterazioni raggiunto!');
end
end