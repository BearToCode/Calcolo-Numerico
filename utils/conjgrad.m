function [xk, pk, ak, it] = conjgrad(A,b,x0,nmax,toll)
%
% [xk,it] = conjgrad_it(A,b,x0,nmax,toll)
%
% Metodo del gradiente coniugato (non precond.) per risolvere Ax = b
%
% Parametri di ingresso:
% A          Matrice quadrata ( n x n ) del sistema lineare Ax = b
% b          Termine noto, vettore colonna
% x0         Iterata iniziale, vettore colonna
% nmax       Numero massimo di iterazioni
% toll       Tolleranza sul criterio d'arresto (residuo normalizzato)
%
% Parametri di uscita:
% xk         Matrice contenente tutte le iterate (vettori approssimanti x)
%            xk = [ x0, x1, x2, ... ] dimensione ( n x ( it + 1 ) )      
% pk         Matrice contenente tutte le direzioni coniugate
%            pk = [ p0, p1, p2, ... ] dimensione ( n x ( it + 1 ) )
% ak         Matrice contenente tutti i coefficienti alpha
%            ak = [ a0, a1, a2, ... ] dimensione ( 1 x it )
% it         Numero di iterazioni effettuate
%

    warning('conjgrad - Controlla gli indici dei vettori!');

    xk = zeros(length(x0), nmax + 1);
    pk = zeros(length(x0), nmax + 1);
    ak = zeros(1, nmax);

    x = x0;
    r = b - A*x0;
    p = r;
    xk(:, 1) = x0;
    pk(:, 1) = p;

    res_norm = norm(r) / norm(b);
    it = 0;
    while it < nmax && res_norm > toll
        it = it + 1;
        
        alpha = (p' * r) / (p' * A * p);
        x = x + alpha * p;
        r = r - alpha * A * p;
        beta = (p' * A * r) / (p' * A * p);
        p = r - beta * p;
        
        res_norm = norm(r) / norm(b);
        xk(:, it + 1) = x;
        pk(:, it + 1) = p;
        ak(it) = alpha;
    end

end