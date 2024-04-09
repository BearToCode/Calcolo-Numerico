function [x,k] = gs(A,b,x0,toll,nmax)
%GS Metodo iterativo di Gauss-Seiden per l'approssimazione della soluzione
%   A: matrice dei coefficienti
%   b: vettore termini noti
%   x0: vettore soluzione iniziale
%   toll: tolleranza criterio d'arresto
%   nmax: numero massimo di iterazioni
%
%   x: soluzione
%   k: # operazioni

    % x(0) assegnato
    % r(k) = b − Ax(k), k ≥ 0
    % T z(k) = r(k),
    % x(k+1) = x(k) + z(k)

    if check()
        if ~rowdiagdom(A, "strict") && ~sdp(A)
            D = diag(diag(A));
            E = -tril(A, -1);
            F = -triu(A, 1);
            B_gs = (D - E)^-1 * F;
            rho = max(abs(eig(B_gs)));
            assert(rho < 1, 'Il metodo non converge (raggio spettrale > 1)')
        end
    end

    k = 0;    
    x = x0;
    T = tril(A);
    r = b - A*x;
    res_nor = norm(r) / norm(b);
    
    while k < nmax && res_nor > toll
        k = k + 1;
        z = fwsub(T, r);
        x = x + z;
        r = b - A*x;
        res_nor = norm(r) / norm(b);
    end

    if k == nmax
		warning('Gauss-Seiden - numero massimo di iterazioni raggiunto');
    end
end