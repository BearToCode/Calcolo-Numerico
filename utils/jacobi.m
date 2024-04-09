function [x,k] = jacobi(A,b,x0,toll,nmax)
%JACOBI Metodo iterativo di Jacobi per l'approssimazione della soluzione
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
    % z(k) = D−1r(k),
    % x(k+1) = x(k) + z(k).


    if check()
        if ~rowdiagdom(A, "strict")
            D = diag(diag(A));
            B_j = D^-1 * (D - A);
            rho = max(abs(eig(B_j)));
            assert(rho < 1, 'Il metodo non converge (raggio spettrale > 1)')
        end
    end

    k = 0;    
    D_inv = diag(1 ./ diag(A));
    x = x0;
    r = b - A*x;
    res_nor = norm(r) / norm(b);
    
    while k < nmax && res_nor > toll
        k = k + 1;
        z = D_inv * r;
        x = x + z;
        r = b - A*x;
        res_nor = norm(r) / norm(b);
    end

    if k == nmax
		warning('Jacobi - numero massimo di iterazioni raggiunto');
    end
end