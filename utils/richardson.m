function [x, k] = richardson(A, b, P, x0, toll, nmax, alpha)
    %RICHARDSON Applica il metodo di Richardson Precondizionato

    if check()
        assert(sdp(A), 'A non è simmetrica definita positiva');
    end

    k = 0;
    
    x = x0; 
    r = b - A*x;
    res_nor = norm(r) / norm(b);

    while k < nmax && res_nor > toll
        k = k + 1;
        z = P \ r;
        
        if nargin == 6 % Se ci sono solo 6 input usa il metodo dinamico(Gradiente)
            alpha = (z' * r) / (z' * A * z);
        end

        x = x + alpha*z;

        r = b - A*x; % oppure r = r - alpha * A * z;
        res_nor = norm(r) / norm(b);
    end
end

