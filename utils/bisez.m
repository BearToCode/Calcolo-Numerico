function [xvect, it] = bisez(a, b, tol, fun)
%
% [xvect, it]=bisez(a,b,toll,fun) 
%
% Metodo di bisezione per la risoluzione
% dell'equazione non lineare f(x)=0
%
% Parametri di ingresso:
%
% a,b       Estremi intervallo di ricerca radice
% toll      Tolleranza sul test d'arresto
% f         Funzione definita come inline 
%
% Parametri di uscita:
%
% xvect     Vett. contenente tutte le iterate
%           calcolate (l'ultima componente e' la soluzione)
% it        Iterazioni effettuate

    if check()
        assert(fun(a) * fun(b) < 0, "Nessuna radice nell'intervallo dato");
    end

    it = 0;
    nmax = ceil(log2((b - a) / tol) - 1);
    xvect = zeros(1, uint8(ceil(nmax)));

    while 0.5 * (b - a) >= tol
        if it > nmax
            warning("bisez - raggiunto il numero massimo di iterazioni");
            return;
        end

        it = it + 1;
        x = (a + b) / 2;

        % Attenzione: nella teoria x0 = (a0 + b0) / 2, x1 = (a1 + b1) / 2, ...
        % fprintf("Iterazione %d: x = %f\n", it - 1, x);

        xvect(it) = x;

        if fun(x) == 0
            break;
        elseif fun(a) * fun(x) < 0
            b = x;
        else
            a = x;
        end
    end

    xvect = xvect(1:it);
end