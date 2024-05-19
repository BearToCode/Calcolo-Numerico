function [succ,it] = fixedpt(x0,phi,nmax,toll)
%
% [succ,it] = fixedpt(x0,phi,nmax,toll);
%
% --------Parametri di ingresso:
% x0      Punto di partenza
% phi     Funzione di punto fisso (definita inline o anonimous)
% nmax    Numero massimo di iterazioni
% toll    Tolleranza sul test d'arresto
%
% --------Parametri di uscita:
% xvect   Vett. contenente tutte le iterate calcolate
%         (l'ultima componente e' la soluzione)
% it      Iterazioni effettuate
%

succ = x0;
x = x0;
x = phi(x);
succ = [succ; x];
err =toll+1;
it =1;
while (err >= toll && it < nmax)
    xold = x;
    x = phi(x);
    succ = [succ; x];
    err = abs(x-xold);
    it = it + 1;
end

if it >= nmax
    fprintf('\n Numero massimo di iterazioni raggiunto \n\n');
end
end